onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /test/dut/clk
add wave -noupdate -radix unsigned /test/dut/start
add wave -noupdate -radix binary /test/dut/A
add wave -noupdate -radix binary /test/dut/B
add wave -noupdate -radix unsigned /test/dut/done
add wave -noupdate -radix binary /test/dut/product
add wave -noupdate /test/dut/A_unsigned
add wave -noupdate /test/dut/B_unsigned
add wave -noupdate -radix unsigned /test/dut/multcounter
add wave -noupdate -radix unsigned /test/dut/adden
add wave -noupdate -radix binary /test/dut/adderRes
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1346 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {791 ns} {3283 ns}
