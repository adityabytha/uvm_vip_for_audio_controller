

class audio_tx extends uvm_sequence_item;
	

   rand bit         cfg_awvalid_i;
   rand bit [31:0]  cfg_awaddr_i;
   rand bit         cfg_wvalid_i;
   rand bit [31:0]  cfg_wdata_i;
   rand bit [3:0]   cfg_wstrb_i;
   rand bit         cfg_bready_i;
   rand bit         cfg_arvalid_i;
   rand bit [31:0]  cfg_araddr_i;
   rand bit         cfg_rready_i;


	bit         cfg_awready_o;
    bit         cfg_wready_o;
    bit         cfg_bvalid_o;
    bit [1:0]   cfg_bresp_o;
    bit         cfg_arready_o;
    bit         cfg_rvalid_o;
    bit [31:0]  cfg_rdata_o;
    bit [1:0]   cfg_rresp_o;
    bit         audio_l_o;
    bit         audio_r_o;
    bit         spdif_o;
    bit         i2s_sck_o;
    bit         i2s_sdata_o;
    bit         i2s_ws_o;
    bit         intr_o;
	
	`uvm_object_utils_begin(audio_tx)
		`uvm_field_int(cfg_awvalid_i,UVM_ALL_ON)
		`uvm_field_int(cfg_awaddr_i,UVM_ALL_ON)
		`uvm_field_int(cfg_wvalid_i,UVM_ALL_ON)
		`uvm_field_int(cfg_wdata_i,UVM_ALL_ON)
		`uvm_field_int(cfg_wstrb_i,UVM_ALL_ON)
		`uvm_field_int(cfg_bready_i,UVM_ALL_ON)
		`uvm_field_int(cfg_arvalid_i,UVM_ALL_ON)
		`uvm_field_int(cfg_araddr_i,UVM_ALL_ON)
		`uvm_field_int(cfg_rready_i,UVM_ALL_ON)
		
		`uvm_field_int(cfg_awready_o,UVM_ALL_ON)
		`uvm_field_int(cfg_wready_o,UVM_ALL_ON)
		`uvm_field_int(cfg_bvalid_o,UVM_ALL_ON)
		`uvm_field_int(cfg_bresp_o,UVM_ALL_ON)
		`uvm_field_int(cfg_arready_o,UVM_ALL_ON)
		`uvm_field_int(cfg_rvalid_o,UVM_ALL_ON)
		`uvm_field_int(cfg_rdata_o,UVM_ALL_ON)
		`uvm_field_int(cfg_rresp_o,UVM_ALL_ON)
		`uvm_field_int(audio_l_o,UVM_ALL_ON)
		`uvm_field_int(audio_r_o,UVM_ALL_ON)
		`uvm_field_int(spdif_o,UVM_ALL_ON)
		`uvm_field_int(i2s_sck_o,UVM_ALL_ON)
		`uvm_field_int(i2s_sdata_o,UVM_ALL_ON)
		`uvm_field_int(i2s_ws_o,UVM_ALL_ON)
		`uvm_field_int(intr_o,UVM_ALL_ON)
	`uvm_object_utils_end
	
	`NEW_OBJ

	constraint awaddr_values {	cfg_awaddr_i[31:8] == 24'b0;	}

	constraint araddr_values {	cfg_araddr_i[31:8] == 24'b0;	}
	/*constraint awaddr { 
		if(cfg_awaddr_i[7:0] == 8'h00)
		{
			cfg_wdata_i[`AUDIO_CFG_BUFFER_RST_R] == 1;
			cfg_wdata_i[`AUDIO_CFG_VOL_CTRL_R] == 3'b101;
			cfg_wdata_i[`AUDIO_CFG_TARGET_R] inside {2'd0,2'd1,2'd2};
		}
	}
	
	constraint awaddr_clk1 { 
		if(cfg_awaddr_i[7:0] == 8'h08)
		{
			cfg_wdata_i[`AUDIO_CLK_DIV_WHOLE_CYCLES_R] == 16'd272;
		}
	}
	
	constraint awaddr_clk2 { 
		if(cfg_awaddr_i[7:0] == 8'h0c)
		{
			cfg_wdata_i[`AUDIO_CLK_FRAC_NUMERATOR_R] == 16'd11;
			cfg_wdata_i[`AUDIO_CLK_FRAC_DENOMINATOR_R] == 16'd100;
		}
	}*/
	
endclass

class spdif_tx extends uvm_sequence_item;
	
 // inputs
   // 	 bit           audio_clk_i;
    	 bit           inport_tvalid_i;
    rand bit  [ 31:0]  inport_tdata_i;
    	 bit  [  3:0]  inport_tstrb_i;
    	 bit  [  3:0]  inport_tdest_i;
    	 bit           inport_tlast_i;
         bit           inport_tready_o;
    	 bit           spdif_o;
    	
	`uvm_object_utils_begin(spdif_tx)
	//	`uvm_field_int(audio_clk_i,UVM_ALL_ON)
		`uvm_field_int(inport_tvalid_i,UVM_ALL_ON)
		`uvm_field_int(inport_tdata_i,UVM_ALL_ON)
		`uvm_field_int(inport_tstrb_i,UVM_ALL_ON)
		`uvm_field_int(inport_tdest_i,UVM_ALL_ON)
		`uvm_field_int(inport_tlast_i,UVM_ALL_ON)
		`uvm_field_int(inport_tready_o,UVM_ALL_ON)
		`uvm_field_int(spdif_o,UVM_ALL_ON)
	`uvm_object_utils_end

	`NEW_OBJ


endclass

class dac_tx extends uvm_sequence_item;
	
 // inputs
//	bit           audio_clk_i;
   rand bit           inport_tvalid_i;
   rand bit  [ 31:0]  inport_tdata_i;
    bit  [  3:0]  inport_tstrb_i;
    bit  [  3:0]  inport_tdest_i;
    bit           inport_tlast_i;

    // bits
    bit          inport_tready_o;
    bit          audio_l_o;
    bit          audio_r_o;
    	
	`uvm_object_utils_begin(dac_tx)
	//	`uvm_field_int(audio_clk_i,UVM_ALL_ON)
		`uvm_field_int(inport_tvalid_i,UVM_ALL_ON)
		`uvm_field_int(inport_tdata_i,UVM_ALL_ON)
		`uvm_field_int(inport_tstrb_i,UVM_ALL_ON)
		`uvm_field_int(inport_tdest_i,UVM_ALL_ON)
		`uvm_field_int(inport_tlast_i,UVM_ALL_ON)
		`uvm_field_int(inport_tready_o,UVM_ALL_ON)
		`uvm_field_int(audio_l_o,UVM_ALL_ON)
		`uvm_field_int(audio_r_o,UVM_ALL_ON)
	`uvm_object_utils_end

	`NEW_OBJ


endclass
