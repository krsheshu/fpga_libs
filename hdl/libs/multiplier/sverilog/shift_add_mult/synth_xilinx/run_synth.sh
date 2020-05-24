#!/bin/bash

export TOP="shift_add_mult"

vivado -mode batch -source scr/proj_flow/v192_cheetah_v1_proj.tcl -notrace
#vivado -mode batch -source scr/non_proj_flow/v192_cheetah_v1_proj.tcl -notrace

# Removing backup journal and log files
rm *backup.jou *backup.log
