#------------------------------------------------------------------
# Setting project paths and output directory
#------------------------------------------------------------------

set TOP         $::env(TOP)
set synthDir    [file dirname [file normalize [info script]]]/../..
set srcDir      $synthDir/..
set constrDir   $synthDir/constraints
set scrFlowDir  $synthDir/scr/proj_flow

set outputDir   $synthDir/builds

file delete -force  $outputDir
file mkdir          $outputDir

#------------------------------------------------------------------
# Creating Project
#------------------------------------------------------------------

create_project multProj $outputDir -part xczu4cg-sfvc784-1-e -force


#------------------------------------------------------------------
# Setup design source files
#------------------------------------------------------------------

add_files -fileset sim_1      $srcDir/tb/tb.sv
add_files -fileset sources_1  [glob $srcDir/*.sv]
add_files -fileset constrs_1  $constrDir/constraints.xdc


#------------------------------------------------------------------
# Import the files into project
#------------------------------------------------------------------

import_files -force -norecurse
import_files -fileset constrs_1 -force -norecurse $constrDir/constraints.xdc


#------------------------------------------------------------------
# Compile order settings
#------------------------------------------------------------------

set_property top $TOP [current_fileset]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


#------------------------------------------------------------------
# Run Synthesis
#------------------------------------------------------------------
launch_runs synth_1
wait_on_run synth_1


#------------------------------------------------------------------
# run logic optimization, placement, physical logic optimization, route and
# bitstream generation. Generates design checkpoints, utilization and timing
# reports, plus custom reports.
#------------------------------------------------------------------

set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]

set_property STEPS.OPT_DESIGN.TCL.PRE         $scrFlowDir/pre_opt_design.tcl [get_runs impl_1]
set_property STEPS.OPT_DESIGN.TCL.POST        $scrFlowDir/post_opt_design.tcl [get_runs impl_1]
set_property STEPS.PLACE_DESIGN.TCL.POST      $scrFlowDir/post_place_design.tcl [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.TCL.POST   $scrFlowDir/post_phys_opt_design.tcl [get_runs impl_1]
set_property STEPS.ROUTE_DESIGN.TCL.POST      $scrFlowDir/post_route_design.tcl [get_runs impl_1]
#
launch_runs impl_1 -to_step route_design
wait_on_run impl_1
puts "Implementation done!"-


#------------------------------------------------------------------
# Exit tcl console
#------------------------------------------------------------------
exit

