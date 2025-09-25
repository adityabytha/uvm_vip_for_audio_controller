interface audio_spdif_intf(input logic clk_i, rst_i,audio_clk_i);

    // logics
    
    logic           inport_tvalid_i;
    logic  [ 31:0]  inport_tdata_i;
    logic  [  3:0]  inport_tstrb_i;
    logic  [  3:0]  inport_tdest_i;
    logic           inport_tlast_i;

    // logics
    logic          inport_tready_o;
    logic          spdif_o;
endinterface
