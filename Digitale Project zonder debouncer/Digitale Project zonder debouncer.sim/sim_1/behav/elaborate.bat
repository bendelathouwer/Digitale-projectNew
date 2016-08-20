@echo off
set xv_path=D:\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto d92fcd9300994dd493ac14b68da4c844 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot GPIO_demo_behav xil_defaultlib.GPIO_demo -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
