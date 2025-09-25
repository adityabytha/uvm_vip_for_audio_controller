




class dac_agent extends uvm_agent;
	`uvm_component_utils(dac_agent)
	dac_driver drv;
	dac_sequencer sqr;
	dac_mon mon;
	dac_cov cov;
	`NEW
	
	function void build_phase(uvm_phase phase);
		drv = dac_driver::type_id::create("drv",this);
		sqr = dac_sequencer::type_id::create("sqr",this);
		mon = dac_mon::type_id::create("mon",this);
		cov = dac_cov::type_id::create("cov",this);
		`uvm_info("dac_AGENT","Build Phase",UVM_HIGH)
	endfunction
	
	function void connect_phase (uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
		`uvm_info("dac_AGENT","Connect Phase",UVM_HIGH)
	endfunction
	
endclass
