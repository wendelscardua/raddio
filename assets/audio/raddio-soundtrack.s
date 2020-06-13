music_data_l:
  .byte <bad_apple_music_data
  .byte <at_the_price_of_oblivion_music_data
music_data_h:
  .byte >bad_apple_music_data
  .byte >at_the_price_of_oblivion_music_data

.export music_data_l
.export music_data_h

.include "./music/at_the_price_of_oblivion.s"
.include "./music/bad_apple.s"
