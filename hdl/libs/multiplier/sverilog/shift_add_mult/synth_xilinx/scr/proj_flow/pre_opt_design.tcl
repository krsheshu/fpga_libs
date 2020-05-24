############## pre_opt_design.tcl ##################
set synthDir      [file dirname [file normalize [info script]]]/../..
set scrDir        $synthDir/scr
set outputDir     $synthDir/builds

source $scrDir/reportCriticalPaths.tcl
#
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization    -file $outputDir/post_synth_util.rpt
reportCriticalPaths         $outputDir/post_synth_critpath_report.csv
