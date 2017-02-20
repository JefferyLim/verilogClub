onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /a2_testbench/clk
add wave -noupdate /a2_testbench/resetn
add wave -noupdate /a2_testbench/errors
add wave -noupdate -radix hexadecimal /a2_testbench/address
add wave -noupdate -radix hexadecimal /a2_testbench/write_enable
add wave -noupdate -radix hexadecimal /a2_testbench/write_data
add wave -noupdate -radix hexadecimal /a2_testbench/read_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1022 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {803 ns} {1085 ns}
