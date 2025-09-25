interface audio_intf(input logic clk_i,rst_i);
	
   logic         cfg_awvalid_i;
   logic [31:0]  cfg_awaddr_i;
   logic         cfg_wvalid_i;	//not used anywhere
   logic [31:0]  cfg_wdata_i;
   logic [3:0]   cfg_wstrb_i;	//not used anywhere
   logic         cfg_bready_i;
   logic         cfg_arvalid_i;
   logic [31:0]  cfg_araddr_i;
   logic       	 cfg_rready_i;


    // Outputs
    logic         cfg_awready_o;
    logic         cfg_wready_o;
    logic         cfg_bvalid_o;
    logic [1:0]   cfg_bresp_o;
    logic         cfg_arready_o;
    logic         cfg_rvalid_o;
    logic [31:0]  cfg_rdata_o;
    logic [1:0]   cfg_rresp_o;
    logic         audio_l_o;
    logic         audio_r_o;
    logic         spdif_o;
    logic         i2s_sck_o;
    logic         i2s_sdata_o;
    logic         i2s_ws_o;
    logic         intr_o;

endinterface
