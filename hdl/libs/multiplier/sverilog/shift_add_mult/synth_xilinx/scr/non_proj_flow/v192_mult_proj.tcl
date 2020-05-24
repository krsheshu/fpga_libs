#------------------------------------------------------------------
# Setting project paths and output directory
#------------------------------------------------------------------
set TOP       $::env(TOP)
set synthDir  [file dirname [file normalize [info script]]]/../..
set srcDir    $synthDir/..
set constrDir $synthDir/constraints
set scrDir    $synthDir/scr

set outputDir $synthDir/builds

file delete -force  $outputDir
file mkdir          $outputDir

#------------------------------------------------------------------
# Sourcing additional scripts
#------------------------------------------------------------------

source -notrace $scrDir/reportCriticalPaths.tcl

#------------------------------------------------------------------
# Adding the design sources
#------------------------------------------------------------------

read_verilog  [glob $srcDir/*.sv]
read_xdc      $constrDir/constraints.xdc

#------------------------------------------------------------------
# Synthesis design and write checkpoint
#------------------------------------------------------------------

synth_design -top $TOP  -part xczu4cg-sfvc784-1-e
write_checkpoint -force $outputDir/post_synth.dcp

report_timing_summary   -file $outputDir/post_synth_timing_summary.rpt
report_utilization      -file $outputDir/post_synth_util.rpt
reportCriticalPaths     $outputDir/post_synth_critpath_report.csv

#------------------------------------------------------------------
# Run logic optimization, placement and physical logic optimization
#------------------------------------------------------------------

opt_design
reportCriticalPaths $outputDir/post_opt_critpath_report.csv

place_design
report_clock_utilization -file $outputDir/clock_util.rpt

# Optionally run optimization if there are timing violations after placement

if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
  puts "Found setup timing violations => running physical optimization"
  phys_opt_design
}

write_checkpoint      -force  $outputDir/post_place.dcp
report_utilization    -file   $outputDir/post_place_util.rpt
report_timing_summary -file   $outputDir/post_place_timing_summary.rpt

#------------------------------------------------------------------
# run the router, write the post-route design checkpoint, report the routing
# status, report timing, power, and DRC, and finally save the Verilog netlist.
#------------------------------------------------------------------

route_design
write_checkpoint -force $outputDir/post_route.dcp

report_route_status   -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power          -file $outputDir/post_route_power.rpt
report_drc            -file $outputDir/post_imp_drc.rpt

write_verilog -force  $outputDir/output_netlist.v -mode timesim -sdf_anno true

#------------------------------------------------------------------
# Generate Bitstream
#------------------------------------------------------------------

#write_bitstream -force $outputDir/fpga_bitstream.bit

#------------------------------------------------------------------
# Exit tcl console
#------------------------------------------------------------------

exit

