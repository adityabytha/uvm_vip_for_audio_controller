////////FOR I2S
class i2s_tx extends uvm_sequence_item;
    // rand bits
  //  rand bit           audio_clk_i;
    rand bit           inport_tvalid_i;
    rand bit  [ 31:0]  inport_tdata_i;
     bit  [  3:0]  inport_tstrb_i;
     bit  [  3:0]  inport_tdest_i;
     bit           inport_tlast_i;

    // rand bits
     bit          inport_tready_o;
     bit          i2s_sck_o;
     bit          i2s_sdata_o;
     bit          i2s_ws_o;
   
   
   	`uvm_object_utils_begin(i2s_tx)
	//	`uvm_field_int(audio_clk_i,UVM_ALL_ON)
		`uvm_field_int(inport_tvalid_i,UVM_ALL_ON)
		`uvm_field_int(inport_tdata_i,UVM_ALL_ON)
		`uvm_field_int(inport_tstrb_i,UVM_ALL_ON)
		`uvm_field_int(inport_tdest_i,UVM_ALL_ON)
		`uvm_field_int(inport_tlast_i,UVM_ALL_ON)
		`uvm_field_int(inport_tready_o,UVM_ALL_ON)
		`uvm_field_int(i2s_sck_o,UVM_ALL_ON)
		`uvm_field_int(i2s_sdata_o,UVM_ALL_ON)
		`uvm_field_int(i2s_ws_o,UVM_ALL_ON)
	`uvm_object_utils_end
	`NEW_OBJ


endclass
