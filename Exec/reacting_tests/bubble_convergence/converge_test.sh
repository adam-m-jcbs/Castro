#!/bin/bash

EXEC=./Castro2d.gnu.MPI.TRUESDC.ex

mpiexec -n 8 ${EXEC} inputs_2d.64 >& 64.out
mpiexec -n 8 ${EXEC} inputs_2d.128 >& 128.out
mpiexec -n 8 ${EXEC} inputs_2d.256 >& 256.out
RichardsonConvergenceTest2d.gnu.ex coarFile=bubble_64_plt00334 mediFile=bubble_128_plt00667 fineFile=bubble_256_plt01334 > converge_lo.out

mpiexec -n 8 ${EXEC} inputs_2d.512 >& 512.out
RichardsonConvergenceTest2d.gnu.ex coarFile=bubble_128_plt00667 mediFile=bubble_256_plt01334 fineFile=bubble_512_plt02667 > converge_hi.out


