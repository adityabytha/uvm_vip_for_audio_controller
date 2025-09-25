




class i2s_cov extends uvm_subscriber#(i2s_tx);
	`uvm_component_utils(i2s_cov)
	i2s_tx tx;
	
	
	covergroup i2s_cg;
		data_in: coverpoint tx.inport_tdata_i{ bins data_in[20] = {[0:$]};option.at_least = 10;  }
		
		out1: coverpoint tx.i2s_ws_o;
		out2: coverpoint tx.inport_tready_o;
		coverpoint tx.i2s_sck_o;
		coverpoint tx.i2s_sdata_o;
		

	endgroup


	function new (string name="", uvm_component parent=null); 
		super.new(name,parent); 
		i2s_cg =new();
	endfunction 


	function void write(T t);
		$cast(tx,t);
		i2s_cg.sample();
	endfunction


endclass
