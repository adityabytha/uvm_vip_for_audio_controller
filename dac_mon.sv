




class dac_mon extends uvm_monitor;
	uvm_analysis_port#(dac_tx) ap_port;
	virtual audio_dac_intf vif;
	`uvm_component_utils(dac_mon)
	`NEW
	dac_tx tx;


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port",this);
		if(!uvm_config_db#(virtual audio_dac_intf)::get(this, "", "dac_intf", vif)) begin
			`uvm_error("dac_MON", "CONFIG_DB ERROR")
		end
			`uvm_info("dac_MON","Build Phase",UVM_HIGH)
	endfunction


	task run_phase(uvm_phase phase);
		`uvm_info("dac_MON","Run Phase",UVM_HIGH)
		forever begin
			@(vif.inport_tdata_i);
			tx = new("dac_tx_MON");
			tx.inport_tvalid_i = vif.inport_tvalid_i;
			tx.inport_tdata_i = vif.inport_tdata_i;
			tx.inport_tstrb_i = vif.inport_tstrb_i;
			tx.inport_tlast_i = vif.inport_tlast_i;
			tx.inport_tdest_i = vif.inport_tdest_i;
			tx.inport_tready_o = vif.inport_tready_o;
			tx.audio_l_o = vif.audio_l_o;
			tx.audio_r_o = vif.audio_r_o;
			ap_port.write(tx);
		end
	endtask 


endclass



