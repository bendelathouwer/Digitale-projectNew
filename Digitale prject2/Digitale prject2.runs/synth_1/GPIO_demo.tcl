# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Digitale2ProjectBackup/Digitale2ProjectBackup.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Digitale2ProjectBackup/Digitale2ProjectBackup.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/Ps2Interface.vhd}
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/clk_wiz_0_clk_wiz.vhd}
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/MouseDisplay.vhd}
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/clk_wiz_0.vhd}
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/MouseCtl.vhd}
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/debouncer.vhd}
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/vga_ctrl.vhd}
  {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/hdl/GPIO_Demo.vhd}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/constraints/Basys3_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/constraints/Basys3_Master.xdc}}]


synth_design -top GPIO_demo -part xc7a35tcpg236-1


write_checkpoint -force -noxdef GPIO_demo.dcp

catch { report_utilization -file GPIO_demo_utilization_synth.rpt -pb GPIO_demo_utilization_synth.pb }