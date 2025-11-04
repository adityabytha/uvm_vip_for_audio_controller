




class i2s_mon extends uvm_monitor;
//	uvm_analysis_port#(i2s_evt_t) ap_port;
	uvm_analysis_port#(i2s_tx) ap_port;
	virtual audio_i2s_intf vif;
	`uvm_component_utils(i2s_mon)
	`NEW
	i2s_tx tx;


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port",this);
		if(!uvm_config_db#(virtual audio_i2s_intf)::get(this, "", "i2s_intf", vif)) begin
			`uvm_error("i2s_MON", "CONFIG_DB ERROR")
		end
			`uvm_info("i2s_MON","Build Phase",UVM_HIGH)
	endfunction


	task run_phase(uvm_phase phase);
		`uvm_info("i2s_MON","Run Phase",UVM_HIGH)
		forever begin
			#`AUDIO_CLK_FULL;
			if(vif.inport_tready_o) begin
				@(negedge vif.i2s_sck_o);
				repeat(32) begin
					@(negedge vif.i2s_sck_o);
					tx = new("i2s_tx_MON");
					tx.i2s_sdata_o = vif.i2s_sdata_o;
					tx.i2s_ws_o = vif.i2s_ws_o;
					tx.print();
					`uvm_info("MON","----------",UVM_HIGH)
					ap_port.write(tx);
					tx = null;
				end
			end
		end
	endtask 


endclass

