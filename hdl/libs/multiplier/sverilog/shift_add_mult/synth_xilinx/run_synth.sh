#!/bin/bash

export TOP="shift_add_mult"

time vivado -mode batch -source scr/proj_flow/v192_mult_proj.tcl -notrace
#time vivado -mode batch -source scr/non_proj_flow/v192_mult_proj.tcl -notrace

# Removing backup journal and log files
rm *backup.jou *backup.log
