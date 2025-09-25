




class spdif_cov extends uvm_subscriber#(spdif_tx);
	`uvm_component_utils(spdif_cov)
	spdif_tx tx;
	
	
	covergroup spdif_cg;
		data_in: coverpoint tx.inport_tdata_i{	bins data_in[20] = {[0:$]};option.at_least = 10; }
		
		out1: coverpoint tx.spdif_o;
		out2: coverpoint tx.inport_tready_o;
		cross out1,data_in;
		
	endgroup


	function new (string name="", uvm_component parent=null); 
		super.new(name,parent); 
		spdif_cg =new();
	endfunction 


	function void write(T t);
		$cast(tx,t);
		spdif_cg.sample();
	endfunction


endclass
