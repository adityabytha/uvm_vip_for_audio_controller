




class spdif_driver extends uvm_driver#(spdif_tx);
	`uvm_component_utils(spdif_driver)
	`NEW
	
	virtual audio_spdif_intf vif;
	
	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual audio_spdif_intf)::get(this,"","spdif_intf",vif);
		`uvm_info("DRV","Build Phase",UVM_HIGH)
		
	endfunction

	
	task drive_tx(spdif_tx tx);
		vif.inport_tvalid_i <= 1'b0;
		vif.inport_tdata_i <= tx.inport_tdata_i;
		vif.inport_tstrb_i <= 4'hf;
		vif.inport_tlast_i <= 1'b0;
		vif.inport_tdest_i <= 4'h0;
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
