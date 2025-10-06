




//including pre-requisite files
`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

//define Timing clocks
/*`define CLK_I_FULL 83.33 		//for 44.1KHZ
`define HALF_CLK_I_FULL 41.66 
`define AUDIO_CLK_FULL 22676	//for 32x44.1khz
`define AUDIO_HALF_CLK_I_FULL 11338 
`define DELAY_2 1416
`define AUDIO_CLK_FULL_10 226760
`define DELAY_20 45352
`define FULL_100 2267600
*/

//define Timing clocks according to ultra-embedded
//He told audio_clk_i clock rate should be 44.1Khz - 22.5792Mhz
//and clk_i should be more than 2 x audio_clk_i
//	44.288ns of time period for 22.5792Mhz clock
//	and clk_i time period = 20ns more than double freq 
`define CLK_I_FULL 20 		
`define HALF_CLK_I_FULL 10 
`define AUDIO_CLK_FULL 44.288	//for 44.1khz
`define AUDIO_HALF_CLK_I_FULL 22.144 
`define DELAY_2 40
`define AUDIO_CLK_FULL_10 442.88
`define DELAY_20 884
`define FULL_100 4428.8


//including interface files
`include "audio_intf.sv"
`include "audio_dac_intf.sv"
`include "audio_i2s_intf.sv"
`include "audio_spdif_intf.sv"


//including desgin files
`include "audio_defs.v"
`include "sigma_dac.v"
`include "spdif_core.v"
`include "audio_spdif.v"
`include "audio_i2s.v"
`include "audio_fifo.v"
`include "audio_dac.v"
`include "audio.v"





//including UVM TB files
`include "uvm_commons.sv"
`include "audio_tx.sv"
`include "i2s_tx.sv"
//`include ".sv"
`include "main_cov.sv"
`include "main_mon.sv"
`include "main_driver.sv"
`include "main_sequencer.sv"
`include "spdif_cov.sv"
`include "spdif_mon.sv"
`include "spdif_sequencer.sv"
`include "spdif_driver.sv"
`include "i2s_cov.sv"
`include "i2s_mon.sv"
`include "i2s_sequencer.sv"
`include "i2s_driver.sv"
`include "dac_cov.sv"
`include "dac_mon.sv"
`include "dac_sequencer.sv"
`include "dac_driver.sv"
`include "dac_agent.sv"
`include "i2s_agent.sv"
`include "main_agent.sv"
`include "spdif_agent.sv"

`include "audio_env.sv"
`include "seq_lib.sv"
`include "test_lib.sv"





module top;
	reg clk_i,rst_i;
	reg audio_clk_i;	

	initial begin
		clk_i = 1;
		forever #`HALF_CLK_I_FULL clk_i = ~clk_i;
	end
	
	
	initial begin
		audio_clk_i = 0;
		forever #`AUDIO_HALF_CLK_I_FULL audio_clk_i = ~audio_clk_i;
	end
	
	
	initial begin
		rst_i = 1;
		#`CLK_I_FULL;
		rst_i = 0;
	end

	int runs;
	initial begin 

		if (!$value$plusargs("runs=%d", runs)) begin
        		runs = 1; // default value
		end
		uvm_resource_db#(int)::set("*","runs",runs,null);
	end




//------------------------------------------
//		MAIN AUDIO DUT INSTANTIATION 
//------------------------------------------
	audio_intf intf(clk_i, rst_i);

	audio dut(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.cfg_awvalid_i(intf.cfg_awvalid_i),
		.cfg_awaddr_i(intf.cfg_awaddr_i),
        .cfg_wvalid_i(intf.cfg_wvalid_i),
        .cfg_wdata_i(intf.cfg_wdata_i),
        .cfg_wstrb_i(intf.cfg_wstrb_i),
        .cfg_bready_i(intf.cfg_bready_i),
        .cfg_arvalid_i(intf.cfg_arvalid_i),
        .cfg_araddr_i(intf.cfg_araddr_i),
        .cfg_rready_i(intf.cfg_rready_i),
		
		.cfg_awready_o(intf.cfg_awready_o),
    	.cfg_wready_o(intf.cfg_wready_o),
   		.cfg_bvalid_o(intf.cfg_bvalid_o),
 		.cfg_bresp_o(intf.cfg_bresp_o),
  		.cfg_arready_o(intf.cfg_arready_o),
  		.cfg_rvalid_o(intf.cfg_rvalid_o),
   		.cfg_rdata_o(intf.cfg_rdata_o),
   		.cfg_rresp_o(intf.cfg_rresp_o),
  		.audio_l_o(intf.audio_l_o),
  		.audio_r_o(intf.audio_r_o),
     	.spdif_o(intf.spdif_o),
     	.i2s_sck_o(intf.i2s_sck_o),
       	.i2s_sdata_o(intf.i2s_sdata_o),
     	.i2s_ws_o(intf.i2s_ws_o),
        .intr_o(intf.intr_o)
	);
		
	initial begin
		uvm_config_db#(virtual audio_intf)::set(uvm_root::get(),"*","audio_intf",intf);
	end	



//------------------------------------------
//		MAIN AUDIO_DAC DUT INSTANTIATION 
//------------------------------------------

	audio_dac_intf dac_intf(clk_i,rst_i,audio_clk_i);

	audio_dac dut2 (
		.clk_i(clk_i),
		.rst_i(rst_i),
		.audio_clk_i(audio_clk_i),
		.inport_tvalid_i(dac_intf.inport_tvalid_i),
		.inport_tdata_i(dac_intf.inport_tdata_i),
		.inport_tstrb_i(dac_intf.inport_tstrb_i),
		.inport_tdest_i(dac_intf.inport_tdest_i),
		.inport_tlast_i(dac_intf.inport_tlast_i),


		.inport_tready_o(dac_intf.inport_tready_o),
		.audio_l_o(dac_intf.audio_l_o),
		.audio_r_o(dac_intf.audio_r_o)
	);
	
	initial begin
		uvm_config_db#(virtual audio_dac_intf)::set(uvm_root::get(),"*","dac_intf",dac_intf);
	end
	
//------------------------------------------
//		MAIN AUDIO_I2S DUT INSTANTIATION 
//------------------------------------------

	audio_i2s_intf i2s_intf(clk_i,rst_i,audio_clk_i);

	audio_i2s dut3 (
		.clk_i(clk_i),
		.rst_i(rst_i),
		.audio_clk_i(audio_clk_i),
		.inport_tvalid_i(i2s_intf.inport_tvalid_i),
		.inport_tdata_i(i2s_intf.inport_tdata_i),
		.inport_tstrb_i(i2s_intf.inport_tstrb_i),
		.inport_tdest_i(i2s_intf.inport_tdest_i),
		.inport_tlast_i(i2s_intf.inport_tlast_i),


		.inport_tready_o(i2s_intf.inport_tready_o),
		.i2s_sck_o(i2s_intf.i2s_sck_o),
		.i2s_sdata_o(i2s_intf.i2s_sdata_o),
		.i2s_ws_o(i2s_intf.i2s_ws_o)
	);

	initial begin
		uvm_config_db#(virtual audio_i2s_intf)::set(uvm_root::get(),"*","i2s_intf",i2s_intf);
	end


//------------------------------------------
//		MAIN AUDIO_SPDIF DUT INSTANTIATION 
//------------------------------------------


	audio_spdif_intf spdif_intf(clk_i,rst_i,audio_clk_i);

	audio_spdif  u_spdif(
     .clk_i(clk_i)
    ,.rst_i(rst_i)

    ,.audio_clk_i(audio_clk_i)

    ,.inport_tvalid_i(spdif_intf.inport_tvalid_i)
    ,.inport_tdata_i(spdif_intf.inport_tdata_i)
    ,.inport_tstrb_i(spdif_intf.inport_tstrb_i)
    ,.inport_tdest_i(spdif_intf.inport_tdest_i)
    ,.inport_tlast_i(spdif_intf.inport_tlast_i)
    ,.inport_tready_o(spdif_intf.inport_tready_o)

    ,.spdif_o(spdif_intf.spdif_o)
);


	initial begin
		uvm_config_db#(virtual audio_spdif_intf)::set(uvm_root::get(),"*","spdif_intf",spdif_intf);
	end

	initial begin
		$fsdbDumpfile("dump1.fsdb");
		$fsdbDumpvars(0,top);
	end


	initial run_test();		//run the whole TB
endmodule
