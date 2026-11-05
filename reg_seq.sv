class port_enable_seq extends uvm_sequence;
  `uvm_object_utils(port_enable_seq)

  reg_block regmodel;
  localparam bit[31:0] UNLOCK_KEY=32'hA5A5C3C3;
  function new (string name = "port_enable_seq");
    super.new(name);
  endfunction

  virtual task body;
    uvm_status_e status;
    bit [31:0] rdata, rdata_m, dout,reset_reg;
    `uvm_info("SEQ", "====== port_enable ======", UVM_NONE);


    regmodel.lock_reg_inst.write(status, UNLOCK_KEY);
    regmodel.lock_reg_inst.read(status, rdata);
    if (rdata[0] == 0)
      `uvm_info("SEQ", "LOCK -> unlocked", UVM_NONE)
    else
      `uvm_error("SEQ", $sformatf("LOCK still locked, read=%0h. Check key", rdata))

    rdata   = regmodel.port_enable_inst.get();
    rdata_m = regmodel.port_enable_inst.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("Initial port_enable -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.port_enable_inst.set(4'h1);
    rdata   = regmodel.port_enable_inst.get();
    rdata_m = regmodel.port_enable_inst.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After set port_enable -> Desired: %0h, Mirrored: %0h", rdata, rdata_m), UVM_NONE);

    regmodel.port_enable_inst.update(status);
    rdata   = regmodel.port_enable_inst.get();
    rdata_m = regmodel.port_enable_inst.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After update port_enable -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m, dout), UVM_NONE);

    regmodel.port_enable_inst.write(status,4'h1);
    rdata   = regmodel.port_enable_inst.get();
    rdata_m = regmodel.port_enable_inst.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After write port_enable -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m,dout), UVM_NONE);
    
    regmodel.port_enable_inst.read(status,dout);
    rdata   = regmodel.port_enable_inst.get();
    rdata_m = regmodel.port_enable_inst.get_mirrored_value();
    `uvm_info("SEQ", $sformatf("After read port_enable -> Desired: %0h, Mirrored: %0h, Read: %0h", rdata, rdata_m,dout), UVM_NONE);
    regmodel.sample_values();
   endtask
endclass


/*class all_registers_seq extends uvm_sequence;
  `uvm_object_utils(all_registers_seq)

  reg_block regmodel;

  localparam bit [31:0] UNLOCK_KEY = 32'hA5A5C3C3;

  function new(string name = "all_registers_seq");
    super.new(name);
  endfunction

  // Test an ordinary RW register
  task test_rw_reg(uvm_reg rg, bit [31:0] test_val);
    uvm_status_e status;
    bit [31:0] rdata;
    bit [31:0] mirror;

    `uvm_info("RAL_TEST",
      $sformatf("Testing RW register: %s", rg.get_name()),
      UVM_NONE)

    rg.read(status, rdata);

    rg.set(test_val);
    rg.update(status);

    rg.write(status, test_val);
    rg.read(status, rdata);

    mirror = rg.get_mirrored_value();

    if (rdata !== mirror)
      `uvm_error("RAL_TEST",
        $sformatf("%s mismatch: Read=%0h Mirror=%0h",
                  rg.get_name(), rdata, mirror))
    else
      `uvm_info("RAL_TEST",
        $sformatf("%s PASS: Read=%0h Mirror=%0h",
                  rg.get_name(), rdata, mirror),
        UVM_NONE)

  endtask


  // Test an RO register: read only
  task test_ro_reg(uvm_reg rg);
    uvm_status_e status;
    bit [31:0] rdata;

    `uvm_info("RAL_TEST",
      $sformatf("Reading RO register: %s", rg.get_name()),
      UVM_NONE)

    rg.read(status, rdata);

    if (status != UVM_IS_OK)
      `uvm_error("RAL_TEST",
        $sformatf("%s read failed", rg.get_name()))
    else
      `uvm_info("RAL_TEST",
        $sformatf("%s read = %0h", rg.get_name(), rdata),
        UVM_NONE)

  endtask


  virtual task body();
    uvm_status_e status;
    bit [31:0] rdata;

    `uvm_info("SEQ", "===== ALL REGISTER TEST START =====",
              UVM_NONE)

    // Unlock the register block
    regmodel.lock_reg_inst.write(status, UNLOCK_KEY);
    regmodel.lock_reg_inst.read(status, rdata);

    if (rdata[0] == 0)
      `uvm_info("SEQ", "Register block unlocked", UVM_NONE)
    else
      `uvm_error("SEQ", "Failed to unlock register block")


    // ------------------------------------------------
    // Read-only registers
    // ------------------------------------------------
    test_ro_reg(regmodel.device_id_inst);
    test_ro_reg(regmodel.version_inst);
    test_ro_reg(regmodel.switch_status_inst);
    test_ro_reg(regmodel.port_status_inst);
    test_ro_reg(regmodel.gen_status_inst);
    test_ro_reg(regmodel.stat_rx_inst);
    test_ro_reg(regmodel.stat_tx_inst);
    test_ro_reg(regmodel.stat_drop_inst);
    test_ro_reg(regmodel.err_count_inst);
    test_ro_reg(regmodel.err_info_inst);


    // ------------------------------------------------
    // Read/write registers
    // ------------------------------------------------
    test_rw_reg(regmodel.port_enable_inst, 32'h1);
    test_rw_reg(regmodel.fwd_enable_inst, 32'h1);
    test_rw_reg(regmodel.gen_pkt_cfg_inst, 32'h1);
    test_rw_reg(regmodel.gen_interval_inst, 32'h1);
    test_rw_reg(regmodel.gen_count_inst, 32'h1);
    test_rw_reg(regmodel.irq_enable_inst, 32'h1);
    test_rw_reg(regmodel.err_enable_inst, 32'h1);


    // ------------------------------------------------
    // Mixed-access and special registers
    // ------------------------------------------------
    // SWITCH_CTRL and GEN_CTRL contain mixed-access fields.
    // Test them separately using field-specific expectations.
    // IRQ_STATUS and ERR_STATUS are W1C.
    // IRQ_FORCE, ERR_INJECT and SOFT_RESET are WO.
    // Do not apply the generic RW test to these registers.

    `uvm_info("SEQ", "===== ALL REGISTER TEST END =====",
              UVM_NONE)

  endtask
endclass*/

class all_registers_seq extends uvm_sequence;
  `uvm_object_utils(all_registers_seq)

  reg_block regmodel;

  localparam bit [31:0] UNLOCK_KEY = 32'hA5A5C3C3;

  function new(string name = "all_registers_seq");
    super.new(name);
  endfunction


  // ------------------------------------------------
  // RO REGISTER TEST
  // ------------------------------------------------
  task test_ro_reg(uvm_reg rg);
    uvm_status_e status;
    bit [31:0] rdata;

    `uvm_info("RAL_TEST",
      $sformatf("========== START RO: %s ==========",
                rg.get_name()), UVM_NONE)

    rg.read(status, rdata);

    if (status != UVM_IS_OK) begin
      `uvm_error("RAL_TEST",
        $sformatf("%s FAIL: Read transaction failed",
                  rg.get_name()))
    end
    else begin
      `uvm_info("RAL_TEST",
        $sformatf("%s READ SUCCESS: Data = 0x%08h",
                  rg.get_name(), rdata), UVM_NONE)
    end

    `uvm_info("RAL_TEST",
      $sformatf("========== END RO: %s ==========",
                rg.get_name()), UVM_NONE)
  endtask


  // ------------------------------------------------
  // RW REGISTER TEST
  // ------------------------------------------------
  task test_rw_reg(uvm_reg rg, bit [31:0] test_val);
    uvm_status_e status;
    bit [31:0] rdata;
    bit [31:0] mirror;
    bit pass;

    pass = 1'b1;

    `uvm_info("RAL_TEST",
      $sformatf("========== START RW: %s ==========",
                rg.get_name()), UVM_NONE)

    // Write the expected test value
    rg.write(status, test_val);

    if (status != UVM_IS_OK) begin
      pass = 1'b0;
      `uvm_error("RAL_TEST",
        $sformatf("%s FAIL: Write transaction failed",
                  rg.get_name()))
    end

    // Read back the DUT value
    rg.read(status, rdata);

    if (status != UVM_IS_OK) begin
      pass = 1'b0;
      `uvm_error("RAL_TEST",
        $sformatf("%s FAIL: Read transaction failed",
                  rg.get_name()))
    end
    else begin
      // Compare actual read data with expected value
      if (rdata !== test_val) begin
        pass = 1'b0;
        `uvm_error("RAL_TEST",
          $sformatf("%s FAIL: Expected=0x%08h Actual=0x%08h",
                    rg.get_name(), test_val, rdata))
      end

      // Compare actual read data with RAL mirror
      mirror = rg.get_mirrored_value();

      if (rdata !== mirror) begin
        pass = 1'b0;
        `uvm_error("RAL_TEST",
          $sformatf("%s MIRROR MISMATCH: Read=0x%08h Mirror=0x%08h",
                    rg.get_name(), rdata, mirror))
      end
    end

    if (pass)
      `uvm_info("RAL_TEST",
        $sformatf("%s PASS: Expected=0x%08h Read=0x%08h Mirror=0x%08h",
                  rg.get_name(), test_val, rdata, mirror), UVM_NONE)

    `uvm_info("RAL_TEST",
      $sformatf("========== END RW: %s ==========",
                rg.get_name()), UVM_NONE)
  endtask


  // ------------------------------------------------
  // WO REGISTER TEST
  // ------------------------------------------------
  task test_wo_reg(uvm_reg rg, bit [31:0] test_val);
    uvm_status_e status;

    `uvm_info("RAL_TEST",
      $sformatf("========== START WO: %s ==========",
                rg.get_name()), UVM_NONE)

    // WO registers must not be read back
    rg.write(status, test_val);

    if (status != UVM_IS_OK) begin
      `uvm_error("RAL_TEST",
        $sformatf("%s FAIL: Write transaction failed",
                  rg.get_name()))
    end
    else begin
      `uvm_info("RAL_TEST",
        $sformatf("%s WRITE TRANSACTION SUCCESS: Data=0x%08h",
                  rg.get_name(), test_val), UVM_NONE)
    end

    `uvm_info("RAL_TEST",
      $sformatf("========== END WO: %s ==========",
                rg.get_name()), UVM_NONE)
  endtask


  // ------------------------------------------------
  // MAIN SEQUENCE
  // ------------------------------------------------
  virtual task body();
    uvm_status_e status;
    bit [31:0] rdata;

    `uvm_info("SEQ",
      "========== REGISTER VERIFICATION START ==========",
      UVM_NONE)

    // Unlock register block
    `uvm_info("SEQ", "Unlocking register block...", UVM_NONE)

    regmodel.lock_reg_inst.write(status, UNLOCK_KEY);

    if (status != UVM_IS_OK) begin
      `uvm_fatal("SEQ", "Unlock register write failed")
    end

    regmodel.lock_reg_inst.read(status, rdata);

    if (status != UVM_IS_OK) begin
      `uvm_fatal("SEQ", "Unlock register read failed")
    end
    else if (rdata[0] == 1'b0) begin
      `uvm_info("SEQ", "Register block unlocked successfully",
                UVM_NONE)
    end
    else begin
      `uvm_fatal("SEQ", "Register block failed to unlock")
    end


    // ================================================
    // READ-ONLY REGISTERS
    // ================================================
    `uvm_info("SEQ", "----- RO REGISTER TESTS START -----", UVM_NONE)

    test_ro_reg(regmodel.device_id_inst);
    test_ro_reg(regmodel.version_inst);
    test_ro_reg(regmodel.switch_status_inst);
    test_ro_reg(regmodel.port_status_inst);
    test_ro_reg(regmodel.gen_status_inst);
    test_ro_reg(regmodel.stat_rx_inst);
    test_ro_reg(regmodel.stat_tx_inst);
    test_ro_reg(regmodel.stat_drop_inst);
    test_ro_reg(regmodel.err_count_inst);
    test_ro_reg(regmodel.err_info_inst);

    `uvm_info("SEQ", "----- RO REGISTER TESTS END -----", UVM_NONE)


    // ================================================
    // READ-WRITE REGISTERS
    // ================================================
    `uvm_info("SEQ", "----- RW REGISTER TESTS START -----", UVM_NONE)

    test_rw_reg(regmodel.port_enable_inst,   32'h00000001);
    test_rw_reg(regmodel.fwd_enable_inst,    32'h00000001);
    test_rw_reg(regmodel.gen_pkt_cfg_inst,   32'h00000101);
    test_rw_reg(regmodel.gen_interval_inst,  32'h00000001);
    test_rw_reg(regmodel.gen_count_inst,     32'h00000001);
    test_rw_reg(regmodel.irq_enable_inst,    32'h00000001);
    test_rw_reg(regmodel.err_enable_inst,    32'h00000001);

    `uvm_info("SEQ", "----- RW REGISTER TESTS END -----", UVM_NONE)


    // ================================================
    // WRITE-ONLY REGISTERS
    // ================================================
    `uvm_info("SEQ", "----- WO REGISTER TESTS START -----", UVM_NONE)

    test_wo_reg(regmodel.irq_force_inst,  32'h00000001);
    test_wo_reg(regmodel.err_inject_inst, 32'h00000001);

    // Keep SOFT_RESET last because it may reset the DUT.
    test_wo_reg(regmodel.soft_reset_reg_inst, 32'h00000001);

    `uvm_info("SEQ", "----- WO REGISTER TESTS END -----", UVM_NONE)


    `uvm_info("SEQ",
      "========== REGISTER VERIFICATION END ==========",
      UVM_NONE)

    regmodel.sample_values();

  endtask

endclass



///backdoor/////

class port_enable_backdoor_seq extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(port_enable_backdoor_seq)

  reg_block       regmodel;
  uvm_status_e    status;
  uvm_reg_data_t  rdata;
  uvm_reg_data_t  expected;

  function new(string name = "port_enable_backdoor_seq");
    super.new(name);
  endfunction

  task body();

    expected = 32'h0000_0005;

    `uvm_info("BACKDOOR","Starting port_enable backdoor test",UVM_LOW)

    // Backdoor write
    regmodel.port_enable_inst.write(.status(status),.value(expected),.path(UVM_BACKDOOR));

    if (status != UVM_IS_OK) begin
      `uvm_error("BACKDOOR", "Backdoor write failed")
      return;
    end

    `uvm_info("BACKDOOR",
      $sformatf("Write successful: 0x%08h", expected),
      UVM_LOW)

    // Backdoor read
    regmodel.port_enable_inst.read(.status(status),.value(rdata),.path(UVM_BACKDOOR));

    if (status != UVM_IS_OK) begin
      `uvm_error("BACKDOOR", "Backdoor read failed")
      return;
    end

    `uvm_info("BACKDOOR",
      $sformatf("Read data = 0x%08h, Expected = 0x%08h",
                rdata, expected),
      UVM_LOW)

    // Compare only the implemented 4 bits
    if (rdata[3:0] == expected[3:0]) begin
      `uvm_info("BACKDOOR",
        "PORT_ENABLE BACKDOOR TEST PASSED",
        UVM_LOW)
    end
    else begin
      `uvm_error("BACKDOOR",
        $sformatf("PORT_ENABLE BACKDOOR TEST FAILED: Got=0x%08h Expected=0x%08h",
                  rdata, expected))
    end

    `uvm_info("BACKDOOR",
      "Completed port_enable backdoor test",
      UVM_LOW)

    regmodel.sample_values();
  endtask

endclass


///peek poke///

class port_enable_peekpoke_seq extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(port_enable_peekpoke_seq)

  reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "port_enable_peekpoke_seq");
    super.new(name);
  endfunction

  task body();

    // Directly write to the DUT's internal register
    regmodel.port_enable_inst.poke(status, 32'h0000_0005);

    // Directly read the DUT's internal register
    regmodel.port_enable_inst.peek(status, rdata);

    // Compare the value
    if (rdata[3:0] == 4'h5)
      `uvm_info("BACKDOOR_peek", "PASS: port_enable = 5", UVM_LOW)
    else
      `uvm_error("BACKDOOR_peek", $sformatf("FAIL: Expected 5, Got %0h", rdata))

    regmodel.sample_values();
  endtask
endclass




//reset//


class reg_reset_check_seq extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(reg_reset_check_seq)

  uvm_reg_block regmodel;
  uvm_reg regs[$];

  function new(string name = "reg_reset_check_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
    uvm_reg_data_t actual;
    uvm_reg_data_t expected;
    int pass_count = 0;
    int fail_count = 0;

    if (regmodel == null) begin
      `uvm_fatal("RESET_SEQ", "RAL model is null")
    end

    regmodel.get_registers(regs);

    `uvm_info("RESET_SEQ","Starting register reset-value checking",UVM_LOW)

    foreach (regs[i]) begin

      expected = regs[i].get_reset("HARD");
      regs[i].read(.status(status)
                   ,.value(actual)
                   ,.path(UVM_FRONTDOOR)
                   ,.map(regmodel.default_map),.parent(this));

      if (status != UVM_IS_OK) begin
        `uvm_error("RESET_SEQ",$sformatf("%s: READ FAILED",regs[i].get_name()))
        fail_count++;
      end
      else if (actual === expected) begin
        `uvm_info("RESET_SEQ",$sformatf("%s | Expected=0x%0h | Read=0x%0h | PASS",regs[i].get_name(), expected, actual),UVM_LOW)
        pass_count++;
      end
      else begin
        `uvm_error("RESET_SEQ",$sformatf("%s | Expected=0x%0h | Read=0x%0h | FAIL",regs[i].get_name(), expected, actual))
        fail_count++;
      end
    end
    `uvm_info("RESET_SEQ",$sformatf("RESET CHECK COMPLETE | Total=%0d | PASS=%0d | FAIL=%0d",regs.size(), pass_count, fail_count),UVM_LOW)

    regmodel.sample_values();
  endtask
endclass

/*
class all_registers_backdoor_seq extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(all_registers_backdoor_seq)

  reg_block regmodel;

  uvm_reg       regs[$];
  uvm_status_e  status;
  uvm_reg_data_t rdata;

  function new(string name = "all_registers_backdoor_seq");
    super.new(name);
  endfunction

  task body();

    if (regmodel == null) begin
      `uvm_fatal("BD_SEQ", "Register model handle is NULL")
    end

    // Add all 25 registers
    regs.push_back(regmodel.device_id_inst);
    regs.push_back(regmodel.version_inst);
    regs.push_back(regmodel.switch_status_inst);
    regs.push_back(regmodel.port_status_inst);
    regs.push_back(regmodel.gen_status_inst);
    regs.push_back(regmodel.stat_rx_inst);
    regs.push_back(regmodel.stat_tx_inst);
    regs.push_back(regmodel.stat_drop_inst);
    regs.push_back(regmodel.switch_ctrl_inst);
    regs.push_back(regmodel.port_enable_inst);
    regs.push_back(regmodel.fwd_enable_inst);
    regs.push_back(regmodel.gen_ctrl_inst);
    regs.push_back(regmodel.gen_pkt_cfg_inst);
    regs.push_back(regmodel.gen_interval_inst);
    regs.push_back(regmodel.gen_count_inst);
    regs.push_back(regmodel.irq_status_inst);
    regs.push_back(regmodel.irq_enable_inst);
    regs.push_back(regmodel.irq_force_inst);
    regs.push_back(regmodel.err_status_inst);
    regs.push_back(regmodel.err_enable_inst);
    regs.push_back(regmodel.err_inject_inst);
    regs.push_back(regmodel.err_count_inst);
    regs.push_back(regmodel.err_info_inst);
    regs.push_back(regmodel.lock_reg_inst);
    regs.push_back(regmodel.soft_reset_reg_inst);

    #35ns;
    `uvm_info("BD_SEQ", "Starting backdoor register reads", UVM_LOW)

    foreach (regs[i]) begin
      rdata = '0;

      `uvm_info("BD_SEQ",
                $sformatf("Reading register: %s",
                          regs[i].get_name()),
                UVM_LOW)
     
      regs[i].peek(status, rdata, "RTL");

      if (status == UVM_IS_OK) begin
        `uvm_info("BD_PASS",
                  $sformatf("%-20s Read = 0x%08h",
                            regs[i].get_name(), rdata),
                  UVM_LOW)
      end
      else begin
        `uvm_error("BD_FAIL",
                   $sformatf("%s backdoor read failed. Check HDL path.",
                             regs[i].get_name()))
      end
    end

    `uvm_info("BD_SEQ", "Backdoor register reads completed", UVM_LOW)

  endtask
endclass*/
/*

class all_registers_backdoor_seq extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(all_registers_backdoor_seq)

  reg_block regmodel;

  uvm_status_e status;
  uvm_reg_data_t poke_data;
  uvm_reg_data_t peek_data;

  uvm_reg rw_regs[$];

  function new(string name = "all_registers_backdoor_seq");
    super.new(name);
  endfunction

  task body();

    #35ns;

    // RW registers
    rw_regs.push_back(regmodel.switch_ctrl_inst);
    rw_regs.push_back(regmodel.port_enable_inst);
    rw_regs.push_back(regmodel.fwd_enable_inst);
    rw_regs.push_back(regmodel.gen_ctrl_inst);
    rw_regs.push_back(regmodel.gen_pkt_cfg_inst);
    rw_regs.push_back(regmodel.gen_interval_inst);
    rw_regs.push_back(regmodel.gen_count_inst);
    rw_regs.push_back(regmodel.irq_enable_inst);
    rw_regs.push_back(regmodel.err_enable_inst);
    rw_regs.push_back(regmodel.err_count_inst);
    rw_regs.push_back(regmodel.err_info_inst);
    rw_regs.push_back(regmodel.lock_reg_inst);

    // POKE and PEEK every RW register
    foreach (rw_regs[i]) begin

      poke_data = 32'h5;

      `uvm_info("BD_TEST",
        $sformatf("POKING %s with 0x%0h",
                  rw_regs[i].get_name(), poke_data), UVM_LOW)

      rw_regs[i].poke(status, poke_data, "RTL");

      if (status != UVM_IS_OK) begin
        `uvm_error("POKE_FAIL", rw_regs[i].get_name())
        continue;
      end

      rw_regs[i].peek(status, peek_data, "RTL");

      if (status != UVM_IS_OK) begin
        `uvm_error("PEEK_FAIL", rw_regs[i].get_name())
      end
      else if (peek_data === poke_data) begin
        `uvm_info("BD_PASS",
          $sformatf("%s Expected=0x%0h Actual=0x%0h",
                    rw_regs[i].get_name(), poke_data, peek_data),
          UVM_LOW)
      end
      else begin
        `uvm_error("BD_MISMATCH",
          $sformatf("%s Expected=0x%0h Actual=0x%0h",
                    rw_regs[i].get_name(), poke_data, peek_data))
      end

    end

  endtask

endclass*/

class all_registers_backdoor_seq extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(all_registers_backdoor_seq)

  reg_block regmodel;

  uvm_status_e status;
  uvm_reg_data_t poke_data;
  uvm_reg_data_t peek_data;

  function new(string name = "all_registers_backdoor_seq");
    super.new(name);
  endfunction


  // ------------------------------------------------
  // Task 1: POKE followed by PEEK
  // ------------------------------------------------

  task automatic do_poke_peek(
    uvm_reg reg_h,
    uvm_reg_data_t data,
    uvm_reg_data_t mask
  );

    poke_data = data;
    peek_data = '0;

    `uvm_info("BD_TEST",
      $sformatf("POKING %s with 0x%0h",
                reg_h.get_name(), poke_data), UVM_LOW)

    reg_h.poke(status, poke_data, "RTL");

    if (status != UVM_IS_OK) begin
      `uvm_error("POKE_FAIL",
        $sformatf("%s POKE failed", reg_h.get_name()))
    end
    else begin

      reg_h.peek(status, peek_data, "RTL");

      if (status != UVM_IS_OK) begin
        `uvm_error("PEEK_FAIL",
          $sformatf("%s PEEK failed", reg_h.get_name()))
      end
      else if ((peek_data & mask) === (poke_data & mask)) begin

        `uvm_info("BD_PASS",
          $sformatf("%s Expected=0x%0h Actual=0x%0h",
                    reg_h.get_name(),
                    (poke_data & mask),
                    (peek_data & mask)), UVM_LOW)

      end
      else begin

        `uvm_error("BD_MISMATCH",
          $sformatf("%s Expected=0x%0h Actual=0x%0h",
                    reg_h.get_name(),
                    (poke_data & mask),
                    (peek_data & mask)))

      end
    end

  endtask


  // ------------------------------------------------
  // Task 2: PEEK-only for calculated/status signals
  // ------------------------------------------------

  task automatic do_peek(uvm_reg reg_h);

    peek_data = '0;

    `uvm_info("BD_TEST",
      $sformatf("PEEKING %s", reg_h.get_name()), UVM_LOW)

    reg_h.peek(status, peek_data, "RTL");

    if (status == UVM_IS_OK) begin

      `uvm_info("BD_PASS",
        $sformatf("%s Read = 0x%0h",
                  reg_h.get_name(), peek_data), UVM_LOW)

    end
    else begin

      `uvm_error("PEEK_FAIL",
        $sformatf("%s PEEK failed", reg_h.get_name()))

    end

  endtask


  // ------------------------------------------------
  // Main sequence
  // ------------------------------------------------

  task body();

    `uvm_info("BD_SEQ",
      "Waiting for reset to complete", UVM_LOW)

    #35ns;

    `uvm_info("BD_SEQ",
      "Starting all-register backdoor test", UVM_LOW)


    // ================================================
    // GROUP 1: STORAGE REGISTERS - POKE + PEEK
    // ================================================

    do_poke_peek(regmodel.switch_ctrl_inst,
                 32'h00000009, 32'h00000009);

    do_poke_peek(regmodel.port_enable_inst,
                 32'h00000005, 32'h0000000F);

    do_poke_peek(regmodel.fwd_enable_inst,
                 32'h0000000A, 32'h0000000F);

    do_poke_peek(regmodel.gen_ctrl_inst,
                 32'h00000009, 32'h00000009);

    do_poke_peek(regmodel.gen_pkt_cfg_inst,
                 32'h00000509, 32'h00FFFF0F);

    do_poke_peek(regmodel.gen_interval_inst,
                 32'h00001234, 32'h0000FFFF);

    do_poke_peek(regmodel.gen_count_inst,
                 32'h00005678, 32'h0000FFFF);

    do_poke_peek(regmodel.irq_status_inst,
                 32'h00000005, 32'h000000FF);

    do_poke_peek(regmodel.irq_enable_inst,
                 32'h0000000A, 32'h000000FF);

    do_poke_peek(regmodel.err_status_inst,
                 32'h00000003, 32'h000000FF);

    do_poke_peek(regmodel.err_enable_inst,
                 32'h00000006, 32'h000000FF);

    do_poke_peek(regmodel.err_count_inst,
                 32'h00001234, 32'h0000FFFF);

    do_poke_peek(regmodel.err_info_inst,
                 32'h000005A5, 32'hFFFFFFFF);

    do_poke_peek(regmodel.lock_reg_inst,
                 32'h00000001, 32'h00000001);


    // ================================================
    // GROUP 2: COMBINATIONAL / STATUS - PEEK ONLY
    // ================================================

    do_peek(regmodel.switch_status_inst);

    do_peek(regmodel.port_status_inst);

    do_peek(regmodel.gen_status_inst);

    do_peek(regmodel.stat_rx_inst);

    do_peek(regmodel.stat_tx_inst);

    do_peek(regmodel.stat_drop_inst);


    // ================================================
    // GROUP 3: NO DIRECT BACKDOOR STORAGE
    // ================================================

    `uvm_info("BD_SKIP",
      "device_id_inst : Constant read-only register",
      UVM_LOW)

    `uvm_info("BD_SKIP",
      "version_inst : Constant read-only register",
      UVM_LOW)

    `uvm_info("BD_SKIP",
      "irq_force_inst : Command register, no storage",
      UVM_LOW)

    `uvm_info("BD_SKIP",
      "err_inject_inst : Command register, no storage",
      UVM_LOW)

    `uvm_info("BD_SKIP",
      "soft_reset_reg_inst : Command register, no storage",
      UVM_LOW)


    `uvm_info("BD_SEQ",
      "All-register backdoor test completed", UVM_LOW)

    regmodel.sample_values();
  endtask

endclass
