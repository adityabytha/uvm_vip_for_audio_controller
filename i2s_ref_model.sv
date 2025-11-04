// Reference model (predictor) that maps 32-bit commands to expected I2C fields
// Abstract event describing an I2S strobe at sck falling edge
typedef struct packed {
  bit        ws;          // 0: Right, 1: Left
  bit        data_bit;    // data value at this strobe (MSB-first)
  int        bit_idx;     // 15..0 for 16-bit example
} i2s_evt_t;


// Transaction carrying one 32-bit stereo word to model
//class i2s_frame_tr extends uvm_sequence_item;
//  rand bit [31:0] frame32; // {L[15:0], R[15:0]} or {R,L} per spec
//  `uvm_object_utils(i2s_frame_tr)
//  function new(string name="i2s_frame_tr"); super.new(name); endfunction
//endclass

// Pure functional predictor (reference model)
class i2s_ref_model extends uvm_object;
  `uvm_object_utils(i2s_ref_model)

  // Configuration knobs
  bit msb_first = 1'b1;
  bit left_ws   = 1'b1;   // ws=1 for Left phase
  bit right_ws  = 1'b0;   // ws=0 for Right phase
  int width_l   = 16;     // bits per sample Left
  int width_r   = 16;     // bits per sample Right

  function new(string name="i2s_ref_model"); super.new(); endfunction

  // Decompose 32b frame into left/right words (adjust packing to DUT)
  function void unpack_frame(bit[31:0] frame,
                             output bit [15:0] left,
                             output bit [15:0] right);
    // Example packing: {left[15:0], right[15:0]}
    left  = frame[31:16];
    right = frame[15:0];
  endfunction

  // Produce expected event sequence for one frame: Right then Left (I2S timing)
  function void predict_frame(i2s_tx tr, ref i2s_evt_t evts[$]);
    bit [15:0] l, r;
    unpack_frame(tr.inport_tdata_i, l, r);

    // I2S commonly presents WS changing one bit clock before MSB and
    // data is latched on SCK falling edge; we model only the fall-edge samples[web:47].

    // Right channel phase (ws=0) first or per your DUT ordering
    for (int i = 0; i < width_r; i++) begin
      int bit_idx = msb_first ? (width_r-1 - i) : i;
      i2s_evt_t e;
      e.ws       = right_ws;
      e.data_bit = r[bit_idx];
      e.bit_idx  = bit_idx;
      evts.push_back(e);
    end

    // Left channel phase (ws=1)
    for (int i = 0; i < width_l; i++) begin
      int bit_idx = msb_first ? (width_l-1 - i) : i;
      i2s_evt_t e;
      e.ws       = left_ws;
      e.data_bit = l[bit_idx];
      e.bit_idx  = bit_idx;
      evts.push_back(e);
    end
  endfunction

  function i2s_evt_t event_record(i2s_tx tx);  //, ref i2s_evt_t evts[$]);
	i2s_evt_t e;
	e.ws	= tx.i2s_ws_o;
	e.data_bit = tx.i2s_sdata_o;
	//evts.push_back(e);
	return e;
	  //FIGURE OUT THIS SHOULD WRITE TO QUEUE AS SOON AS DATA COMES	
  endfunction


endclass

