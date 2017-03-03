onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sm_testbench/sm_inst/clk
add wave -noupdate /sm_testbench/sm_inst/resetn
add wave -noupdate /sm_testbench/sm_inst/a
add wave -noupdate /sm_testbench/sm_inst/b
add wave -noupdate /sm_testbench/sm_inst/c
add wave -noupdate /sm_testbench/sm_inst/state
add wave -noupdate /sm_testbench/sm_inst/control_1
add wave -noupdate /sm_testbench/sm_inst/control_2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {90 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
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
WaveRestoreZoom {38 ns} {156 ns}
