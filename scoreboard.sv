class scoreboard extends uvm_scoreboard;
 
  `uvm_component_utils(scoreboard)
  uvm_analysis_imp#(seq_item, scoreboard) received_value;
 
  seq_item tr_q[$];  // Transaction queue
  bit [31:0] temp_data[int unsigned];   // Expected model of register values
 
  int match_count = 0;
 
  int mismatch_count = 0;
///////////////////////////////
  localparam bit [31:0] DEVICE_ID = 'h00;
 
  localparam bit [31:0] VERSION   = 'h04;
 
  localparam bit [31:0] LOCK_REG  = 'h5C;
 
///////////////////////////////
 
  function new(string name = "scoreboard", uvm_component parent = null);
 
    super.new(name, parent);
 
  endfunction
  virtual function void build_phase(uvm_phase phase);
 
    super.build_phase(phase);
 
    received_value = new("received_value", this);
    // Read-only registers: documented values
 
  temp_data['h00] = 'h02A55357; // DEVICE_ID
 
  temp_data['h04] = 'h00010200; // VERSION
  // Status / Config registers reset values
temp_data['h24] = 32'h0000000F; // PORT_ENABLE
temp_data['h28] = 32'h0000000F; // FWD_ENABLE
temp_data['h30] = 32'h00000401; // GEN_PKT_CFG
temp_data['h34] = 32'h00000002; // GEN_INTERVAL
temp_data['h38] = 32'h00000004; // GEN_COUNT
 

  // Registers with known reset values
 
  temp_data['h0C] = 'h0;        // PORT_STATUS
 
  temp_data['h10] = 'h0;        // GEN_STATUS
 
  temp_data['h14] = 'h0;        // STAT_RX
 
  temp_data['h18] = 'h0;        // STAT_TX
 
  temp_data['h1C] = 'h0;        // STAT_DROP
 
  temp_data['h54] = 'h0;        // ERR_COUNT
 
  temp_data['h58] = 'h0;        // ERR_INFO
 
  endfunction
  // Incoming transactions are pushed into the queue
 
  virtual function void write(seq_item tr);
 
    tr_q.push_back(tr);
 
  endfunction
  virtual task run_phase(uvm_phase phase);
 
    seq_item tr;
 
    forever begin
 
      wait(tr_q.size() > 0);
 
      tr = tr_q.pop_front();
      if (tr.psel == 1 && tr.penable == 1) begin
/*      if (tr.pwrite == 1'b1) begin  // WRITE
 
          temp_data[tr.paddr] = tr.pwdata;
 
          `uvm_info("SCOREBOARD", $sformatf("WRITE: Addr=%0h, Data=%0h, Stored=%0h", tr.paddr,tr.pwdata,temp_data[tr.paddr]), UVM_NONE);*/
 
      if (tr.pwrite == 1'b1) begin
  case (tr.paddr)
    DEVICE_ID, VERSION: begin
 
      // RO registers: do not update expected data on writes.
 
    end
    LOCK_REG: begin
 
      // Handle separately according to lock-register RTL behavior.
 
    end
////////////////
   'h30: begin
    temp_data[tr.paddr] = tr.pwdata;
 
    if (tr.pwdata[15:8] == 8'h00)
      temp_data[tr.paddr][15:8] = 8'h01;
  end
    ////////////
    default: begin
 
      temp_data[tr.paddr] = tr.pwdata;
 
    end
  endcase
  `uvm_info("SCOREBOARD",$sformatf("WRITE: Addr=%0h, Data=%0h",tr.paddr, tr.pwdata),UVM_NONE);
 
       end else begin  // READ
 
          `uvm_info("SCOREBOARD", $sformatf("READ: Addr=%0h, DUT Data=%0h, Expected=%0h", tr.paddr, tr.prdata, temp_data[tr.paddr]), UVM_NONE);
 
          compare(tr);
 
        end
      end
 
    end
 
  endtask
///////////////////////////////
virtual task compare(seq_item tr);
 
  bit [31:0] expected;
  case (tr.paddr)
 
    'h00: expected = 'h02A55357; // DEVICE_ID
 
    'h04: expected = 'h00010200; // VERSION
 
    // after unlock write to LOCK register
  'h08: expected = 32'h000000F1;
 
 
    default: expected = temp_data[tr.paddr];
 
  endcase
  if (expected == tr.prdata) begin
 
    match_count++;
 
    `uvm_info("SCOREBOARD",
 
      $sformatf("MATCH Addr=%0h Expected=%0h Got=%0h",
 
                tr.paddr, expected, tr.prdata),
 
      UVM_LOW)
 
  end
 
  else begin
 
    mismatch_count++;
 
    `uvm_error("SCOREBOARD",
 
      $sformatf("MISMATCH Addr=%0h Expected=%0h Got=%0h",
 
                tr.paddr, expected, tr.prdata))
 
  end
 
endtask
//////////////////////////////////   
 
/*virtual task compare(seq_item tr);
 
  if (temp_data[tr.paddr] == tr.prdata) begin
 
    match_count++;
 
    `uvm_info("SCOREBOARD", $sformatf("MATCH at Addr=%0h: Expected=%0h, Got=%0h", tr.paddr, temp_data[tr.paddr], tr.prdata), UVM_LOW);
 
  end else begin
 
    mismatch_count++;
 
    `uvm_error("SCOREBOARD", $sformatf("MISMATCH at Addr=%0h: Expected=%0h, Got=%0h", tr.paddr, temp_data[tr.paddr], tr.prdata));
 
  end
 
endtask*/
 
/////////////////////////////////////
  // Report match and mismatch count at end of simulation
 
  virtual function void report_phase(uvm_phase phase);
 
    `uvm_info("SCOREBOARD", "------------------ FINAL SCOREBOARD REPORT ------------------", UVM_NONE);
 
    `uvm_info("SCOREBOARD", $sformatf("Total Matches   : %0d", match_count), UVM_NONE);
 
    `uvm_info("SCOREBOARD", $sformatf("Total Mismatches: %0d", mismatch_count), UVM_NONE);
 
  endfunction
 
endclass


/*class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp#(seq_item, scoreboard) received_value;
  seq_item tr_q[$];  // Transaction queue

  bit [31:0] temp_data[int unsigned];   // Expected model of register values
  int match_count = 0;
  int mismatch_count = 0;

 ///////////////////////////////

  localparam bit [31:0] DEVICE_ID = 'h00;
  localparam bit [31:0] VERSION   = 'h04;
  localparam bit [31:0] LOCK_REG  = 'h5C;
///////////////////////////////
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    received_value = new("received_value", this);

    // Read-only registers: documented values
  temp_data['h00] = 'h02A55357; // DEVICE_ID
  temp_data['h04] = 'h00010200; // VERSION

  // Registers with known reset values
  temp_data['h0C] = 'h0;        // PORT_STATUS
  temp_data['h10] = 'h0;        // GEN_STATUS
  temp_data['h14] = 'h0;        // STAT_RX
  temp_data['h18] = 'h0;        // STAT_TX
  temp_data['h1C] = 'h0;        // STAT_DROP
  temp_data['h54] = 'h0;        // ERR_COUNT
  temp_data['h58] = 'h0;        // ERR_INFO
  endfunction

  // Incoming transactions are pushed into the queue
  virtual function void write(seq_item tr);
    tr_q.push_back(tr);
  endfunction

  virtual task run_phase(uvm_phase phase);
    seq_item tr;
    forever begin
      wait(tr_q.size() > 0);
      tr = tr_q.pop_front();

      if (tr.psel == 1 && tr.penable == 1) begin
///////
      if (tr.pwrite == 1'b1) begin  // WRITE
          temp_data[tr.paddr] = tr.pwdata;
          `uvm_info("SCOREBOARD", $sformatf("WRITE: Addr=%0h, Data=%0h, Stored=%0h", tr.paddr,tr.pwdata,temp_data[tr.paddr]), UVM_NONE);///////
      if (tr.pwrite == 1'b1) begin

  case (tr.paddr)

    DEVICE_ID, VERSION: begin
      // RO registers: do not update expected data on writes.
    end

    LOCK_REG: begin
      // Handle separately according to lock-register RTL behavior.
    end

    default: begin
      temp_data[tr.paddr] = tr.pwdata;
    end

  endcase

  `uvm_info("SCOREBOARD",$sformatf("WRITE: Addr=%0h, Data=%0h",tr.paddr, tr.pwdata),UVM_NONE);
       
       end else begin  // READ
          `uvm_info("SCOREBOARD", $sformatf("READ: Addr=%0h, DUT Data=%0h, Expected=%0h", tr.paddr, tr.prdata, temp_data[tr.paddr]), UVM_NONE);
          compare(tr);
        end

      end
    end
  endtask

///////////////////////////////

 virtual task compare(seq_item tr);
  bit [31:0] expected;

  case (tr.paddr)
    'h00: expected = 'h02A55357; // DEVICE_ID
    'h04: expected = 'h00010200; // VERSION
    default: expected = temp_data[tr.paddr];
  endcase

  if (expected == tr.prdata) begin
    match_count++;
    `uvm_info("SCOREBOARD",
      $sformatf("MATCH Addr=%0h Expected=%0h Got=%0h",
                tr.paddr, expected, tr.prdata),
      UVM_LOW)
  end
  else begin
    mismatch_count++;
    `uvm_error("SCOREBOARD",
      $sformatf("MISMATCH Addr=%0h Expected=%0h Got=%0h",
                tr.paddr, expected, tr.prdata))
  end
endtask

//////////////////////////////////   
virtual task compare(seq_item tr);
  if (temp_data[tr.paddr] == tr.prdata) begin
    match_count++;
    `uvm_info("SCOREBOARD", $sformatf("MATCH at Addr=%0h: Expected=%0h, Got=%0h", tr.paddr, temp_data[tr.paddr], tr.prdata), UVM_LOW);
  end else begin
    mismatch_count++;
    `uvm_error("SCOREBOARD", $sformatf("MISMATCH at Addr=%0h: Expected=%0h, Got=%0h", tr.paddr, temp_data[tr.paddr], tr.prdata));
  end
endtask
/////////////////////////////////////

  // Report match and mismatch count at end of simulation
  virtual function void report_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD", "------------------ FINAL SCOREBOARD REPORT ------------------", UVM_NONE);
    `uvm_info("SCOREBOARD", $sformatf("Total Matches   : %0d", match_count), UVM_NONE);
    `uvm_info("SCOREBOARD", $sformatf("Total Mismatches: %0d", mismatch_count), UVM_NONE);
  endfunction
endclass*/




/*

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  uvm_analysis_imp#(seq_item, scoreboard) received_value;
  reg_block regmodel;          // set by apbEnv; its mirror is the expected-value model
  localparam bit [31:0] UNLOCK_KEY  = 32'hA5A5_C3C3;
  localparam bit [15:0] ADDR_MAX    = 16'h0060;
  localparam bit [7:0]  IRQ_HW_BITS = 8'h7F;   // IRQ_STATUS bits the datapath can set (SW_EVENT is force-only)
  localparam bit [7:0]  ERR_HW_BITS = 8'h06;   // ERR_STATUS DEST_ERROR + QUEUE_OVERFLOW
  bit locked = 1;             // DUT comes out of reset locked
  bit hw_active = 0;          // generator was started: datapath can now change status/counters
  uvm_reg lock_gated[$];      // writes to these are dropped by the DUT while locked
  // Volatile registers the RAL mirror can't predict on its own
  bit [7:0]  irq_status = 0;
  bit [7:0]  err_status = 0;
  bit [15:0] err_count  = 0;
  bit [31:0] err_info   = 0;
  int match_count = 0;
  int mismatch_count = 0;
 
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    received_value = new("received_value", this);
  endfunction
 
  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    lock_gated.push_back(regmodel.switch_ctrl_inst);
    lock_gated.push_back(regmodel.port_enable_inst);
    lock_gated.push_back(regmodel.fwd_enable_inst);
    lock_gated.push_back(regmodel.gen_ctrl_inst);
    lock_gated.push_back(regmodel.gen_pkt_cfg_inst);
    lock_gated.push_back(regmodel.gen_interval_inst);
    lock_gated.push_back(regmodel.gen_count_inst);
    lock_gated.push_back(regmodel.irq_enable_inst);
    lock_gated.push_back(regmodel.err_enable_inst);
  endfunction
 
  // One call per completed APB transfer from the monitor

  virtual function void write(seq_item tx);
    uvm_reg rg;
    bit exp_err = (tx.paddr[1:0] != 0) || (tx.paddr > ADDR_MAX);
    check_irq(tx.irq);   // irq is sampled before this transfer takes effect
    if (tx.pslverr != exp_err) begin
      mismatch_count++;
      `uvm_error("SCOREBOARD", $sformatf("PSLVERR at Addr=%0h: Expected=%0b, Got=%0b", tx.paddr, exp_err, tx.pslverr));
      return;
    end

    if (exp_err) begin     // error response: no register is touched, read data is 0
      if (!tx.pwrite && tx.prdata != 0) begin
        mismatch_count++;
        `uvm_error("SCOREBOARD", $sformatf("Read data with PSLVERR at Addr=%0h: Expected=0, Got=%0h", tx.paddr, tx.prdata));
      end
      return;
    end
    rg = regmodel.default_map.get_reg_by_offset(tx.paddr, !tx.pwrite);
    if (rg == null) begin
      `uvm_error("SCOREBOARD", $sformatf("Addr=%0h has no register in the RAL model", tx.paddr));
      return;
    end
 
    if (tx.pwrite) predict_write(rg, tx.pwdata);
    else           check_read(rg, tx.prdata);
  endfunction
 
  function void predict_write(uvm_reg rg, bit [31:0] data);
    bit [7:0] err_en;
    if (rg == regmodel.soft_reset_reg_inst) begin
      if (data[0]) apply_soft_reset();
      return;
    end
 
    predict_irq_err(rg, data);   // W1C, IRQ_FORCE and ERR_INJECT work even while locked
    if (rg == regmodel.lock_reg_inst) begin
      locked = (data != UNLOCK_KEY);
      void'(rg.predict(locked, .kind(UVM_PREDICT_READ)));   // LOCKED is RO, so set it directly
      `uvm_info("SCOREBOARD", $sformatf("WRITE: LOCK=%0h -> locked=%0b", data, locked), UVM_NONE);
    end

    else if (locked && is_lock_gated(rg)) begin
      `uvm_info("SCOREBOARD", $sformatf("WRITE: %s=%0h ignored, DUT is locked", rg.get_name(), data), UVM_NONE);
    end

    else begin
      void'(rg.predict(data, .kind(UVM_PREDICT_WRITE)));
      // RTL turns LENGTH=0 into 1
      if (rg == regmodel.gen_pkt_cfg_inst && data[15:8] == 0)
        void'(regmodel.gen_pkt_cfg_inst.LENGTH.predict(1, .kind(UVM_PREDICT_READ)));
      // START with ENABLE: from here on the datapath changes status, stats, IRQ and ERR bits
      if (rg == regmodel.gen_ctrl_inst && data[0] && data[1] && !hw_active) begin
        hw_active = 1;
        `uvm_info("SCOREBOARD", "WRITE: GEN_CTRL START -> datapath active, hardware-set bits no longer checked", UVM_NONE);
      end

      `uvm_info("SCOREBOARD", $sformatf("WRITE: %s=%0h, Mirrored=%0h", rg.get_name(), data, rg.get_mirrored_value()), UVM_NONE);
    end
 
    // IRQ_STATUS.ERROR is set every cycle while an enabled error is pending

    err_en = regmodel.err_enable_inst.get_mirrored_value();
    if (|(err_status & err_en)) irq_status[1] = 1;
    sync_mirror();
  endfunction
 
  // IRQ/ERR side effects of one write, same order as the RTL next-state logic

  function void predict_irq_err(uvm_reg rg, bit [31:0] data);
    bit [7:0]    irq_force = (rg == regmodel.irq_force_inst)  ? data[7:0] : 8'h00;
    bit [7:0]    err_inj   = (rg == regmodel.err_inject_inst) ? data[7:0] : 8'h00;
    bit [7:0]    irq_w1c   = (rg == regmodel.irq_status_inst) ? data[7:0] : 8'h00;
    bit [7:0]    err_w1c   = (rg == regmodel.err_status_inst) ? data[7:0] : 8'h00;
    bit          clr_count = (rg == regmodel.err_inject_inst) && data[31];
    bit [7:0]    err_set   = (err_inj != 0) ? (err_inj | 8'h80) : 8'h00;   // any inject also sets INJECTED

    bit [7:0]    irq_set   = irq_force;
    bit [7:0]    err_en;
    int unsigned pop       = $countones(err_inj[6:0]);
    if (irq_force == 0 && err_inj == 0 && irq_w1c == 0 && err_w1c == 0 && !clr_count)
      return;
    err_en = regmodel.err_enable_inst.get_mirrored_value();
    if (|((err_status | err_set) & err_en)) irq_set[1] = 1;   // error promotion uses the pre-write status

    irq_status = (irq_status | irq_set) & ~irq_w1c;
    err_status = (err_status | err_set) & ~err_w1c;
 
    if (clr_count) begin

      err_count = 0;

      err_info  = 0;

    end

    else if (err_set != 0) begin

      if (err_inj[6:0] != 0)

        err_count = (err_count > 16'hFFFF - pop) ? 16'hFFFF : err_count + pop;   // saturates

      else if (err_count != 16'hFFFF)

        err_count++;

      err_info[7:0]   = lowest_bit(err_set);                                    // LAST_CODE

      err_info[15:8]  = 8'd1;                                                   // SOURCE: injected

      err_info[17:16] = regmodel.gen_pkt_cfg_inst.DST_PORT.get_mirrored_value();

      err_info[31:20] = 0;   // TX_SNAPSHOT = STAT_TX, 0 while no traffic (only checked then)

    end
 
    `uvm_info("SCOREBOARD", $sformatf("WRITE: %s=%0h -> IRQ_STATUS=%0h ERR_STATUS=%0h ERR_COUNT=%0d", rg.get_name(), data, irq_status, err_status, err_count), UVM_NONE);

  endfunction
 
  function void check_read(uvm_reg rg, bit [31:0] data);

    uvm_reg_data_t exp, mask;

    expected(rg, exp, mask);
 
    if ((data & mask) == (exp & mask)) begin

      match_count++;

      `uvm_info("SCOREBOARD", $sformatf("MATCH %s at Addr=%0h: Expected=%0h, Got=%0h", rg.get_name(), rg.get_address(), exp & mask, data & mask), UVM_LOW);

    end else begin

      mismatch_count++;

      `uvm_error("SCOREBOARD", $sformatf("MISMATCH %s at Addr=%0h: Expected=%0h, Got=%0h (compare mask %0h)", rg.get_name(), rg.get_address(), exp & mask, data & mask, mask));

    end
 
    // take the DUT value for bits the model can't predict (and after a mismatch)

    void'(rg.predict(data, .kind(UVM_PREDICT_READ)));

    if      (rg == regmodel.irq_status_inst) irq_status = data[7:0];

    else if (rg == regmodel.err_status_inst) err_status = data[7:0];

    else if (rg == regmodel.err_count_inst)  err_count  = data[15:0];

    else if (rg == regmodel.err_info_inst)   err_info   = data;

    else if (rg == regmodel.lock_reg_inst)       locked     = data[0];

  endfunction
 
  // Expected read value and compare mask for rg

  function void expected(uvm_reg rg, output uvm_reg_data_t exp, output uvm_reg_data_t mask);

    uvm_reg_field fields[$];
 
    exp  = rg.get_mirrored_value();

    mask = 0;

    rg.get_fields(fields);

    foreach (fields[i]) begin

      string acc = fields[i].get_access();

      uvm_reg_data_t bits = ((uvm_reg_data_t'(1) << fields[i].get_n_bits()) - 1) << fields[i].get_lsb_pos();

      if (acc.substr(0, 1) == "WO") begin   // write-only fields always read 0 in this DUT

        exp  &= ~bits;

        mask |= bits;

      end

      else if (!fields[i].is_volatile() && fields[i].get_compare() != UVM_NO_CHECK)

        mask |= bits;

    end
 
    // Volatile registers: check the bits the scoreboard knows

    if (rg == regmodel.status_inst) begin

      exp[2]   = regmodel.switch_ctrl_inst.ENABLE.get_mirrored_value();   // SWITCH_ENABLED

      exp[3]   = locked;                                                  // LOCKED

      exp[7:4] = regmodel.port_enable_inst.get_mirrored_value();          // PORT_ENABLED

      mask    |= 32'h0000_00FC;

      if (!hw_active) begin                                               // generator idle

        exp[0]     = 1;                  // READY

        exp[1]     = 0;                  // BUSY

        exp[8]     = 0;                  // GEN_RUNNING

        exp[9]     = (err_status != 0);  // ERR_PENDING

        exp[17:16] = 0;                  // GEN_FSM

        mask      |= 32'h0003_0303;

      end

    end

    else if (rg == regmodel.port_status_inst || rg == regmodel.gen_status_inst ||

             rg == regmodel.stat_rx_inst || rg == regmodel.stat_tx_inst || rg == regmodel.stat_drop_inst) begin

      if (!hw_active) begin              // no traffic since reset/SOFT_RESET: all zero

        exp  = 0;

        mask = 32'hFFFF_FFFF;

      end

    end

    else if (rg == regmodel.irq_status_inst) begin

      exp[7:0]  = irq_status;

      mask[7:0] = hw_active ? ~IRQ_HW_BITS : 8'hFF;

    end

    else if (rg == regmodel.err_status_inst) begin

      exp[7:0]  = err_status;

      mask[7:0] = hw_active ? ~ERR_HW_BITS : 8'hFF;

    end

    else if (rg == regmodel.err_count_inst || rg == regmodel.err_info_inst) begin

      if (!hw_active) begin

        exp  = (rg == regmodel.err_count_inst) ? err_count : err_info;

        mask = 32'hFFFF_FFFF;

      end

    end

  endfunction
 
  // irq = IRQ_GLOBAL_EN & |(IRQ_STATUS & IRQ_ENABLE); skipped when it depends on bits the datapath may set

  function void check_irq(bit irq);

    bit       global_en = regmodel.switch_ctrl_inst.IRQ_GLOBAL_EN.get_mirrored_value();

    bit [7:0] irq_en    = regmodel.irq_enable_inst.get_mirrored_value();

    bit [7:0] unknown   = hw_active ? IRQ_HW_BITS : 8'h00;

    bit       exp_irq;
 
    if (!global_en)                              exp_irq = 0;

    else if (|(irq_status & irq_en & ~unknown))  exp_irq = 1;

    else if (|(irq_en & unknown))                return;

    else                                         exp_irq = 0;
 
    if (irq != exp_irq) begin

      mismatch_count++;

      `uvm_error("SCOREBOARD", $sformatf("IRQ pin: Expected=%0b, Got=%0b (IRQ_STATUS=%0h, IRQ_ENABLE=%0h, IRQ_GLOBAL_EN=%0b)", exp_irq, irq, irq_status, irq_en, global_en));

    end

  endfunction
 
  // Keep the RAL mirror in step so sequences can use get_mirrored_value()

  function void sync_mirror();

    void'(regmodel.irq_status_inst.predict(irq_status, .kind(UVM_PREDICT_READ)));

    void'(regmodel.err_status_inst.predict(err_status, .kind(UVM_PREDICT_READ)));

    void'(regmodel.err_count_inst.predict(err_count, .kind(UVM_PREDICT_READ)));

    void'(regmodel.err_info_inst.predict(err_info, .kind(UVM_PREDICT_READ)));

  endfunction
 
  function bit [7:0] lowest_bit(bit [7:0] v);

    for (int i = 0; i < 8; i++)

      if (v[i]) return i;

    return 8'hFF;

  endfunction
 
  function bit is_lock_gated(uvm_reg rg);

    foreach (lock_gated[i])

      if (lock_gated[i] == rg) return 1;

    return 0;

  endfunction
 
  // SOFT_RESET restores reset values, re-locks, stops the generator and clears stats/queues

  function void apply_soft_reset();

    uvm_reg regs[$];

    regmodel.get_registers(regs);

    foreach (regs[i])

      if (!regs[i].is_busy()) regs[i].reset();   // reset() of the in-flight SOFT_RESET reg would free its semaphore

    locked     = 1;

    hw_active  = 0;

    irq_status = 0;

    err_status = 0;

    err_count  = 0;

    err_info   = 0;

    `uvm_info("SCOREBOARD", "WRITE: SOFT_RESET -> model reset, locked=1", UVM_NONE);

  endfunction
 
  // Report match and mismatch count at end of simulation

  virtual function void report_phase(uvm_phase phase);

    `uvm_info("SCOREBOARD", "------------------ FINAL SCOREBOARD REPORT ------------------", UVM_NONE);

    `uvm_info("SCOREBOARD", $sformatf("Total Matches   : %0d", match_count), UVM_NONE);

    `uvm_info("SCOREBOARD", $sformatf("Total Mismatches: %0d", mismatch_count), UVM_NONE);

    if (match_count + mismatch_count == 0)

      `uvm_warning("SCOREBOARD", "No register reads were checked");

  endfunction

endclass

*/ 
