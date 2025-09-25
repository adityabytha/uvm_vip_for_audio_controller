




class i2s_driver extends uvm_driver#(i2s_tx);
	`uvm_component_utils(i2s_driver)
	`NEW
	
	virtual audio_i2s_intf vif;
	//reg clk_i;
	
	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual audio_i2s_intf)::get(this,"","i2s_intf",vif);
		`uvm_info("DRV","Build Phase",UVM_HIGH)
		
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


	task drive_tx(i2s_tx tx);
		vif.inport_tvalid_i <= tx.inport_tvalid_i;
		vif.inport_tdata_i <= tx.inport_tdata_i;
		vif.inport_tstrb_i <= 4'hf;
		vif.inport_tdest_i <= 4'h0;
		vif.inport_tlast_i <= 0;
	endtask


	task run_phase (uvm_phase phase);
	//	bit [31:0] data_array [];
    //	read_mp3("output_data.csv", data_array);
	//	int i;
		forever begin
			
			seq_item_port.get_next_item(req);
		//	vif.inport_tdata_i <= data_array[i];
			drive_tx(req);
			
			seq_item_port.item_done();
		end
		
		`uvm_info("DRV","Run Phase",UVM_HIGH)
	endtask
	

	
endclass
