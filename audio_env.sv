




class audio_env extends uvm_env;
	`uvm_component_utils(audio_env)
	spdif_agent spdif_agent_i;
	main_agent main_agent_i;
	i2s_agent i2s_agent_i;
	dac_agent dac_agent_i;
	`NEW
	bit [3:0] ag_sel;

	
	
	function void build_phase(uvm_phase phase);
		uvm_resource_db#(int)::read_by_name("GLOBAL","AGENT_SELECT",ag_sel,this);
		case(ag_sel)
			4'h0: begin
						spdif_agent_i = spdif_agent::type_id::create("spdif_agent_i",this);
						`uvm_info("ENV","Build Phase",UVM_HIGH)
				end
			4'h1: begin
					
						main_agent_i = main_agent::type_id::create("main_agent_i",this);
						`uvm_info("ENV","Build Phase",UVM_HIGH)
				end
			4'h2: begin
					
						i2s_agent_i = i2s_agent::type_id::create("i2s_agent_i",this);
						`uvm_info("ENV","Build Phase",UVM_HIGH)
				end
			4'h3: begin
					
						dac_agent_i = dac_agent::type_id::create("dac_agent_i",this);
						`uvm_info("ENV","Build Phase",UVM_HIGH)
				end
			4'h7: begin
						i2s_agent_i = i2s_agent::type_id::create("i2s_agent_i",this);
						main_agent_i = main_agent::type_id::create("main_agent_i",this);
						spdif_agent_i = spdif_agent::type_id::create("spdif_agent_i",this);
						dac_agent_i = dac_agent::type_id::create("dac_agent_i",this);
						`uvm_info("ENV","Build Phase",UVM_HIGH)
				end
		endcase
	endfunction
endclass
