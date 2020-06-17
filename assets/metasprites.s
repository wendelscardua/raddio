metasprite_0_data:

	.byte   0,  0,$00,2
	.byte   8,  0,$01,2
	.byte   8,  8,$11,2
	.byte   0,  8,$10,2
	.byte 128

metasprite_1_data:

	.byte   0,  0,$02,2
	.byte   8,  0,$03,2
	.byte   0,  8,$12,2
	.byte   8,  8,$13,2
	.byte 128

metasprite_2_data:

	.byte   0,  0,$04,2
	.byte   8,  0,$05,2
	.byte   0,  8,$14,2
	.byte   8,  8,$15,2
	.byte 128

metasprite_3_data:

	.byte   0,  0,$06,2
	.byte   8,  0,$07,2
	.byte   0,  8,$16,2
	.byte   8,  8,$17,2
	.byte 128

metasprite_pointers:

	.word metasprite_0_data
	.word metasprite_1_data
	.word metasprite_2_data
	.word metasprite_3_data
