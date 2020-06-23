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

metasprite_4_data:

	.byte - 2,  0,$21,2
	.byte   6,  0,$22,2
	.byte  14,  0,$23,2
	.byte 128

metasprite_5_data:

	.byte   0,  0,$31,1
	.byte   8,  0,$32,1
	.byte  16,  0,$33,1
	.byte 128

metasprite_6_data:

	.byte   1,  0,$41,0
	.byte   9,  0,$42,0
	.byte 128

metasprite_7_data:

	.byte   0,  0,$51,3
	.byte   8,  0,$52,3
	.byte 128

metasprite_pointers:

	.word metasprite_0_data
	.word metasprite_1_data
	.word metasprite_2_data
	.word metasprite_3_data
	.word metasprite_4_data
	.word metasprite_5_data
	.word metasprite_6_data
	.word metasprite_7_data

