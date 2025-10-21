




class i2s_agent extends uvm_agent;
	`uvm_component_utils(i2s_agent)
	i2s_driver drv;
	i2s_sequencer sqr;
	i2s_mon mon;
	i2s_cov cov;
	`NEW
	
//	uvm_analysis_export#(i2s_tx) a_export;

	function void build_phase(uvm_phase phase);
		drv = i2s_driver::type_id::create("drv",this);
		sqr = i2s_sequencer::type_id::create("sqr",this);
		mon = i2s_mon::type_id::create("mon",this);
		cov = i2s_cov::type_id::create("cov",this);
		`uvm_info("i2s_AGENT","Build Phase",UVM_HIGH)
	endfunction
	
	function void connect_phase (uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		//mon.ap_port.connect(cov.analysis_export);
	//	drv.ap_port.connect(this.a_export);
		`uvm_info("i2s_AGENT","Connect Phase",UVM_HIGH)
	endfunction
	
endclass
