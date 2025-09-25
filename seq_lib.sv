//audio_seq_lib





//------------------------------------------
//		MAIN SEQUENCE 
//------------------------------------------

class audio_seq extends uvm_sequence#(audio_tx);
	`uvm_object_utils(audio_seq)
	`NEW_OBJ
	
	task body();
		repeat(1_000) begin
		`uvm_do_with(req, {req.cfg_awaddr_i[7:0] >= `AUDIO_FIFO_WRITE;
					 req.cfg_awaddr_i[7:0] <= (`AUDIO_FIFO_WRITE + 8'd32);
								req.cfg_arvalid_i == 1;
							req.cfg_rready_i == 1;})

			#`AUDIO_CLK_FULL;

			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] >= `AUDIO_FIFO_WRITE; //write_en
					 req.cfg_awaddr_i[7:0] <= (`AUDIO_FIFO_WRITE + 8'd32);
								req.cfg_awvalid_i == 1;
								req.cfg_arvalid_i == 0;
								req.cfg_bready_i == 1;})
			
			#`AUDIO_CLK_FULL;				
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h08;
				req.cfg_wdata_i[`AUDIO_CLK_DIV_WHOLE_CYCLES_R] == 16'd272;})
			
			#`AUDIO_CLK_FULL;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h0c;
				req.cfg_wdata_i[`AUDIO_CLK_FRAC_NUMERATOR_R] == 16'd11;
				req.cfg_wdata_i[`AUDIO_CLK_FRAC_DENOMINATOR_R] == 16'd100;})
			
				#`AUDIO_CLK_FULL;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h00;
							req.cfg_wdata_i[`AUDIO_CFG_BUFFER_RST_R] == 1;
							req.cfg_wdata_i[`AUDIO_CFG_VOL_CTRL_R] == 3'b101;
							req.cfg_wdata_i[`AUDIO_CFG_TARGET_R] == 2'd0;
							req.cfg_awvalid_i == 1;
							req.cfg_arvalid_i == 0;
							req.cfg_bready_i == 1;
			})
			#`AUDIO_CLK_FULL;
			//#10_000_000;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h00;
							req.cfg_wdata_i[`AUDIO_CFG_BUFFER_RST_R] == 1;
							req.cfg_wdata_i[`AUDIO_CFG_VOL_CTRL_R] == 3'b101;
							req.cfg_wdata_i[`AUDIO_CFG_TARGET_R] == 2'd1;
							req.cfg_awvalid_i == 1;
							req.cfg_arvalid_i == 0;
							req.cfg_bready_i == 1;
			})
			#`AUDIO_CLK_FULL;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h00;
							req.cfg_wdata_i[`AUDIO_CFG_BUFFER_RST_R] == 0;
							req.cfg_wdata_i[`AUDIO_CFG_VOL_CTRL_R] == 3'b101;
							req.cfg_wdata_i[`AUDIO_CFG_TARGET_R] == 2'd2;
							req.cfg_awvalid_i == 1;
							req.cfg_arvalid_i == 0;
							req.cfg_bready_i == 1;
			})
			#`AUDIO_CLK_FULL;
			end
		`uvm_info("AUDIO_SEQ","Running",UVM_HIGH)
	endtask	
	
endclass

class main_i2s extends uvm_sequence#(audio_tx);
	`uvm_object_utils(main_i2s)
	`NEW_OBJ
	
	task body();
		repeat(1_00) begin
				/*`uvm_do_with(req, {req.cfg_awaddr_i[7:0] inside {8'h00,8'h4,8'h8,8'hc,8'h20};req.cfg_awvalid_i == 1;
								req.cfg_arvalid_i == 0;
								req.cfg_bready_i == 1;})
				#`AUDIO_CLK_FULL_10;
				`uvm_do_with(req, {req.cfg_awaddr_i[7:0] inside {8'h00,8'h4,8'h8,8'hc,8'h20};req.cfg_arvalid_i == 1;
								req.cfg_rready_i == 1;})
				#`AUDIO_CLK_FULL_10;*/
			//`uvm_do(req)
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] >= `AUDIO_FIFO_WRITE;
					 req.cfg_awaddr_i[7:0] <= (`AUDIO_FIFO_WRITE + 8'd32);
								req.cfg_arvalid_i == 1;
								req.cfg_rready_i == 1;})

			#`AUDIO_CLK_FULL;

			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] >= `AUDIO_FIFO_WRITE;
					 req.cfg_awaddr_i[7:0] <= (`AUDIO_FIFO_WRITE + 8'd32);
								req.cfg_awvalid_i == 1;
								req.cfg_arvalid_i == 0;
								req.cfg_bready_i == 1;})
			
			#`AUDIO_CLK_FULL;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h08;
				req.cfg_wdata_i[`AUDIO_CLK_DIV_WHOLE_CYCLES_R] == 16'd272;})
			
			#`AUDIO_CLK_FULL;	
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h0c;
				req.cfg_wdata_i[`AUDIO_CLK_FRAC_NUMERATOR_R] == 16'd11;
				req.cfg_wdata_i[`AUDIO_CLK_FRAC_DENOMINATOR_R] == 16'd100;})
			#`AUDIO_CLK_FULL;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h00;
							req.cfg_wdata_i[`AUDIO_CFG_BUFFER_RST_R] == 1;
			req.cfg_wdata_i[`AUDIO_CFG_VOL_CTRL_R] == 3'b101;
			req.cfg_wdata_i[`AUDIO_CFG_TARGET_R] == 2'd0;})
			
			#`AUDIO_CLK_FULL; 
		end
		`uvm_info("AUDIO_SEQ","Running",UVM_HIGH)
	endtask	
	
endclass

////Trying SPDIF from MAIN_AUDIO
class main_spdif extends uvm_sequence#(audio_tx);
	`uvm_object_utils(main_spdif)
	`NEW_OBJ
	
	task body();
		//repeat(1_0) begin
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] >= `AUDIO_FIFO_WRITE;
					 req.cfg_awaddr_i[7:0] <= (`AUDIO_FIFO_WRITE + 8'd32);
								req.cfg_arvalid_i == 1;
							req.cfg_rready_i == 1;})

			#`AUDIO_CLK_FULL;

			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] >= `AUDIO_FIFO_WRITE; //write_en
					 req.cfg_awaddr_i[7:0] <= (`AUDIO_FIFO_WRITE + 8'd32);
								req.cfg_awvalid_i == 1;
								req.cfg_arvalid_i == 0;
								req.cfg_bready_i == 1;})
			
			#`AUDIO_CLK_FULL;				
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h08;
				req.cfg_wdata_i[`AUDIO_CLK_DIV_WHOLE_CYCLES_R] == 16'd272;})
			
			#`AUDIO_CLK_FULL;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h0c;
				req.cfg_wdata_i[`AUDIO_CLK_FRAC_NUMERATOR_R] == 16'd11;
				req.cfg_wdata_i[`AUDIO_CLK_FRAC_DENOMINATOR_R] == 16'd100;})
			
				#`AUDIO_CLK_FULL;
			
			`uvm_do_with(req, {req.cfg_awaddr_i[7:0] == 8'h00;
							req.cfg_wdata_i[`AUDIO_CFG_BUFFER_RST_R] == 1;
							req.cfg_wdata_i[`AUDIO_CFG_VOL_CTRL_R] == 3'b101;
							req.cfg_wdata_i[`AUDIO_CFG_TARGET_R] == 2'd1;
							req.cfg_awvalid_i == 1;
							req.cfg_arvalid_i == 0;
							req.cfg_bready_i == 1;
			})
			//for cfg to set, write_en shf be 1 and buffer rst didnt matter the results
			//but why o/p only after 5461us?
			//rd - wr - clk - clkf - cfg.
			
			
			//#`FULL_100;#`AUDIO_CLK_FULL_10;
		//end
		`uvm_info("AUDIO_SEQ","Running",UVM_HIGH)
	endtask	
	
endclass



//------------------------------------------
//		 SPDIF SEQUENCE 
//------------------------------------------


class spdif_seq extends uvm_sequence#(spdif_tx);
	`uvm_object_utils(spdif_seq)
	`NEW_OBJ
	
	task body();
		repeat(1_000) begin
		`uvm_do(req)
		//`uvm_do_with(req, { req.inport_tdata_i <= 32'h80000000;})
		#`AUDIO_CLK_FULL;				
		end
		`uvm_info("SPDIF_SEQ","Running",UVM_HIGH)
	endtask	
	
endclass


//------------------------------------------
//		I2S BASE SEQUENCE 
//------------------------------------------

class i2s_seq_base extends uvm_sequence#(i2s_tx);
	`uvm_object_utils(i2s_seq_base)
	`NEW_OBJ
endclass

class i2s_seq extends i2s_seq_base;
	`uvm_object_utils(i2s_seq)
	`NEW_OBJ
	task body();
		repeat(1_000) begin
		`uvm_do(req)
		
		#`AUDIO_CLK_FULL;	
		end
		`uvm_info("I2S_SEQ","Running",UVM_HIGH)
	endtask	
	
endclass


//------------------------------------------
//			DAC SEQUENCE 
//------------------------------------------


class dac_seq extends uvm_sequence#(dac_tx);
	`uvm_object_utils(dac_seq)
	`NEW_OBJ
	
	task body();
		repeat(1_000) begin
		`uvm_do(req)
		//#22675.7;				
		#`AUDIO_CLK_FULL;
		end
		`uvm_info("DAC_SEQ","Running",UVM_HIGH)
	endtask	
	
endclass
