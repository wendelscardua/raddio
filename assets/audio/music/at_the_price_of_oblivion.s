;this file for FamiTone2 library generated by text2data tool

at_the_price_of_oblivion_music_data:
	.byte 1
	.word @instruments
	.word @samples-3
	.word @song0ch0,@song0ch1,@song0ch2,@song0ch3,@song0ch4,368,307 ; New song

@instruments:
	.byte $30 ;instrument $00
	.word @env2,@env0,@env0
	.byte $00
	.byte $30 ;instrument $01
	.word @env5,@env0,@env0
	.byte $00
	.byte $30 ;instrument $02
	.word @env3,@env0,@env0
	.byte $00
	.byte $b0 ;instrument $03
	.word @env1,@env0,@env0
	.byte $00
	.byte $30 ;instrument $04
	.word @env4,@env0,@env0
	.byte $00
	.byte $70 ;instrument $05
	.word @env8,@env0,@env0
	.byte $00
	.byte $30 ;instrument $06
	.word @env1,@env0,@env0
	.byte $00
	.byte $70 ;instrument $07
	.word @env6,@env0,@env0
	.byte $00
	.byte $30 ;instrument $09
	.word @env7,@env0,@env0
	.byte $00
	.byte $30 ;instrument $0a
	.word @env1,@env0,@env0
	.byte $00
	.byte $70 ;instrument $0b
	.word @env1,@env0,@env0
	.byte $00

@samples:
@env0:
	.byte $c0,$00,$00
@env1:
	.byte $c4,$c6,$c8,$ca,$cc,$ce,$cf,$0c,$cf,$00,$08
@env2:
	.byte $cf,$cb,$c8,$c6,$c1,$c0,$00,$05
@env3:
	.byte $cf,$cf,$ce,$ce,$cd,$cc,$cc,$cb,$ca,$c9,$c8,$c7,$c6,$c5,$c4,$c2
	.byte $c0,$00,$10
@env4:
	.byte $c1,$c3,$c5,$c7,$c8,$c9,$ca,$cc,$ce,$cf,$0c,$cf,$00,$0b
@env5:
	.byte $cf,$cd,$cb,$c9,$c8,$c6,$c4,$c3,$c1,$c0,$00,$09
@env6:
	.byte $cf,$04,$ce,$cd,$cc,$cb,$cb,$ca,$c9,$c9,$c8,$c7,$c7,$c6,$c6,$c5
	.byte $c4,$c3,$02,$c2,$c1,$c1,$c0,$00,$16
@env7:
	.byte $c3,$c4,$c6,$c7,$c7,$c8,$06,$c8,$00,$07
@env8:
	.byte $ca,$04,$c9,$c9,$c8,$c7,$02,$c6,$c6,$c5,$02,$c4,$c4,$c3,$c3,$c2
	.byte $02,$c1,$02,$c0,$00,$13


; New song
@song0ch0:
	.byte $fb,$06
@ref0:
	.byte $86,$40,$9d,$38,$8d,$32,$8d
@ref1:
	.byte $3c,$9d,$36,$9d
@ref2:
	.byte $38,$9d,$32,$8d,$28,$8d
@ref3:
	.byte $36,$9d,$30,$9d
@ref4:
	.byte $32,$9d,$2a,$8d,$24,$8d
@ref5:
	.byte $28,$8d,$32,$8d,$38,$8d,$40,$8d
@ref6:
	.byte $42,$8d,$36,$8d,$38,$8d,$3c,$8d
@ref7:
	.byte $40,$ad,$3c,$8d
@ref8:
	.byte $40,$9d,$38,$8d,$32,$8d
@ref9:
	.byte $3c,$9d,$36,$8d,$40,$85,$42,$85
@ref10:
	.byte $40,$9d,$40,$8d,$46,$8d
@ref11:
	.byte $4a,$9d,$40,$9d
@ref12:
	.byte $42,$9d,$40,$8d,$3c,$8d
@ref13:
	.byte $40,$9d,$38,$9d
@ref14:
	.byte $36,$9d,$40,$9d
@ref15:
	.byte $48,$9d,$4e,$9d
@ref16:
	.byte $4a,$9d
@ref17:
	.byte $9b,$8e,$4a,$50
@ref18:
	.byte $58,$8d,$50,$85,$4a,$85,$54,$8d,$4e,$8d
@ref19:
	.byte $50,$8d,$4a,$85,$40,$85,$4e,$8d,$48,$8d
@ref20:
	.byte $4a,$8d,$42,$85,$3c,$85,$40,$85,$4a,$85,$50,$85,$58,$85
@ref21:
	.byte $5a,$85,$4e,$85,$50,$85,$54,$85,$58,$95,$54,$85
	.byte $ff,$0a
	.word @ref18
@ref23:
	.byte $58,$8d,$58,$85,$5e,$85,$62,$8d,$58,$8d
@ref24:
	.byte $5a,$8d,$58,$85,$54,$85,$58,$8d,$50,$8d
@ref25:
	.byte $4e,$8d,$58,$8d,$50,$85,$4e,$85,$4a,$8d
@ref26:
	.byte $62,$85,$66,$85,$62,$85,$68,$85,$62,$85,$66,$85,$62,$85,$60,$85
@ref27:
	.byte $62,$85,$66,$85,$62,$85,$68,$85,$5e,$85,$68,$85,$66,$85,$60,$85
	.byte $ff,$10
	.word @ref26
@ref29:
	.byte $62,$85,$66,$85,$62,$85,$68,$85,$5e,$85,$68,$85,$70,$85,$66,$85
	.byte $ff,$10
	.word @ref26
@ref31:
	.byte $62,$85,$66,$85,$62,$85,$68,$85,$62,$85,$68,$85,$66,$85,$60,$85
	.byte $ff,$10
	.word @ref26
	.byte $ff,$10
	.word @ref29
@ref34:
	.byte $92,$62,$95,$5f,$59,$62,$91,$5f,$59,$54,$81
@ref35:
	.byte $59,$5f,$59,$55,$59,$55,$51,$55,$4a,$85,$47,$4a,$85,$47,$4b,$4e
	.byte $81
@ref36:
	.byte $51,$47,$41,$47,$51,$59,$55,$51,$55,$51,$4f,$4b,$51,$4f,$4b,$46
	.byte $81
@ref37:
	.byte $4a,$85,$4e,$85,$50,$85,$54,$85,$58,$85,$5e,$85,$58,$85,$54,$85
@ref38:
	.byte $62,$5e,$59,$68,$62,$5f,$62,$5e,$59,$5e,$58,$55,$58,$54,$51,$54
	.byte $50,$4b,$50,$4a,$47,$4a,$46,$40,$81
@ref39:
	.byte $3c,$40,$47,$3c,$40,$47,$4a,$46,$41,$3c,$40,$47,$4a,$46,$41,$46
	.byte $40,$3d,$40,$3c,$41,$4a,$4e,$50,$81
@ref40:
	.byte $4a,$85,$4e,$85,$50,$85,$54,$85,$58,$85,$54,$85,$58,$85,$5e,$85
@ref41:
	.byte $58,$5e,$55,$59,$5f,$63,$5f,$59,$55,$51,$55,$59,$5f,$63,$5f,$63
	.byte $66,$81
@ref42:
	.byte $68,$95,$6c,$85,$70,$91,$77,$71,$6c,$81
@ref43:
	.byte $68,$95,$6c,$85,$70,$89,$77,$71,$6d,$69,$66,$81
@ref44:
	.byte $69,$67,$69,$67,$63,$67,$69,$71,$69,$67,$69,$67,$63,$59,$63,$66
	.byte $81
@ref45:
	.byte $69,$67,$69,$67,$63,$5b,$63,$59,$5f,$5b,$59,$5f,$5b,$59,$55,$58
	.byte $81
@ref46:
	.byte $50,$85,$4e,$85,$4a,$85,$4e,$85,$50,$85,$58,$85,$51,$4f,$4b,$40
	.byte $81
@ref47:
	.byte $50,$85,$4e,$85,$4a,$85,$4e,$85,$51,$4f,$4b,$51,$4f,$4b,$42,$85
@ref48:
	.byte $4a,$46,$4b,$4e,$4a,$4f,$50,$4e,$51,$54,$50,$55,$58,$54,$59,$5e
	.byte $58,$5f,$62,$5e,$59,$5e,$58,$54,$81
@ref49:
	.byte $58,$54,$59,$5e,$58,$5f,$62,$5e,$63,$66,$62,$67,$68,$66,$69,$6c
	.byte $68,$6d,$70,$6c,$71,$76,$70,$76,$81
@ref50:
	.byte $7a,$8d,$90,$3c,$8d,$36,$8d,$38,$8d
@ref51:
	.byte $38,$8d,$3c,$8d,$36,$8d,$38,$8d
	.byte $ff,$08
	.word @ref51
@ref53:
	.byte $40,$8d,$3c,$8d,$38,$8d,$32,$8d
	.byte $ff,$08
	.word @ref51
	.byte $ff,$08
	.word @ref51
	.byte $ff,$08
	.word @ref51
	.byte $ff,$08
	.word @ref53
@ref58:
	.byte $32,$bd
@ref59:
	.byte $32,$bd
@ref60:
	.byte $3c,$bd
@ref61:
	.byte $32,$bd
@ref62:
	.byte $8a,$62,$85,$66,$85,$62,$85,$68,$85,$62,$85,$66,$85,$62,$85,$60
	.byte $85
@ref63:
	.byte $62,$85,$66,$85,$62,$85,$68,$85,$5e,$85,$68,$85,$66,$85,$5e,$85
	.byte $ff,$10
	.word @ref26
	.byte $ff,$10
	.word @ref27
@ref66:
	.byte $62,$85,$70,$85,$68,$85,$62,$85,$6c,$85,$66,$85,$5e,$85,$66,$85
@ref67:
	.byte $6c,$85,$7a,$85,$72,$85,$6c,$85,$70,$85,$68,$85,$62,$85,$66,$85
@ref68:
	.byte $5a,$85,$68,$85,$62,$85,$5a,$85,$66,$85,$5e,$85,$70,$85,$66,$85
@ref69:
	.byte $68,$85,$62,$85,$58,$85,$62,$85,$68,$85,$62,$85,$70,$85,$68,$85
@ref70:
	.byte $94,$28,$87,$00,$32,$87,$00,$38,$83,$00,$36,$87,$00,$2e,$87,$00
	.byte $36,$83,$00
@ref71:
	.byte $36,$87,$00,$38,$87,$00,$3c,$83,$00,$38,$83,$00,$36,$83,$00,$32
	.byte $83,$00,$2e,$83,$00
@ref72:
	.byte $2a,$87,$00,$2e,$87,$00,$32,$83,$00,$2e,$83,$00,$28,$83,$00,$24
	.byte $83,$00,$28,$83,$00
@ref73:
	.byte $28,$85,$24,$00,$28,$85,$24,$00,$28,$00,$24,$00,$28,$00,$28,$00
	.byte $2e,$00,$2e,$00,$32,$00,$32,$00,$36,$00,$36,$00
@ref74:
	.byte $28,$87,$00,$32,$87,$00,$38,$83,$00,$36,$87,$00,$2e,$87,$00,$36
	.byte $83,$00
	.byte $ff,$15
	.word @ref71
@ref76:
	.byte $2a,$87,$00,$2e,$87,$00,$32,$83,$00,$2e,$87,$00,$36,$87,$00,$28
	.byte $83,$00
@ref77:
	.byte $32,$85,$2e,$00,$32,$85,$2e,$00,$32,$00,$32,$00,$32,$00,$32,$00
	.byte $32,$00,$32,$00,$32,$00,$32,$00,$32,$00,$32,$00
@ref78:
	.byte $90,$42,$9d,$4a,$9d
@ref79:
	.byte $42,$9d,$50,$8d,$4e,$8d
@ref80:
	.byte $42,$9d,$4a,$9d
@ref81:
	.byte $00,$bd
@song0ch0loop:
@ref82:
	.byte $81
	.byte $fd
	.word @song0ch0loop

; New song
@song0ch1:
@ref83:
	.byte $00,$bd
@ref84:
	.byte $bf
@ref85:
	.byte $bf
@ref86:
	.byte $bf
@ref87:
	.byte $bf
@ref88:
	.byte $bf
@ref89:
	.byte $bf
@ref90:
	.byte $bf
@ref91:
	.byte $88,$02,$bd
@ref92:
	.byte $02,$bd
@ref93:
	.byte $08,$bd
@ref94:
	.byte $0c,$9d,$12,$9d
@ref95:
	.byte $02,$bd
@ref96:
	.byte $bf
@ref97:
	.byte $08,$bd
@ref98:
	.byte $0c,$9d,$12,$9d
@ref99:
	.byte $02,$9d
@ref100:
	.byte $9f
@ref101:
	.byte $90,$40,$8d,$42,$8d,$3c,$8d,$40,$8d
@ref102:
	.byte $40,$8d,$42,$8d,$3c,$8d,$40,$8d
	.byte $ff,$08
	.word @ref102
@ref104:
	.byte $46,$8d,$42,$8d,$40,$8d,$38,$8d
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref104
@ref109:
	.byte $4a,$9d,$50,$9d
@ref110:
	.byte $4a,$9d,$50,$8d,$4e,$8d
@ref111:
	.byte $4a,$9d,$50,$9d
	.byte $ff,$06
	.word @ref110
@ref113:
	.byte $4a,$9d,$50,$9d
	.byte $ff,$06
	.word @ref110
@ref115:
	.byte $4a,$9d,$50,$9d
	.byte $ff,$06
	.word @ref110
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref104
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref104
@ref125:
	.byte $4a,$9d,$50,$9d
	.byte $ff,$06
	.word @ref110
@ref127:
	.byte $4a,$9d,$50,$9d
	.byte $ff,$06
	.word @ref110
@ref129:
	.byte $4a,$9d,$50,$9d
	.byte $ff,$06
	.word @ref110
@ref131:
	.byte $4b,$00,$99,$50,$9d
	.byte $ff,$06
	.word @ref110
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref104
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref104
@ref141:
	.byte $3c,$bd
@ref142:
	.byte $40,$bd
@ref143:
	.byte $46,$bd
@ref144:
	.byte $40,$bd
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
	.byte $ff,$08
	.word @ref102
@ref149:
	.byte $40,$9d,$3c,$9d
@ref150:
	.byte $42,$9d,$40,$9d
@ref151:
	.byte $42,$9d,$40,$9d
@ref152:
	.byte $bf
@ref153:
	.byte $94,$32,$87,$00,$38,$87,$00,$40,$83,$00,$3c,$87,$00,$36,$87,$00
	.byte $3c,$83,$00
@ref154:
	.byte $3c,$87,$00,$40,$87,$00,$42,$83,$00,$40,$83,$00,$3c,$83,$00,$38
	.byte $83,$00,$36,$83,$00
@ref155:
	.byte $32,$87,$00,$36,$87,$00,$38,$83,$00,$36,$83,$00,$32,$83,$00,$2e
	.byte $83,$00,$36,$83,$00
@ref156:
	.byte $32,$85,$2e,$00,$32,$85,$2e,$00,$32,$00,$2e,$00,$32,$00,$32,$00
	.byte $36,$00,$36,$00,$38,$00,$38,$00,$3c,$00,$3c,$00
@ref157:
	.byte $32,$87,$00,$38,$87,$00,$40,$83,$00,$3c,$87,$00,$36,$87,$00,$3c
	.byte $83,$00
	.byte $ff,$15
	.word @ref154
@ref159:
	.byte $32,$87,$00,$36,$87,$00,$38,$83,$00,$36,$87,$00,$3c,$87,$00,$36
	.byte $83,$00
@ref160:
	.byte $38,$85,$36,$00,$38,$85,$36,$00,$38,$00,$38,$00,$38,$00,$38,$00
	.byte $38,$00,$38,$00,$38,$00,$38,$00,$38,$00,$38,$00
@ref161:
	.byte $90,$50,$9d,$58,$9d
@ref162:
	.byte $50,$9d,$58,$8d,$54,$8d
@ref163:
	.byte $50,$9d,$58,$9d
@ref164:
	.byte $00,$bd
@song0ch1loop:
@ref165:
	.byte $81
	.byte $fd
	.word @song0ch1loop

; New song
@song0ch2:
@ref166:
	.byte $00,$bd
@ref167:
	.byte $bf
@ref168:
	.byte $bf
@ref169:
	.byte $bf
@ref170:
	.byte $bf
@ref171:
	.byte $bf
@ref172:
	.byte $bf
@ref173:
	.byte $bf
@ref174:
	.byte $bf
@ref175:
	.byte $bf
@ref176:
	.byte $bf
@ref177:
	.byte $bf
@ref178:
	.byte $bf
@ref179:
	.byte $bf
@ref180:
	.byte $bf
@ref181:
	.byte $bf
@ref182:
	.byte $8c,$1a,$9d
@ref183:
	.byte $9f
@ref184:
	.byte $1a,$00,$1a,$00,$33,$1a,$00,$1a,$00,$1a,$00,$33,$1a,$00,$1a,$00
	.byte $1a,$00,$33,$1a,$00,$1a,$00,$1a,$00,$33,$1a,$00
	.byte $ff,$1c
	.word @ref184
@ref186:
	.byte $20,$00,$20,$00,$39,$20,$00,$20,$00,$20,$00,$39,$20,$00,$20,$00
	.byte $20,$00,$39,$20,$00,$20,$00,$20,$00,$39,$20,$00
@ref187:
	.byte $24,$00,$24,$00,$3d,$24,$00,$24,$00,$24,$00,$3d,$24,$00,$12,$00
	.byte $12,$00,$2b,$12,$00,$12,$00,$12,$00,$2b,$12,$00
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref186
	.byte $ff,$1c
	.word @ref187
@ref192:
	.byte $12,$00,$12,$00,$2b,$12,$00,$12,$00,$12,$00,$2b,$12,$00,$1a,$00
	.byte $1a,$00,$33,$1a,$00,$1a,$00,$1a,$00,$33,$1a,$00
@ref193:
	.byte $12,$00,$12,$00,$2b,$12,$00,$12,$00,$12,$00,$2b,$12,$00,$20,$00
	.byte $20,$00,$39,$20,$00,$16,$00,$16,$00,$2f,$16,$00
	.byte $ff,$1c
	.word @ref192
	.byte $ff,$1c
	.word @ref193
	.byte $ff,$1c
	.word @ref192
	.byte $ff,$1c
	.word @ref193
	.byte $ff,$1c
	.word @ref192
	.byte $ff,$1c
	.word @ref193
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref186
	.byte $ff,$1c
	.word @ref187
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref186
	.byte $ff,$1c
	.word @ref187
	.byte $ff,$1c
	.word @ref192
	.byte $ff,$1c
	.word @ref193
	.byte $ff,$1c
	.word @ref192
	.byte $ff,$1c
	.word @ref193
	.byte $ff,$1c
	.word @ref192
	.byte $ff,$1c
	.word @ref193
	.byte $ff,$1c
	.word @ref192
	.byte $ff,$1c
	.word @ref193
@ref216:
	.byte $1a,$bd
@ref217:
	.byte $bf
@ref218:
	.byte $20,$bd
@ref219:
	.byte $24,$9d,$2a,$9d
@ref220:
	.byte $1a,$bd
@ref221:
	.byte $bf
@ref222:
	.byte $20,$bd
@ref223:
	.byte $24,$9d,$2a,$9d
@ref224:
	.byte $32,$bd
@ref225:
	.byte $bf
@ref226:
	.byte $1a,$bd
@ref227:
	.byte $bf
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref184
@ref232:
	.byte $1a,$00,$1a,$00,$33,$1a,$00,$1a,$00,$1a,$00,$33,$1a,$00,$16,$00
	.byte $16,$00,$2f,$16,$00,$16,$00,$16,$00,$2f,$16,$00
@ref233:
	.byte $24,$00,$24,$00,$3d,$24,$00,$24,$00,$24,$00,$3d,$24,$00,$1a,$00
	.byte $1a,$00,$33,$1a,$00,$1a,$00,$1a,$00,$33,$1a,$00
@ref234:
	.byte $12,$00,$12,$00,$2b,$12,$00,$12,$00,$12,$00,$2b,$12,$00,$10,$00
	.byte $10,$00,$29,$10,$00,$10,$00,$10,$00,$29,$10,$00
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref232
	.byte $ff,$1c
	.word @ref233
	.byte $ff,$1c
	.word @ref234
	.byte $ff,$1c
	.word @ref184
	.byte $ff,$1c
	.word @ref232
	.byte $ff,$1c
	.word @ref233
	.byte $ff,$1c
	.word @ref234
	.byte $ff,$1c
	.word @ref184
@ref244:
	.byte $12,$9d,$1a,$9d
@ref245:
	.byte $12,$9d,$20,$8d,$16,$8d
@ref246:
	.byte $12,$9d,$1a,$9d
@ref247:
	.byte $00,$bd
@song0ch2loop:
@ref248:
	.byte $81
	.byte $fd
	.word @song0ch2loop

; New song
@song0ch3:
@ref249:
	.byte $80,$1a,$8d,$1a,$8d,$84,$12,$8d,$80,$1a,$8d
@ref250:
	.byte $1a,$8d,$1a,$8d,$84,$12,$8d,$80,$1a,$8d
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
	.byte $ff,$08
	.word @ref250
@ref264:
	.byte $84,$13,$82,$08,$08,$05,$84,$13,$82,$08,$08,$05,$84,$13,$82,$08
	.byte $08,$05,$84,$13,$82,$08,$08,$05,$84,$13,$82,$08,$08,$84,$12,$82
	.byte $08,$08,$08
@ref265:
	.byte $84,$12,$9d
@ref266:
	.byte $9f
@ref267:
	.byte $82,$21,$80,$19,$84,$13,$80,$19,$82,$21,$80,$19,$84,$13,$80,$19
	.byte $82,$21,$80,$19,$84,$13,$80,$19,$82,$21,$80,$19,$84,$13,$12,$81
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
@ref270:
	.byte $82,$21,$80,$19,$84,$13,$80,$19,$82,$21,$80,$19,$84,$13,$80,$19
	.byte $82,$13,$08,$08,$05,$13,$08,$08,$05,$12,$08,$08,$08
@ref271:
	.byte $84,$13,$80,$19,$84,$13,$80,$19,$82,$21,$80,$19,$84,$13,$80,$19
	.byte $82,$21,$80,$19,$84,$13,$80,$19,$82,$21,$80,$19,$84,$13,$12,$81
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
	.byte $ff,$14
	.word @ref270
	.byte $ff,$11
	.word @ref271
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
	.byte $ff,$14
	.word @ref270
	.byte $ff,$11
	.word @ref271
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
@ref282:
	.byte $13,$82,$08,$08,$05,$84,$13,$82,$08,$08,$05,$84,$13,$82,$08,$08
	.byte $05,$84,$13,$82,$08,$08,$05,$84,$13,$82,$08,$08,$84,$12,$82,$08
	.byte $08,$08
@ref283:
	.byte $21,$80,$19,$84,$13,$80,$19,$82,$21,$80,$19,$84,$13,$80,$19,$82
	.byte $21,$80,$19,$84,$13,$80,$19,$82,$21,$80,$19,$84,$13,$12,$81
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
	.byte $ff,$14
	.word @ref270
	.byte $ff,$11
	.word @ref271
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
	.byte $ff,$14
	.word @ref270
	.byte $ff,$11
	.word @ref271
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
	.byte $ff,$14
	.word @ref270
	.byte $ff,$11
	.word @ref271
	.byte $ff,$11
	.word @ref267
	.byte $ff,$11
	.word @ref267
@ref298:
	.byte $13,$82,$08,$08,$05,$84,$13,$82,$08,$08,$05,$84,$13,$82,$08,$08
	.byte $05,$84,$13,$82,$08,$08,$05,$84,$13,$82,$08,$08,$92,$1a,$82,$08
	.byte $08,$08
@ref299:
	.byte $bf
@ref300:
	.byte $bf
@ref301:
	.byte $bf
@ref302:
	.byte $bf
@ref303:
	.byte $bf
@ref304:
	.byte $bf
@ref305:
	.byte $bf
@ref306:
	.byte $bf
@ref307:
	.byte $bf
@ref308:
	.byte $bf
@ref309:
	.byte $bf
	.byte $ff,$17
	.word @ref264
@ref311:
	.byte $20,$80,$1e,$18,$1e,$84,$12,$80,$1e,$18,$1e,$82,$20,$80,$1e,$18
	.byte $1e,$84,$12,$80,$1e,$18,$1e,$82,$20,$80,$1e,$18,$1e,$84,$12,$80
	.byte $1e,$18,$1e,$82,$20,$80,$1e,$18,$1e,$84,$12,$80,$1e,$84,$12,$80
	.byte $1e
@ref312:
	.byte $82,$20,$80,$1e,$18,$1e,$84,$12,$80,$1e,$18,$1e,$82,$20,$80,$1e
	.byte $18,$1e,$84,$12,$80,$1e,$18,$1e,$82,$20,$80,$1e,$18,$1e,$84,$12
	.byte $80,$1e,$18,$1e,$82,$20,$80,$1e,$18,$1e,$84,$12,$80,$1e,$84,$12
	.byte $80,$1e
	.byte $ff,$20
	.word @ref312
@ref314:
	.byte $82,$20,$80,$1e,$18,$1e,$84,$12,$80,$1e,$18,$1e,$82,$20,$80,$1e
	.byte $18,$1e,$84,$12,$80,$1e,$18,$1e,$82,$12,$80,$1e,$82,$08,$08,$04
	.byte $80,$1e,$82,$12,$80,$1e,$82,$08,$08,$04,$80,$1e,$82,$12,$08,$08
	.byte $08
	.byte $ff,$20
	.word @ref311
	.byte $ff,$20
	.word @ref312
	.byte $ff,$20
	.word @ref312
@ref318:
	.byte $84,$12,$80,$1e,$82,$08,$08,$04,$80,$1e,$84,$12,$80,$1e,$82,$08
	.byte $08,$04,$80,$1e,$84,$12,$80,$1e,$82,$08,$08,$04,$80,$1e,$84,$12
	.byte $80,$1e,$82,$08,$08,$04,$80,$1e,$84,$12,$80,$1e,$82,$08,$08,$84
	.byte $12,$82,$08,$08,$08
	.byte $ff,$20
	.word @ref311
	.byte $ff,$20
	.word @ref312
	.byte $ff,$20
	.word @ref312
	.byte $ff,$20
	.word @ref318
	.byte $ff,$20
	.word @ref311
	.byte $ff,$20
	.word @ref312
	.byte $ff,$20
	.word @ref312
	.byte $ff,$20
	.word @ref318
@ref327:
	.byte $84,$12,$bd
@ref328:
	.byte $bf
@ref329:
	.byte $bf
@ref330:
	.byte $bf
@song0ch3loop:
@ref331:
	.byte $81
	.byte $fd
	.word @song0ch3loop

; New song
@song0ch4:
@ref332:
	.byte $bf
@ref333:
	.byte $bf
@ref334:
	.byte $bf
@ref335:
	.byte $bf
@ref336:
	.byte $bf
@ref337:
	.byte $bf
@ref338:
	.byte $bf
@ref339:
	.byte $bf
@ref340:
	.byte $bf
@ref341:
	.byte $bf
@ref342:
	.byte $bf
@ref343:
	.byte $bf
@ref344:
	.byte $bf
@ref345:
	.byte $bf
@ref346:
	.byte $bf
@ref347:
	.byte $bf
@ref348:
	.byte $9f
@ref349:
	.byte $9f
@ref350:
	.byte $bf
@ref351:
	.byte $bf
@ref352:
	.byte $bf
@ref353:
	.byte $bf
@ref354:
	.byte $bf
@ref355:
	.byte $bf
@ref356:
	.byte $bf
@ref357:
	.byte $bf
@ref358:
	.byte $bf
@ref359:
	.byte $bf
@ref360:
	.byte $bf
@ref361:
	.byte $bf
@ref362:
	.byte $bf
@ref363:
	.byte $bf
@ref364:
	.byte $bf
@ref365:
	.byte $bf
@ref366:
	.byte $bf
@ref367:
	.byte $bf
@ref368:
	.byte $bf
@ref369:
	.byte $bf
@ref370:
	.byte $bf
@ref371:
	.byte $bf
@ref372:
	.byte $bf
@ref373:
	.byte $bf
@ref374:
	.byte $bf
@ref375:
	.byte $bf
@ref376:
	.byte $bf
@ref377:
	.byte $bf
@ref378:
	.byte $bf
@ref379:
	.byte $bf
@ref380:
	.byte $bf
@ref381:
	.byte $bf
@ref382:
	.byte $bf
@ref383:
	.byte $bf
@ref384:
	.byte $bf
@ref385:
	.byte $bf
@ref386:
	.byte $bf
@ref387:
	.byte $bf
@ref388:
	.byte $bf
@ref389:
	.byte $bf
@ref390:
	.byte $bf
@ref391:
	.byte $bf
@ref392:
	.byte $bf
@ref393:
	.byte $bf
@ref394:
	.byte $bf
@ref395:
	.byte $bf
@ref396:
	.byte $bf
@ref397:
	.byte $bf
@ref398:
	.byte $bf
@ref399:
	.byte $bf
@ref400:
	.byte $bf
@ref401:
	.byte $bf
@ref402:
	.byte $bf
@ref403:
	.byte $bf
@ref404:
	.byte $bf
@ref405:
	.byte $bf
@ref406:
	.byte $bf
@ref407:
	.byte $bf
@ref408:
	.byte $bf
@ref409:
	.byte $bf
@ref410:
	.byte $bf
@ref411:
	.byte $bf
@ref412:
	.byte $bf
@ref413:
	.byte $bf
@song0ch4loop:
@ref414:
	.byte $81
	.byte $fd
	.word @song0ch4loop
