onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /a1_testbench/clk
add wave -noupdate /a1_testbench/resetn
add wave -noupdate /a1_testbench/a
add wave -noupdate /a1_testbench/pos_edge
add wave -noupdate /a1_testbench/neg_edge
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {213 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 275
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ns} {326 ns}
