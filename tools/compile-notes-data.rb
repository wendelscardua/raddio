#!/usr/bin/ruby
# frozen_string_literal: true

# Input format:
# ------------
# speed tempo
# tracker-frame (hex) tracker-row (hex) notes (base 2)
# Example:
# 6 135
# 01 10 1000
# ...
# 0F 23 1010
# ..
# 24 3F 1100
#
# Helper commands inside input:
# ----------------------------
# Repeat command: frame_b = frame_a
#  - causes frame_b to use the same notes as frame_a
#
# Output binary format:
# --------------------
# delta-frame-count: .byte
# columns-mask: .byte
# (ends with delta frame zero)

# Speed calculation
# BPM = Tempo * 6 / Speed
# (3600 frames/min) / (X frames/row * 4 row/beat) = BPM beat/min
# 900/x beats/min = BPM beats/min
# x = 900/BPM = 900 * Speed / (Tempo * 6) = 150 * Speed / Tempo

MASK_ALIAS = {
  'u' => '0100',
  'd' => '0010',
  'l' => '1000',
  'r' => '0001',
  'ul' => '1100',
  'dr' => '0011'
}.freeze

def main
  input_filename = ARGV[0]
  output_filename = ARGV[1] || "#{input_filename}.bin"
  File.open(input_filename, 'r') do |input|
    header = input.readline
    (speed, tempo) = header.split(/ /).map(&:to_r)

    bpm = tempo * 6r / speed

    puts "Input file BPM: #{bpm}"

    frames_per_row = 900r / bpm

    puts "Frames per row: #{frames_per_row}"

    input_queue = input.readlines.map(&:chomp).reject { |line| line == '' }

    frame_history = {}

    last_frame = 0
    File.open(output_filename, 'wb') do |output|
      while (input_line = input_queue.shift)
        (tracker_frame, tracker_row, mask) = input_line.split(/ /)
        if tracker_row == '='
          # then mask contains source tracker frame
          repeat_lines = frame_history[mask].map { |data| "#{tracker_frame} #{data[0]} #{data[1]}" }
          input_queue.unshift(*repeat_lines)
          next
        end
        (frame_history[tracker_frame] ||= []).push [tracker_row, mask]
        tracker_frame = tracker_frame.to_i(16)
        tracker_row = tracker_row.to_i(16)
        mask = MASK_ALIAS.fetch(mask, mask).to_i(2)

        target_frame = ((tracker_frame * 0x40 + tracker_row) * frames_per_row).round

        delay = target_frame - last_frame

        while delay > 60
          output.putc 60
          output.putc 0
          delay -= 60
        end

        output.putc delay.to_i
        output.putc mask

        last_frame = target_frame
      end
      output.putc 0
    end
  end
end

main
