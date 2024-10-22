.include "constants.inc"
.include "header.inc"
.include "notes_queue.inc"

.feature force_range

; famitone2 config
FT_PAL_SUPPORT=0
FT_NTSC_SUPPORT=1
FT_SFX_ENABLE=1
FT_THREAD=1
FT_DPCM_ENABLE=0
FT_SFX_STREAMS=4
FT_DPCM_OFF=$c000

; music/sfx constants
.enum music_track
  BadApple = 0
  AtThePriceOfOblivion = 1
.endenum

.enum sfx
  Confirm
  Toggle
  Success
.endenum

; game config

TARGET_Y = 176
NOTE_SPEED = 2
STAR_CHARGE_PER_STAR = $10

; debug - macros for NintendulatorDX interaction
.ifdef DEBUG
.macro debugOut str
  sta $4040
  jmp :+
      .byte str, 0
:
.endmacro

.macro debugRegs
  STA debug_a
  STX debug_x
  STY debug_y
.endmacro

.define fHex8( addr ) 1, 0, <(addr), >(addr)
.define fDec8( addr ) 1, 1, <(addr), >(addr)
.define fHex16( addr ) 1, 2, <(addr), >(addr)
.define fDec16( addr ) 1, 3, <(addr), >(addr)
.else
.macro debugOut str
.endmacro
.macro debugRegs
.endmacro
.endif

.segment "ZEROPAGE"
FT_TEMP: .res 3
.segment "FAMITONE"
FT_BASE_ADR: .res 186
.segment "CODE"
.include "famitone2.s"

.segment "OAM"
.struct Sprite
  ycoord .byte
  tile .byte
  flag .byte
  xcoord .byte
.endstruct

oam_sprites:
  .repeat 64
    .tag Sprite
  .endrepeat

.zeropage

.enum game_states
  waiting_to_start
  song_selection
  song_playing
  song_finished
.endenum

.importzp buttons
.importzp last_frame_buttons
.importzp released_buttons
.importzp pressed_buttons
.importzp rle_ptr

.importzp notes_queue
.importzp notes_queue_head
.importzp notes_queue_tail
.importzp notes_source_ptr_l
.importzp notes_source_ptr_h

; zp vars
addr_ptr: .res 2 ; generic address pointer
ppu_addr_ptr: .res 2 ; temporary address for PPU_ADDR

temp_x: .res 1
temp_y: .res 1

dy: .res 1
min_dy: .res 1
input_columns: .res 1
note_columns: .res 1

nmis: .res 1
old_nmis: .res 1

game_state: .res 1

sprite_counter: .res 1

selected_song: .res 1

start_delay: .res 1

score: .res 5
stars: .res 1
star_charge: .res 1

debug_x: .res 1
debug_y: .res 1
debug_a: .res 1

grade_x: .res 1
grade_y: .res 1
grade_counter: .res 1
grade_ptr_l: .res 1
grade_ptr_h: .res 1

.segment "BSS"
; non-zp RAM goes here

.segment "CODE"

.import reset_handler
.import readjoy
.import unrle

.import NotesQueueInit
.import NotesQueueEmpty
.import NotesQueueFull
.import NotesQueuePush
.import NotesQueuePop

.import music_data_l
.import music_data_h
.import sfx_data

.macro KIL ; pseudo instruction to kill the program
  .byte $12
.endmacro

.macro VBLANK
  .local vblankwait
vblankwait:
  BIT PPUSTATUS
  BPL vblankwait
.endmacro

.macro save_regs
  PHA
  TXA
  PHA
  TYA
  PHA
.endmacro

.macro restore_regs
  PLA
  TAY
  PLA
  TAX
  PLA
.endmacro

.proc irq_handler
  RTI
.endproc

.proc nmi_handler
  save_regs

  ; Fix Scroll
  LDA PPUSTATUS
  LDA #$20
  STA PPUADDR
  LDA #$00
  STA PPUADDR
  LDA #$00 ; horizontal scroll
  STA PPUSCROLL
  STA PPUSCROLL

  ; Refresh OAM
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
  restore_regs

  INC nmis
  RTI
.endproc

.export main
.proc main
  SEI         ; ignore IRQs
  CLD         ; disable decimal mode
  LDX #$40
  STX $4017   ; disable APU frame IRQ
  LDX #$ff
  TXS         ; Set up stack
  INX         ; now X = 0
  STX PPUCTRL ; disable NMI
  STX PPUMASK ; disable rendering
  STX $4010   ; disable DMC IRQs

  LDX #0
clear_ram:
  LDA #$00
  STA $0000,X
  STA $0100,X
  STA $0300,X
  STA $0400,X
  STA $0500,X
  STA $0600,X
  STA $0700,X
  LDA #$fe
  STA $0200,X
  INX
  BNE clear_ram

  ; load palettes
  JSR load_palettes

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

  LDX #0
  LDA music_data_h, X
  TAY
  LDA music_data_l, X
  TAX
  LDA #1
  JSR FamiToneInit

  ; init FamiTone SFX
  LDX #<sfx_data
  LDY #>sfx_data
  LDA #1
  JSR FamiToneSfxInit

  JSR go_to_title

forever:
  LDA nmis
  CMP old_nmis
  BEQ etc
  STA old_nmis
  ; new frame code
  JSR game_state_handler
  JSR FamiToneUpdate
  JSR fill_notes_queue

etc:
  JMP forever
.endproc

.proc load_palettes
  ; cobbles Y
  LDY PPUSTATUS
  LDY #$3f
  STY PPUADDR
  LDY #$00
  STY PPUADDR
:
  LDA palettes,Y
  STA PPUDATA
  INY
  CPY #$20
  BNE :-
  RTS
.endproc

.proc print_hex
  CMP #$0A
  BCS :+
  CLC
  ADC #$10
  STA PPUDATA
  RTS
:
  ADC #$36
  STA PPUDATA
  RTS
.endproc

.macro print string
  LDA #<string
  STA addr_ptr
  LDA #>string
  STA addr_ptr+1
  JSR write_tiles
.endmacro

; these act like printf, displaying the corresponding digit instead
WRITE_X_SYMBOL = $FE

LINEBREAK_SYMBOL = $0A

.proc write_tiles
  ; write tiles on background
  ; addr_ptr - point to string starting point (strings end with $00)
  ; ppu_addr_ptr - PPU target
  ; When the tile is #WRITE_X_SYMBOL, the current value for X
  ; is written instead (e.g. '2' tile for X = 2)
  LDA PPUSTATUS
  LDA ppu_addr_ptr+1
  STA PPUADDR
  LDA ppu_addr_ptr
  STA PPUADDR
  LDY #0
writing_loop:
  LDA (addr_ptr), Y
  BEQ exit
  CMP #LINEBREAK_SYMBOL
  BNE :+
  LDA #$20
  CLC
  ADC ppu_addr_ptr
  STA ppu_addr_ptr
  LDA #$00
  ADC ppu_addr_ptr+1
  STA ppu_addr_ptr+1
  STA PPUADDR
  LDA ppu_addr_ptr
  STA PPUADDR
:
  CMP #WRITE_X_SYMBOL
  BNE write_tile
  TXA
  JSR print_hex
  JMP next
write_tile:
  STA PPUDATA
next:
  INY
  JMP writing_loop
exit:
  RTS
.endproc

.proc game_state_handler
  ; Uses RTS Trick
  LDX game_state
  LDA game_state_handlers_h, X
  PHA
  LDA game_state_handlers_l, X
  PHA
  RTS
.endproc

.proc go_to_title
  LDA #game_states::waiting_to_start
  STA game_state

  LDA #$00
  STA PPUCTRL ; disable NMI
  STA PPUMASK ; disable rendering

  LDA PPUSTATUS
  LDA #$20
  STA PPUADDR
  LDA #$00
  STA PPUADDR

  LDA #<nametable_title
  STA rle_ptr
  LDA #>nametable_title
  STA rle_ptr+1
  JSR unrle

  VBLANK

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

  RTS
.endproc

.proc play_selected_song
  LDA #$00
  STA PPUCTRL ; disable NMI
  STA PPUMASK ; disable rendering

  LDA PPUSTATUS
  LDA #$20
  STA PPUADDR
  LDA #$00
  STA PPUADDR

  LDA #<nametable_main
  STA rle_ptr
  LDA #>nametable_main
  STA rle_ptr+1
  JSR unrle

  VBLANK

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

  LDX selected_song
  LDA music_data_h, X
  TAY
  LDA music_data_l, X
  TAX
  LDA #1
  JSR FamiToneInit

  ; init FamiTone SFX
  LDX #<sfx_data
  LDY #>sfx_data
  LDA #1
  JSR FamiToneSfxInit

  LDX selected_song
  LDA music_notes_data_pointers_l, X
  STA notes_source_ptr_l
  LDA music_notes_data_pointers_h, X
  STA notes_source_ptr_h

  JSR NotesQueueInit

  JSR fill_notes_queue

  LDA #game_states::song_playing
  STA game_state

  LDA #(TARGET_Y / NOTE_SPEED)
  STA start_delay

  LDA #$00
  STA score
  STA score+1
  STA score+2
  STA score+3
  STA score+4
  STA stars
  STA star_charge
  STA grade_counter
  RTS
.endproc

.proc fill_notes_queue
loop:
  JSR NotesQueueFull
  BEQ exit_loop
  JSR NotesQueuePush
  BEQ exit_loop
  JMP loop
exit_loop:
  RTS
.endproc

.proc waiting_to_start
  JSR readjoy
  LDA pressed_buttons
  AND #BUTTON_START
  BEQ :+
  LDA #sfx::Confirm
  LDX #FT_SFX_CH0
  JSR FamiToneSfxPlay
  JSR go_to_song_selection
:
  RTS
.endproc

.proc go_to_song_selection
  LDA #game_states::song_selection
  STA game_state

  LDA #music_track::BadApple
  STA selected_song

  LDA #$00
  STA PPUCTRL ; disable NMI
  STA PPUMASK ; disable rendering

  LDA PPUSTATUS
  LDA #$20
  STA PPUADDR
  LDA #$00
  STA PPUADDR

  LDA #<nametable_songs
  STA rle_ptr
  LDA #>nametable_songs
  STA rle_ptr+1
  JSR unrle

  VBLANK

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

  RTS
.endproc

.proc finish_song
  JSR FamiToneMusicStop

  LDA #game_states::song_finished
  STA game_state


  LDA #$00
  STA PPUCTRL ; disable NMI
  STA PPUMASK ; disable rendering

  LDA PPUSTATUS
  LDA #$20
  STA PPUADDR
  LDA #$00
  STA PPUADDR

  LDA #<nametable_finished
  STA rle_ptr
  LDA #>nametable_finished
  STA rle_ptr+1
  JSR unrle

  LDA PPUSTATUS
  LDA #$23
  STA PPUADDR
  LDA #$69
  STA PPUADDR

  LDA score
  STA PPUDATA
  LDA score+1
  STA PPUDATA
  LDA score+2
  STA PPUDATA
  LDA score+3
  STA PPUDATA
  LDA score+4
  STA PPUDATA

  LDA #$23
  STA PPUADDR
  LDA #$72
  STA PPUADDR

  LDX #$00
  LDA #$64 ; filled star tile
:
  CPX stars
  BEQ :+
  STA PPUDATA
  INX
  JMP :-
:
  LDA #$6A ; empty star tile
:
  CPX #5
  BEQ :+
  STA PPUDATA
  INX
  JMP :-
:

  VBLANK

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

  LDA #sfx::Success
  LDX #FT_SFX_CH2
  JSR FamiToneSfxPlay

  RTS
.endproc

.proc song_selection
  ; input
  JSR readjoy

  LDA pressed_buttons
  AND #BUTTON_UP
  BEQ :+
  LDA #music_track::AtThePriceOfOblivion
  STA selected_song
  LDA #sfx::Toggle
  LDX #FT_SFX_CH1
  JSR FamiToneSfxPlay
:
  LDA pressed_buttons
  AND #BUTTON_DOWN
  BEQ :+
  LDA #music_track::BadApple
  STA selected_song
  LDA #sfx::Toggle
  LDX #FT_SFX_CH1
  JSR FamiToneSfxPlay

:
  LDA pressed_buttons
  AND #(BUTTON_START | BUTTON_SELECT | BUTTON_A)
  BEQ :+

  LDA #sfx::Confirm
  LDX #FT_SFX_CH1
  JSR FamiToneSfxPlay

  JSR play_selected_song
  RTS
:

  ; draw cursor
  LDA #00
  STA sprite_counter

  LDA nmis
  AND #%10000
  CLC
  ADC #$74
  STA temp_y

  LDA #$90
  STA temp_x

  LDA selected_song
  CMP #music_track::BadApple

  BNE @atpo
@bad_apple:
  LDA #<note_3_sprite
  STA addr_ptr
  LDA #>note_3_sprite
  STA addr_ptr+1
  JMP @draw
@atpo:
  LDA #<note_2_sprite
  STA addr_ptr
  LDA #>note_2_sprite
  STA addr_ptr+1
@draw:
  save_regs
  JSR display_metasprite
  restore_regs

  RTS
.endproc

.proc song_playing
  LDA start_delay
  BEQ skip_play
  DEC start_delay
  BNE skip_play
  LDA #$00
  JSR FamiToneMusicPlay
skip_play:
  LDA PPUSTATUS
  LDA #$23
  STA PPUADDR
  LDA #$69
  STA PPUADDR

  LDA score
  STA PPUDATA
  LDA score+1
  STA PPUDATA
  LDA score+2
  STA PPUDATA
  LDA score+3
  STA PPUDATA
  LDA score+4
  STA PPUDATA

  LDA #$23
  STA PPUADDR
  LDA #$72
  STA PPUADDR

  LDX #$00
  LDA #$64 ; filled star tile
:
  CPX stars
  BEQ :+
  STA PPUDATA
  INX
  JMP :-
:
  LDA #$6A ; empty star tile
:
  CPX #5
  BEQ :+
  STA PPUDATA
  INX
  JMP :-
:

  LDA #$20
  STA PPUADDR
  LDA #$00
  STA PPUADDR
  STA PPUSCROLL
  STA PPUSCROLL

  JSR NotesQueueEmpty

  BNE update_notes

  JSR finish_song
  RTS

  update_notes:
  ; update notes
  ; - from the queue head, look for the first note with delay
  ;   - meanwhile, if note has no delay, move it down
  ;     - if past the screen, dequeue it
  ; - take the note with delay, then decrement it
  ;   - then if zeroed, put sprite at the top

  LDX notes_queue_head
@loop:
  CPX notes_queue_tail
  BEQ @exit_loop

  LDA notes_queue+Note::release_delay, X
  BEQ @move_note

  DEC notes_queue+Note::release_delay, X
  BNE @exit_loop
  LDA #$00
  STA notes_queue+Note::ycoord, X
  JMP @exit_loop

@move_note:
  LDA notes_queue+Note::ycoord, X
  CLC
  ADC #NOTE_SPEED
  STA notes_queue+Note::ycoord, X
@next:
  INX
  CPX #NOTES_QUEUE_SIZE
  BNE @loop
  LDX #$00
  JMP @loop
@exit_loop:
  ; dequeue if head note passed bottom
  LDX notes_queue_head
  LDA notes_queue+Note::ycoord, X
  CMP #$FF
  BEQ :+
  CMP #$F1
  BCC :+
  JSR NotesQueuePop
:

  draw_notes_loop:
  LDA #$00
  STA sprite_counter

  ; draw grade
  JSR draw_grade

  ; draw visible notes
  LDX notes_queue_head
@loop:
  CPX notes_queue_tail
  BEQ @exit_loop

  LDA notes_queue+Note::ycoord, X
  CMP #$FF
  BEQ @exit_loop

  JSR draw_notes

@next:
  INX
  CPX #NOTES_QUEUE_SIZE
  BNE @loop
  LDX #$00
  JMP @loop
@exit_loop:

  ; erase old sprites
  LDX sprite_counter
  LDA #$F0
:
  STA oam_sprites+Sprite::ycoord, X
  .repeat .sizeof(Sprite)
  INX
  .endrepeat
  BNE :-

  player_input:

  JSR readjoy
  LDA pressed_buttons
  BNE :+
  RTS
:
  AND #(BUTTON_UP|BUTTON_DOWN|BUTTON_LEFT|BUTTON_RIGHT)
  BEQ :+
  JSR song_playing_arrow_input
:

  RTS
.endproc

.proc song_playing_arrow_input
  ; during song playing, checks if input happened around a notes row
  ; if so, score according to how close they matched
  ; then the matched note is erased

  ; first, bail out if queue is empty
  JSR NotesQueueEmpty
  BNE :+
  RTS
:

  ; guard clause
  LDY notes_queue_tail

  ; the currently minimum y distance between a notes row and the target Y
  LDA #$7F
  STA min_dy

  ; iterate over visible notes, store closest match index in Y
  LDX notes_queue_head
@loop:
  CPX notes_queue_tail
  BEQ @exit_loop

  ; notes on queue are ordered; first, the released ones, then the unreleased
  ; if we found an unreleased, we can bail out of the loop
  LDA notes_queue+Note::release_delay, X
  BNE @exit_loop

  ; skip invisible notes
  LDA notes_queue+Note::columns, X
  BEQ @next

  ; A := abs(ycoord - target_y)
  LDA notes_queue+Note::ycoord, X
  SEC
  SBC #TARGET_Y
  BCS :+
  EOR #$FF
  ADC #$01
:
  STA dy

  ; too far, ignore match
  CMP #$20
  BCS @next

  ; not better than previous match
  CMP min_dy
  BCS @next

  STA min_dy
  TXA
  TAY

@next:
  INX
  CPX #NOTES_QUEUE_SIZE
  BNE @loop
  LDX #$00
  JMP @loop
@exit_loop:

  ; no match
  CPY notes_queue_tail
  BNE :+
  RTS
:

  LDA notes_queue+Note::columns, Y
  STA note_columns

  ; delete note
  LDA #$00
  STA notes_queue+Note::columns, Y ; now Y is unused here

  ;;; match, score based on how close it was

  ; get score per half dy index
  LDA min_dy
  LSR
  TAX

  ; check if input matches
  LDA #$00
  STA input_columns
  LDA pressed_buttons
  AND #BUTTON_LEFT
  BEQ :+
  LDA #%1000
  ORA input_columns
  STA input_columns
:
  LDA pressed_buttons
  AND #BUTTON_UP
  BEQ :+
  LDA #%0100
  ORA input_columns
  STA input_columns
:
  LDA pressed_buttons
  AND #BUTTON_DOWN
  BEQ :+
  LDA #%0010
  ORA input_columns
  STA input_columns
:
  LDA pressed_buttons
  AND #BUTTON_RIGHT
  BEQ :+
  LDA #%0001
  ORA input_columns
  STA input_columns
:
  LDA input_columns
  CMP note_columns

  BEQ @good_match
@bad_match:  
  LDA #$00
  STA stars
  STA star_charge
  save_regs
  LDA #$00 ; miss grade
  JSR trigger_grade
  restore_regs
  LDA score_per_half_dy_when_wrong, X
  JMP @add_score
@good_match:
  save_regs
  LDA grade_per_half_dy, X
  JSR trigger_grade
  restore_regs
  LDA starness_per_half_dy, X
  BEQ @decrease_stars
@increase_stars:
  JSR increase_stars
  JMP @load_good_score
@decrease_stars:
  JSR decrease_stars
@load_good_score:
  LDA score_per_half_dy, X

  LDY stars
  CPY #3
  BCC :+
  ASL ; stars >= 3 -> double score
:
  CPY #5
  BNE :+
  ASL ; stars = 5 -> double score
:

@add_score:
  CLC
  ADC score+4
  STA score+4
  LDX #4
@score_carry_loop:
  LDA score, X
  CMP #10
  BCC @next_digit
  SEC
  SBC #10
  STA score, X
  INC score-1, X
  JMP @score_carry_loop
@next_digit:
  DEX
  BPL @score_carry_loop

  RTS
.endproc

.proc increase_stars
  LDA stars
  CMP #5
  BNE :+
  RTS
:
  LDA star_charge
  CMP #(STAR_CHARGE_PER_STAR-1)
  BEQ :+
  INC star_charge
  RTS
:
  LDA #$00
  STA star_charge
  INC stars
  RTS
.endproc

.proc decrease_stars
  LDA stars
  BEQ :+
  DEC stars
:
  LDA #$00
  STA star_charge
  RTS
.endproc

.proc draw_grade
  ;; draw current grade on screen
  LDA grade_counter
  BNE :+
  RTS
:
  DEC grade_counter
  DEC grade_y
  LDA grade_y
  STA temp_y
  LDA grade_x
  STA temp_x
  LDA grade_ptr_l
  STA addr_ptr
  LDA grade_ptr_h
  STA addr_ptr+1
  save_regs
  JSR display_metasprite
  restore_regs

  RTS
.endproc

.proc trigger_grade
  ;; set up grade to appear for a few frames
  ;; input X = grade index (0 = miss, 1 = bad, 2 = good, 3 = great)
  ;; cobbles X
  TAX
  LDA grade_sprite_per_grade_l, X
  STA grade_ptr_l
  LDA grade_sprite_per_grade_h, X
  STA grade_ptr_h
  LDX note_columns
  LDA grade_x_position_per_note, X
  STA grade_x
  LDA #(TARGET_Y - 16)
  STA grade_y
  LDA #$10
  STA grade_counter
  RTS
.endproc

.proc draw_notes
  ;; draw current note on screen
  ;; input X = position in notes queue
  ;;       A = y position
  STA temp_y

  ; draw note 1
  LDA notes_queue+Note::columns, X
  AND #%1000
  BEQ :+
  LDA #$48
  STA temp_x
  LDA #<note_1_sprite
  STA addr_ptr
  LDA #>note_1_sprite
  STA addr_ptr+1

  save_regs
  JSR display_metasprite
  restore_regs
:
  ; draw note 2
  LDA notes_queue+Note::columns, X
  AND #%0100
  BEQ :+
  LDA #$68
  STA temp_x
  LDA #<note_2_sprite
  STA addr_ptr
  LDA #>note_2_sprite
  STA addr_ptr+1

  save_regs
  JSR display_metasprite
  restore_regs
:
  ; draw note 3
  LDA notes_queue+Note::columns, X
  AND #%0010
  BEQ :+
  LDA #$88
  STA temp_x
  LDA #<note_3_sprite
  STA addr_ptr
  LDA #>note_3_sprite
  STA addr_ptr+1

  save_regs
  JSR display_metasprite
  restore_regs
:
  ; draw note 4
  LDA notes_queue+Note::columns, X
  AND #%0001
  BEQ :+
  LDA #$A8
  STA temp_x
  LDA #<note_4_sprite
  STA addr_ptr
  LDA #>note_4_sprite
  STA addr_ptr+1

  save_regs
  JSR display_metasprite
  restore_regs
:
  RTS
.endproc

.proc song_finished
  JSR waiting_to_start
  RTS
.endproc

.proc display_metasprite
  ; input: (addr_ptr) = metasprite pointer
  ;        temp_x and temp_y = screen position for metasprite origin
  ; cobbles X, Y
  LDY #0
  LDX sprite_counter
loop:
  LDA (addr_ptr),Y ; delta x
  CMP #128
  BEQ return
  INY
  CLC
  ADC temp_x
  STA oam_sprites+Sprite::xcoord,X
  LDA (addr_ptr),Y ; delta y
  INY
  SEC
  SBC #$01
  CLC
  ADC temp_y
  STA oam_sprites+Sprite::ycoord,X
  LDA (addr_ptr),Y ; tile
  INY
  STA oam_sprites+Sprite::tile,X
  LDA (addr_ptr),Y ; flags
  INY
  STA oam_sprites+Sprite::flag,X
  .repeat .sizeof(Sprite)
  INX
  .endrepeat
  JMP loop
return:
  STX sprite_counter
  RTS
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"

game_state_handlers_l:
  .byte <(waiting_to_start-1)
  .byte <(song_selection-1)
  .byte <(song_playing-1)
  .byte <(song_finished-1)

game_state_handlers_h:
  .byte >(waiting_to_start-1)
  .byte >(song_selection-1)
  .byte >(song_playing-1)
  .byte >(song_finished-1)

palettes:
.incbin "../assets/bg-palettes.pal"
.incbin "../assets/sprite-palettes.pal"

sprites:
.include "../assets/metasprites.s"

note_1_sprite = metasprite_0_data
note_2_sprite = metasprite_1_data
note_3_sprite = metasprite_2_data
note_4_sprite = metasprite_3_data
great_grade_sprite = metasprite_4_data
good_grade_sprite = metasprite_5_data
bad_grade_sprite = metasprite_6_data
miss_grade_sprite = metasprite_7_data

strings:
        ; TODO put strings here if needed

nametable_title: .incbin "../assets/nametables/title.rle"
nametable_songs: .incbin "../assets/nametables/songs.rle"
nametable_main: .incbin "../assets/nametables/main.rle"
nametable_finished: .incbin "../assets/nametables/finished.rle"

music_notes_data_pointers_l:
  .byte <music_notes_for_bad_apple
  .byte <music_notes_for_at_the_price_of_oblivion

music_notes_data_pointers_h:
  .byte >music_notes_for_bad_apple
  .byte >music_notes_for_at_the_price_of_oblivion

music_notes_for_bad_apple: .incbin "../assets/notes/bad_apple.notes.bin"

music_notes_for_at_the_price_of_oblivion: .incbin "../assets/notes/at_the_price_of_oblivion.notes.bin"

score_per_half_dy:
  ;      [--- great------]   [--- good ------]   [--- bad -------]   [--- miss -----------]
  ;      00,  01,  02,  03,  04,  05,  06,  07,  08,  09,  0A,  0B,  0C,  0D,  0E , 0F,  10
  .byte $0A, $0A, $0A, $0A, $05, $05, $05, $05, $01, $01, $01, $01, $00, $00, $00, $00, $00
score_per_half_dy_when_wrong:
  ;      [--- great------]   [--- good ------]   [--- bad -------]   [--- miss -----------]
  ;      00,  01,  02,  03,  04,  05,  06,  07,  08,  09,  0A,  0B,  0C,  0D,  0E , 0F,  10
  .byte $02, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
starness_per_half_dy:
  ;      [--- great------]   [--- good ------]   [--- bad -------]   [--- miss -----------]
  ;      00,  01,  02,  03,  04,  05,  06,  07,  08,  09,  0A,  0B,  0C,  0D,  0E , 0F,  10
  .byte $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
grade_per_half_dy:
  ;      [--- great------]   [--- good ------]   [--- bad -------]   [--- miss -----------]
  ;      00,  01,  02,  03,  04,  05,  06,  07,  08,  09,  0A,  0B,  0C,  0D,  0E , 0F,  10
  .byte $03, $03, $03, $03, $02, $02, $02, $02, $01, $01, $01, $01, $00, $00, $00, $00, $00

grade_sprite_per_grade_l:
  .byte <miss_grade_sprite
  .byte <bad_grade_sprite
  .byte <good_grade_sprite
  .byte <great_grade_sprite

grade_sprite_per_grade_h:
  .byte >miss_grade_sprite
  .byte >bad_grade_sprite
  .byte >good_grade_sprite
  .byte >great_grade_sprite

grade_x_position_per_note:
  .byte $00 ; 0000
  .byte $A8 ; 0001 - r
  .byte $88 ; 0010 - d
  .byte $00 ; 0011
  .byte $68 ; 0100 - u
  .byte $00 ; 0101
  .byte $00 ; 0110
  .byte $00 ; 0111
  .byte $48 ; 1000 - l
  .byte $00 ; 1001
  .byte $00 ; 1010
  .byte $00 ; 1011
  .byte $00 ; 1100
  .byte $00 ; 1101
  .byte $00 ; 1110
  .byte $00 ; 1111

.segment "CHR"
.incbin "../assets/graphics.chr"
