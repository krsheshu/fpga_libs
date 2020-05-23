onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/clkA
add wave -noupdate /test/clkB
add wave -noupdate /test/A
add wave -noupdate /test/B
add wave -noupdate /test/dut/clkA
add wave -noupdate /test/dut/wordA
add wave -noupdate /test/dut/clkB
add wave -noupdate /test/dut/sync_wordB
add wave -noupdate /test/dut/gray_wordA
add wave -noupdate /test/dut/reg_gray_wordA
add wave -noupdate /test/dut/sync_gray_wordB
add wave -noupdate /tb_sv_unit::run_nS/run_nS
add wave -noupdate /tb_sv_unit::run_nS/time_innS
add wave -noupdate /tb_sv_unit::run_uS/run_uS
add wave -noupdate /tb_sv_unit::run_uS/time_inuS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1158 ns} 0}
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
WaveRestoreZoom {1154 ns} {1174 ns}
