@echo off
set xv_path=D:\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 625753a3ad2244b883ce91cd364ffccc -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Test_Bench_behav xil_defaultlib.Test_Bench -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
