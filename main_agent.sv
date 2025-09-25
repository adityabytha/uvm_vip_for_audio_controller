




class main_agent extends uvm_agent;
	`uvm_component_utils(main_agent)
	main_driver drv;
	main_sequencer sqr;
	main_mon mon;
	main_cov cov;
	`NEW
	
	function void build_phase(uvm_phase phase);
		drv = main_driver::type_id::create("drv",this);
		sqr = main_sequencer::type_id::create("sqr",this);
		mon = main_mon::type_id::create("mon",this);
		cov = main_cov::type_id::create("cov",this);
		`uvm_info("MAIN_AGENT","Build Phase",UVM_HIGH)
	endfunction
	
	function void connect_phase (uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
		`uvm_info("MAIN_AGENT","Connect Phase",UVM_HIGH)
	endfunction
	
endclass
