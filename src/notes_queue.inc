.define NOTES_QUEUE_SIZE $10
.struct Note
  release_delay .res NOTES_QUEUE_SIZE
  columns       .res NOTES_QUEUE_SIZE
  ycoord        .res NOTES_QUEUE_SIZE
.endstruct