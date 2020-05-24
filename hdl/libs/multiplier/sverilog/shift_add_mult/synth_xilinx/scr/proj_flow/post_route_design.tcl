############## post_route_design.tcl ##################
report_route_status   -file   $outputDir/post_route_status.rpt
report_timing_summary -file   $outputDir/post_route_timing_summary.rpt
report_power          -file   $outputDir/post_route_power.rpt
report_drc            -file   $outputDir/post_imp_drc.rpt
write_verilog         -force  $outputDir/output_netlist.v -mode timesim -sdf_anno true
