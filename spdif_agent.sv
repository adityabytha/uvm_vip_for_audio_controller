




class spdif_agent extends uvm_agent;
	`uvm_component_utils(spdif_agent)
	spdif_driver drv;
	spdif_sequencer sqr;
	spdif_mon mon;
	spdif_cov cov;
	`NEW
	
	function void build_phase(uvm_phase phase);
		drv = spdif_driver::type_id::create("drv",this);
		sqr = spdif_sequencer::type_id::create("sqr",this);
		mon = spdif_mon::type_id::create("mon",this);
		cov = spdif_cov::type_id::create("cov",this);
		`uvm_info("SPDIF_AGENT","Build Phase",UVM_HIGH)
	endfunction
	
	function void connect_phase (uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
		`uvm_info("SPDIF_AGENT","Connect Phase",UVM_HIGH)
	endfunction
	
endclass
