metasprite_0_data:

	.byte   0,  0,$00,2
	.byte   8,  0,$01,2
	.byte   8,  8,$11,2
	.byte   0,  8,$10,2
	.byte 128

metasprite_1_data:

	.byte   0,  0,$02,1
	.byte   8,  0,$03,1
	.byte   0,  8,$12,1
	.byte   8,  8,$13,1
	.byte 128

metasprite_2_data:

	.byte   0,  0,$04,3
	.byte   8,  0,$05,3
	.byte   0,  8,$14,3
	.byte   8,  8,$15,3
	.byte 128

metasprite_3_data:

	.byte   0,  0,$06,0
	.byte   8,  0,$07,0
	.byte   0,  8,$16,0
	.byte   8,  8,$17,0
	.byte 128

metasprite_pointers:

	.word metasprite_0_data
	.word metasprite_1_data
	.word metasprite_2_data
	.word metasprite_3_data
