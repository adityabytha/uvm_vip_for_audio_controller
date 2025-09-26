





class audio_base_test extends uvm_test;
	`uvm_component_utils(audio_base_test)
	`NEW
	audio_env env;
	//uvm_coreservice_t cs = uvm_coreservice_t::get();
	//uvm_factory factory = cs.get_factory();
	
	function void build_phase(uvm_phase phase);
		env = audio_env::type_id::create("env",this);
		`uvm_info("TEST-LIB","Build Phase",UVM_HIGH)
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
		`uvm_info("TEST-LIB","End of Elab Phase",UVM_HIGH)
	endfunction
	
endclass

//------------------------------------------
//				EMPTY TEST 
//------------------------------------------

class empty_test extends audio_base_test;
	`uvm_component_utils(empty_test)
	`NEW
	//factory.set_type_overrride_by_name("audio_tx","spdif_tx");
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h7,null);
	endfunction
	
	task run_phase(uvm_phase phase);
		//empty_seq seq;
		//seq = empty_seq::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_20);
		//seq.start(env.main_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass


//------------------------------------------
//			MAIN AUDIO TEST 
//------------------------------------------

class audio_main_test extends audio_base_test;
	`uvm_component_utils(audio_main_test)
	`NEW
	//factory.set_type_overrride_by_name("audio_tx","spdif_tx");
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h1,null);
	endfunction
	
	task run_phase(uvm_phase phase);
		audio_seq seq;
		seq = audio_seq::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_2);
		seq.start(env.main_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass

class main_i2s_test extends audio_base_test;
	`uvm_component_utils(main_i2s_test)
	`NEW

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h1,null);
	endfunction
	
	task run_phase(uvm_phase phase);
		main_i2s seq;
		seq = main_i2s::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_2);
		seq.start(env.main_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass

class main_spdif_test extends audio_base_test;
	`uvm_component_utils(main_spdif_test)
	`NEW

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h1,null);
	endfunction
	
	task run_phase(uvm_phase phase);
		main_spdif seq;
		seq = main_spdif::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_2);
		seq.start(env.main_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass

//------------------------------------------
//			MAIN SPDIF TEST 
//------------------------------------------

class audio_spdif_test extends audio_base_test;
	`uvm_component_utils(audio_spdif_test)
	`NEW
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h0,null);
	endfunction
		
	task run_phase(uvm_phase phase);
		spdif_seq seq;
		seq = spdif_seq::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_2);
		seq.start(env.spdif_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass


//------------------------------------------
//				MAIN I2S TEST 
//------------------------------------------

class audio_i2s_test extends audio_base_test;
	`uvm_component_utils(audio_i2s_test)
	`NEW
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h2,null);
	endfunction
		
	task run_phase(uvm_phase phase);
		i2s_seq seq;
		seq = i2s_seq::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_2);
		seq.start(env.i2s_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass

//------------------------------------------
//			MAIN DAC TEST 
//------------------------------------------

class audio_dac_test extends audio_base_test;
	`uvm_component_utils(audio_dac_test)
	`NEW
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h3,null);
	endfunction
		
	task run_phase(uvm_phase phase);
		dac_seq seq;
		seq = dac_seq::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_2);
		seq.start(env.dac_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass

//------------------------------------------
//		CFG TEST 
//------------------------------------------

class cfg_test extends audio_base_test;
	`uvm_component_utils(cfg_test)
	`NEW
	//factory.set_type_overrride_by_name("audio_tx","spdif_tx");
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		uvm_resource_db#(int)::set("GLOBAL","AGENT_SELECT",4'h1,null);
	endfunction
	
	task run_phase(uvm_phase phase);
		cfg_seq seq;
		seq = cfg_seq::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,`DELAY_2);
		seq.start(env.main_agent_i.sqr);
		phase.drop_objection(this);	
	endtask
	
endclass

