.include "notes_queue.inc"

.zeropage
notes_queue: .tag Note
notes_queue_head: .res 1
notes_queue_tail: .res 1

notes_source_ptr:
notes_source_ptr_l: .res 1
notes_source_ptr_h: .res 1

.exportzp notes_queue
.exportzp notes_queue_head
.exportzp notes_queue_tail
.exportzp notes_source_ptr_l
.exportzp notes_source_ptr_h

.segment "CODE"

.export NotesQueueInit
.export NotesQueueEmpty
.export NotesQueueFull
.export NotesQueuePush
.export NotesQueuePop

.proc NotesQueueInit
  LDA #$00
  STA notes_queue_head
  STA notes_queue_tail
  RTS
.endproc

.proc NotesQueueEmpty
  ;; sets Z flag if queue is empty
  ;; cobbles A
  LDA notes_queue_head
  CMP notes_queue_tail
  RTS
.endproc

.proc NotesQueueFull
  ;; sets Z flag if queue is full
  ;; cobbles A
  LDA notes_queue_tail
  CLC
  ADC #$01
  AND #(NOTES_QUEUE_SIZE - 1)
  CMP notes_queue_head
  RTS
.endproc

.proc NotesQueuePush
  ;; pushes a note from note source
  ;; cobbles X, Y

  LDX notes_queue_tail

  LDY #$00
  LDA (notes_source_ptr), Y
  STA notes_queue+Note::release_delay, X
  INY
  LDA (notes_source_ptr), Y
  STA notes_queue+Note::columns, X
  LDA #$FF
  STA notes_queue+Note::ycoord, X

  ; increment tail
  INX
  TXA
  AND #(NOTES_QUEUE_SIZE-1)
  STA notes_queue_tail
  
  ; increment note source ptr
  RTS
.endproc

.proc NotesQueuePop
  ;; drops item from queue head
  INC notes_queue_head
  LDA notes_queue_head
  AND #(NOTES_QUEUE_SIZE-1)
  STA notes_queue_head
  RTS
.endproc
