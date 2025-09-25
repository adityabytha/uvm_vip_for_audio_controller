




class dac_cov extends uvm_subscriber#(dac_tx);
	`uvm_component_utils(dac_cov)
	dac_tx tx;
	
	
	covergroup dac_cg;
		data_in: coverpoint tx.inport_tdata_i{ bins data_in[20] = {[0:$]}; option.at_least = 34;  }
		
		out1: coverpoint tx.inport_tready_o;
		out_l: coverpoint tx.audio_l_o;
    	out_r: coverpoint tx.audio_r_o;
		
	endgroup


	function new (string name="", uvm_component parent=null); 
		super.new(name,parent); 
		dac_cg =new();
	endfunction 


	function void write(T t);
		$cast(tx,t);
		dac_cg.sample();
	endfunction


endclass
