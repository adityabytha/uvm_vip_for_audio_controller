




class spdif_mon extends uvm_monitor;
	uvm_analysis_port#(spdif_tx) ap_port;
	virtual audio_spdif_intf vif;
	`uvm_component_utils(spdif_mon)
	`NEW
	spdif_tx tx;


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port",this);
		if(!uvm_config_db#(virtual audio_spdif_intf)::get(this, "", "spdif_intf", vif)) begin
			`uvm_error("SPDIF_MON", "CONFIG_DB ERROR")
		end
			`uvm_info("SPDIF_MON","Build Phase",UVM_HIGH)
	endfunction


	task run_phase(uvm_phase phase);
		`uvm_info("SPDIF_MON","Run Phase",UVM_HIGH)
		forever begin
			@(vif.inport_tdata_i);
			tx = new("spdif_tx_MON");
			tx.inport_tdata_i = vif.inport_tdata_i;
			tx.inport_tready_o = vif.inport_tready_o;
			tx.spdif_o = vif.spdif_o;
			ap_port.write(tx);
		end
	endtask 


endclass



