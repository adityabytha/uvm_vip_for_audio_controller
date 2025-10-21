




class i2s_driver extends uvm_driver#(i2s_tx);
	`uvm_component_utils(i2s_driver)
	`NEW
	
	i2s_tx tx;
	uvm_analysis_port#(i2s_tx) ap_port;
	virtual audio_i2s_intf vif;
	
	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual audio_i2s_intf)::get(this,"","i2s_intf",vif);
		`uvm_info("DRV","Build Phase",UVM_HIGH)
		
		ap_port = new("ap_port",this);
	endfunction
	
	/*task read_mp3(string file_name, ref bit [31:0] data []);
    int fd;
    string line;
    bit [31:0] temp_data;
    int count;

    // Open the file
    fd = $fopen(file_name, "r");
    if (fd == 0) begin
      `uvm_fatal("FILE_ERROR", $sformatf("Failed to open file: %s", file_name));
    end

    // Read the file line by line
    count = 0;
    while (!$feof(fd)) begin
      line = $fgets(fd);
      if ($sscanf(line, "%d", temp_data) == 1) begin
        data[count] = temp_data;
        count++;
      end
    end

    // Close the file
    $fclose(fd);
  endtask*/
	function convert_to_tx(i2s_tx req);
		tx = new("i2s_tx_DRV");			
		tx.inport_tvalid_i = req.inport_tvalid_i;
		tx.inport_tdata_i = req.inport_tdata_i;
		tx.inport_tstrb_i = 4'hf;
		tx.inport_tdest_i = 4'h0;
		tx.inport_tlast_i = 0;
	endfunction

	task drive_tx(i2s_tx tx);
		vif.inport_tvalid_i <= tx.inport_tvalid_i;
		vif.inport_tdata_i <= tx.inport_tdata_i;
		vif.inport_tstrb_i <= 4'hf;
		vif.inport_tdest_i <= 4'h0;
		vif.inport_tlast_i <= 0;
	endtask


	task run_phase (uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			convert_to_tx(req);
			tx.print();
			ap_port.write(tx);
			seq_item_port.item_done();
		end
		
		`uvm_info("DRV","Run Phase",UVM_HIGH)
	endtask
	

	
endclass
