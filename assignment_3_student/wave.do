onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /a3_testbench/traffic_controller_inst/clk
add wave -noupdate /a3_testbench/traffic_controller_inst/resetn
add wave -noupdate /a3_testbench/traffic_controller_inst/ns_green
add wave -noupdate /a3_testbench/traffic_controller_inst/ns_yellow
add wave -noupdate /a3_testbench/traffic_controller_inst/ns_red
add wave -noupdate /a3_testbench/traffic_controller_inst/ew_green
add wave -noupdate /a3_testbench/traffic_controller_inst/ew_yellow
add wave -noupdate /a3_testbench/traffic_controller_inst/ew_red
add wave -noupdate /a3_testbench/traffic_controller_inst/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {310944206 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 294
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
WaveRestoreZoom {0 ns} {1358437500 ns}
