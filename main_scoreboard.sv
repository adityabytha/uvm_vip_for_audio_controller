//This file is the common scoreboard for all the protocol transactions. Will
//check and implement separate ones if needed.



/*class main_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(main_scoreboard)

	uvm_analysis_imp#(i2s_tx,main_scoreboard) analysis_imp;

	function new(string name="",uvm_component parent=null);
		super.new(name,parent);
		analysis_imp = new("analysis_imp",this);
	endfunction
	
	virtual function void write(i2s_tx tx);
		`uvm_info(get_type_name(),$sformatf(" Inside write method. Recieved trans On Analysis Imp Port"),UVM_LOW)
		`uvm_info(get_type_name(),$sformatf(" Printing trans, \n %s",tx.sprint()),UVM_LOW)

	endfunction	

endclass


class i2s_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(i2s_scoreboard)

  // Analysis exports
  uvm_analysis_imp#(i2s_tx, i2s_scoreboard) exp_in; // input frames to model
  uvm_analysis_imp#(i2s_evt_t,    i2s_scoreboard) dut_in; // observed events from monitor

  // Model and FIFOs
  i2s_ref_model m;
  i2s_evt_t     exp_q[$];
  i2s_evt_t     dut_q[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    m = i2s_ref_model::type_id::create("m");
    exp_in = new("exp_in", this);
    dut_in = new("dut_in", this);
  endfunction

  // Collect expected events for each frame
  function void write(i2s_tx tr);
    i2s_evt_t tmp[$];
    m.predict_frame(tr, tmp); // generate golden sequence
    foreach (tmp[i]) exp_q.push_back(tmp[i]);
  endfunction

  // Collect observed events
  function void write(i2s_evt_t evt);
    dut_q.push_back(evt);
    // Optional: compare on-the-fly
    if (exp_q.size() > 0) begin
      i2s_evt_t exp = exp_q.pop_front();
      if (evt.ws !== exp.ws || evt.data_bit !== exp.data_bit) begin
        `uvm_error("I2S_SCB",
          $sformatf("Mismatch at bit %0d: ws exp=%0b got=%0b, data exp=%0b got=%0b",
                    exp.bit_idx, exp.ws, evt.ws, exp.data_bit, evt.data_bit))
      end
    end
  endfunction
endclass*/
class i2s_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(i2s_scoreboard)

  // One generic analysis_imp taking base type
//  typedef i2s_tx base_t;
//  uvm_analysis_imp#(base_t, i2s_scoreboard) any_in;
  uvm_analysis_imp#(i2s_tx, i2s_scoreboard) any_in;

  i2s_ref_model m;
  i2s_evt_t     exp_q[$];
  i2s_evt_t     dut_q[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    m = i2s_ref_model::type_id::create("m");
    any_in = new("any_in", this);
  endfunction

  // Single entry point with cast-based dispatch
//  function void write(base_t t);
  function void write(i2s_tx t);
    i2s_tx tr,tr1;
    i2s_evt_t    evt;

//	t.print();
    if (t.get_name() == "i2s_tx_DRV" && $cast(tr, t)) begin	//this if block gets input data from drv and writes expected values to the queue tmp[]
      i2s_evt_t tmp[$];
      m.predict_frame(tr, tmp);
          //`uvm_info("I2S_RX", $sformatf("Got tx name = %s", t.get_name()), UVM_NONE)
	  //`uvm_info("I2S_SCB","This is working, the code is in $cast(tr,t)  ----------------------",UVM_NONE)
      foreach (tmp[i]) exp_q.push_back(tmp[i]);
      return;
    end

    if (t.get_name() == "i2s_tx_MON" && $cast(tr1, t)) begin	//this if block gets one by one bit from after the start of output from module and adds each bit to the queue tmp1[]
	//write code for converting the i2s_tx from MON to i2s_event struct
	i2s_evt_t tmp1 = m.event_record(tr1);
	dut_q.push_back(tmp1);

          //`uvm_info("I2S_SCB","This is working, the code is in $cast(evt,t)  ----------------------",UVM_NONE)
      if (exp_q.size() > 0) begin			//this if block does the actual checking by comparing values from both queues and gives match or mismatch print
        i2s_evt_t exp = exp_q.pop_front();
        if (evt.ws !== exp.ws || evt.data_bit !== exp.data_bit) begin
          //`uvm_info("I2S_SCB","This is working, the code is in $cast(evt,t)  ----------------------",UVM_NONE)
		`uvm_error("I2S_SCB",$sformatf("Mismatch bit%0d: ws exp=%0b got=%0b, data exp=%0b got=%0b",exp.bit_idx, exp.ws, evt.ws, exp.data_bit, evt.data_bit))
        end
       	if (evt.ws == exp.ws || evt.data_bit == exp.data_bit) begin
		`uvm_info("I2S_SCB",$sformatf("Match bit%0d: ws exp=%0b got=%0b, data exp=%0b got=%0b",exp.bit_idx, exp.ws, evt.ws, exp.data_bit, evt.data_bit),UVM_INFO)
        end

      end
      return;
    end

    `uvm_warning("I2S_SCB", $sformatf("Unexpected item type: %s", t.get_type_name()))
  endfunction
endclass
	
