#!/bin/bash

set -e

vlib work

vlog ../*.sv *.sv

vsim -c work.test -do "log -r /*; run -all"



# for GUI
# vsim vsim.wlf -do wave/wave.do


