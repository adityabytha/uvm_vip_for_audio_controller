




class main_cov extends uvm_subscriber#(audio_tx);
	`uvm_component_utils(main_cov)
	audio_tx tx;
	
	covergroup main_cg_i;
		coverpoint tx.cfg_awvalid_i;
		coverpoint tx.cfg_awaddr_i {
			bins half_1={[0:32'h80000000]};
			bins half_2={[32'h80000001:$]};
		}
	   coverpoint tx.cfg_wvalid_i;
	   coverpoint tx.cfg_wdata_i {
			bins half_1={[0:32'h80000000]};
			bins half_2={[32'h80000001:$]};
		}
	   coverpoint tx.cfg_wstrb_i;
	   coverpoint tx.cfg_bready_i;
	   coverpoint tx.cfg_arvalid_i;
	   coverpoint tx.cfg_araddr_i{
			bins half_1={[0:32'h80000000]};
			bins half_2={[32'h80000001:$]};
		}
	   coverpoint tx.cfg_rready_i;
	endgroup
	
	
	
	covergroup main_cg_o;
		
	coverpoint tx.cfg_awready_o;
    coverpoint tx.cfg_wready_o;
    coverpoint tx.cfg_bvalid_o;
    coverpoint tx.cfg_bresp_o;
    coverpoint tx.cfg_arready_o;
    coverpoint tx.cfg_rvalid_o;
    coverpoint tx.cfg_rdata_o {
			bins half_1={[0:32'h80000000]};
			bins half_2={[32'h80000001:$]};
		}
    coverpoint tx.cfg_rresp_o;
    coverpoint tx.audio_l_o;
    coverpoint tx.audio_r_o;
    coverpoint tx.spdif_o;
    coverpoint tx.i2s_sck_o;
    coverpoint tx.i2s_sdata_o;
    coverpoint tx.i2s_ws_o;
    coverpoint tx.intr_o;
		
	
	endgroup

	covergroup main_cg_i_o;
		coverpoint tx.cfg_awvalid_i;
		awaddr: coverpoint tx.cfg_awaddr_i { bins range[20] = {[0:$]}; option.at_least = 34;	}
	   coverpoint tx.cfg_wvalid_i;
	   wdata: coverpoint tx.cfg_wdata_i { bins range[20] = {[0:$]}; option.at_least = 34;	}
	   coverpoint tx.cfg_wstrb_i;
	   coverpoint tx.cfg_bready_i;
	   coverpoint tx.cfg_arvalid_i;
	   coverpoint tx.cfg_araddr_i{ bins range[20] = {[0:$]}; option.at_least = 34;	}
	   coverpoint tx.cfg_rready_i;

		////Now Outputs
	coverpoint tx.cfg_awready_o;
    coverpoint tx.cfg_wready_o;
    coverpoint tx.cfg_bvalid_o;
    coverpoint tx.cfg_bresp_o;
    coverpoint tx.cfg_arready_o;
    coverpoint tx.cfg_rvalid_o;
    coverpoint tx.cfg_rdata_o { bins range[20] = {[0:$]}; option.at_least = 34;	}
    coverpoint tx.cfg_rresp_o;
    coverpoint tx.audio_l_o;
    coverpoint tx.audio_r_o;
    coverpoint tx.spdif_o;
   i2s_1: coverpoint tx.i2s_sck_o;
   i2s_2: coverpoint tx.i2s_sdata_o;
   i2s_3: coverpoint tx.i2s_ws_o;
    coverpoint tx.intr_o;
		////Cross-Coupling
	i2s_out: cross awaddr,wdata,i2s_1,i2s_2,i2s_3;
	
	endgroup


	function new (string name="", uvm_component parent=null); 
		super.new(name,parent); 
		//main_cg_i =new();
		//main_cg_o =new();
		main_cg_i_o =new();
	endfunction 




	function void write(T t);
		$cast(tx,t);
		//main_cg_o.sample();
		//main_cg_i.sample();
		main_cg_i_o.sample();
	endfunction



endclass

