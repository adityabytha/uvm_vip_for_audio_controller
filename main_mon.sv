




class main_mon extends uvm_monitor;
	uvm_analysis_port#(audio_tx) ap_port;
	virtual audio_intf vif;
	`uvm_component_utils(main_mon)
	`NEW
	audio_tx tx;


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port",this);
		if(!uvm_config_db#(virtual audio_intf)::get(this, "", "audio_intf", vif)) begin
			`uvm_error("MAIN_MON", "CONFIG_DB ERROR")
		end
			`uvm_info("MAIN_MON","Build Phase",UVM_HIGH)
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info("MAIN_MON","Run Phase",UVM_HIGH)
		forever begin
			@(vif.cfg_awaddr_i);
			tx = new("MAIN_MON");
			tx.cfg_awvalid_i = vif.cfg_awvalid_i;
			tx.cfg_awaddr_i = vif.cfg_awaddr_i;
			tx.cfg_wvalid_i = vif.cfg_wvalid_i;
			tx.cfg_wdata_i = vif.cfg_wdata_i;
			tx.cfg_wstrb_i = vif.cfg_wstrb_i;
			tx.cfg_bready_i = vif.cfg_bready_i;
			tx.cfg_arvalid_i = vif.cfg_arvalid_i;
			tx.cfg_araddr_i = vif.cfg_araddr_i;
			tx.cfg_rready_i = vif.cfg_rready_i;
			tx.cfg_awready_o = vif.cfg_awready_o;
			tx.cfg_wready_o = vif.cfg_wready_o;
			tx.cfg_bvalid_o = vif.cfg_bvalid_o;
			tx.cfg_bresp_o = vif.cfg_bresp_o;
			tx.cfg_arready_o = vif.cfg_arready_o;
			tx.cfg_rvalid_o = vif.cfg_rvalid_o;
			tx.cfg_rdata_o = vif.cfg_rdata_o;
			tx.cfg_rresp_o = vif.cfg_rresp_o;
			tx.audio_l_o = vif.audio_l_o;
			tx.audio_r_o = vif.audio_r_o;
			tx.spdif_o = vif.spdif_o;
			tx.i2s_sck_o = vif.i2s_sck_o;
			tx.i2s_sdata_o = vif.i2s_sdata_o;
			tx.i2s_ws_o = vif.i2s_ws_o;
			tx.intr_o = vif.intr_o;
		//	tx.print();
			ap_port.write(tx);
		end
	endtask



endclass



