proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a35tcpg236-1
  set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Digitale2ProjectBackup/Digitale2ProjectBackup.cache/wt} [current_project]
  set_property parent.project_path {C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Digitale2ProjectBackup/Digitale2ProjectBackup.xpr} [current_project]
  set_property ip_repo_paths {{c:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Digitale2ProjectBackup/Digitale2ProjectBackup.cache/ip}} [current_project]
  set_property ip_output_repo {{c:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Digitale2ProjectBackup/Digitale2ProjectBackup.cache/ip}} [current_project]
  add_files -quiet {{C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Digitale2ProjectBackup/Digitale2ProjectBackup.runs/synth_1/GPIO_demo.dcp}}
  read_xdc {{C:/Users/Ecto1/Documents/GitHub/Digitale projectNew/Begin project/src/constraints/Basys3_Master.xdc}}
  link_design -top GPIO_demo -part xc7a35tcpg236-1
  write_hwdef -file GPIO_demo.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force GPIO_demo_opt.dcp
  report_drc -file GPIO_demo_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force GPIO_demo_placed.dcp
  report_io -file GPIO_demo_io_placed.rpt
  report_utilization -file GPIO_demo_utilization_placed.rpt -pb GPIO_demo_utilization_placed.pb
  report_control_sets -verbose -file GPIO_demo_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force GPIO_demo_routed.dcp
  report_drc -file GPIO_demo_drc_routed.rpt -pb GPIO_demo_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file GPIO_demo_timing_summary_routed.rpt -rpx GPIO_demo_timing_summary_routed.rpx
  report_power -file GPIO_demo_power_routed.rpt -pb GPIO_demo_power_summary_routed.pb -rpx GPIO_demo_power_routed.rpx
  report_route_status -file GPIO_demo_route_status.rpt -pb GPIO_demo_route_status.pb
  report_clock_utilization -file GPIO_demo_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

