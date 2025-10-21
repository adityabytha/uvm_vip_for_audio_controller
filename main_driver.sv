




class main_driver extends uvm_driver#(audio_tx);
	`uvm_component_utils(main_driver)
	`NEW
	
	virtual audio_intf vif;
	//reg clk_i;
	
	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual audio_intf)::get(this,"","audio_intf",vif);
		`uvm_info("DRV","Build Phase",UVM_HIGH)
		
	endfunction

	task drive_tx(audio_tx tx);
		vif.cfg_awvalid_i <= tx.cfg_awvalid_i;
		vif.cfg_awaddr_i <= tx.cfg_awaddr_i;
		vif.cfg_wvalid_i <= tx.cfg_wvalid_i;
		vif.cfg_wdata_i <= tx.cfg_wdata_i;
	//	vif.cfg_wstrb_i <= tx.cfg_wstrb_i;
		vif.cfg_bready_i <= tx.cfg_bready_i;
		vif.cfg_arvalid_i <= tx.cfg_arvalid_i;
		vif.cfg_araddr_i <= tx.cfg_araddr_i;
		vif.cfg_rready_i <= tx.cfg_rready_i;
	endtask


	task run_phase (uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			seq_item_port.item_done();
		end
		
		`uvm_info("DRV","Run Phase",UVM_HIGH)
	endtask
	

	
endclass
