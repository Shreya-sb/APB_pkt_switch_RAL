class device_id_reg extends uvm_reg;
  `uvm_object_utils(device_id_reg)

  rand uvm_reg_field revision;
  rand uvm_reg_field vendor_id;
  rand uvm_reg_field product_id;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_revision;
  uvm_reg_data_t cov_vendor_id;
  uvm_reg_data_t cov_product_id;

  covergroup device_id_reg_cg;
  cp_revision: coverpoint cov_revision {
  bins value_0={0};
  bins value_1={1};}
  
  cp_vendor_id: coverpoint cov_vendor_id {
  bins value_0={0};
  bins value_1={1};}

  cp_product_id: coverpoint cov_product_id {
  bins value_0={0};
  //bins value_1={1};
}
  endgroup


  function new(string name = "device_id_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    device_id_reg_cg = new();
  endfunction

  virtual function void build();
    revision = uvm_reg_field::type_id::create("revision");
    revision.configure(this, 8, 24, "RO", 0, 32'h00000002, 1, 0, 1);

    vendor_id = uvm_reg_field::type_id::create("vendor_id");
    vendor_id.configure(this, 8, 16, "RO", 0, 32'h000000A5, 1, 0, 1);

    product_id = uvm_reg_field::type_id::create("product_id");
    product_id.configure(this, 16, 0, "RO", 0, 32'h00005357, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_revision = revision.get_mirrored_value();
      cov_vendor_id = vendor_id.get_mirrored_value();
      cov_product_id = product_id.get_mirrored_value();
      device_id_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h00 (device_id_reg)

class version_reg extends uvm_reg;
  `uvm_object_utils(version_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field major;
  rand uvm_reg_field minor;
  rand uvm_reg_field patch;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_major;
  uvm_reg_data_t cov_minor;
  uvm_reg_data_t cov_patch;

  // VERSION
covergroup version_reg_cg;
  cp_major: coverpoint cov_major {bins value_0={0};
                                  //bins value_1={1};
                                  }
  cp_minor: coverpoint cov_minor {bins value_0={0};
                                  bins value_1={1}; }
  cp_patch: coverpoint cov_patch {bins value_0={0};
                                  //bins value_1={1};
}
endgroup

  function new(string name = "version_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    version_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 8, 24, "RO", 0, 32'h00000000, 1, 0, 1);

    major = uvm_reg_field::type_id::create("major");
    major.configure(this, 8, 16, "RO", 0, 32'h00000001, 1, 0, 1);

    minor = uvm_reg_field::type_id::create("minor");
    minor.configure(this, 8, 8, "RO", 0, 32'h00000002, 1, 0, 1);

    patch = uvm_reg_field::type_id::create("patch");
    patch.configure(this, 8, 0, "RO", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_major = major.get_mirrored_value();
      cov_minor = minor.get_mirrored_value();
      cov_patch = patch.get_mirrored_value();
      version_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h04 (version_reg)

class switch_status_reg extends uvm_reg;
  `uvm_object_utils(switch_status_reg)

  rand uvm_reg_field reserved_31_18;
  rand uvm_reg_field gen_fsm;
  rand uvm_reg_field reserved_15_10;
  rand uvm_reg_field err_pending;
  rand uvm_reg_field gen_running;
  rand uvm_reg_field port_enabled;
  rand uvm_reg_field locked;
  rand uvm_reg_field switch_enabled;
  rand uvm_reg_field busy;
  rand uvm_reg_field ready;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_gen_fsm;
  uvm_reg_data_t cov_err_pending;
  uvm_reg_data_t cov_gen_running;
  uvm_reg_data_t cov_port_enabled;
  uvm_reg_data_t cov_locked;
  uvm_reg_data_t cov_switch_enabled;
  uvm_reg_data_t cov_busy;
  uvm_reg_data_t cov_ready;

// SWITCH_STATUS
 covergroup switch_status_reg_cg;
  cp_gen_fsm:        coverpoint cov_gen_fsm        {bins value_0={0};
                                                    //bins value_1={1}; 
}
  cp_err_pending:    coverpoint cov_err_pending    { bins value_1 = {1}; }
  cp_gen_running:    coverpoint cov_gen_running    { bins value_0={0};
                                                     //bins value_1={1}; 
}
  cp_port_enabled:   coverpoint cov_port_enabled   { bins value_1 = {1}; }
  cp_locked:         coverpoint cov_locked         { bins value_0={0};
                                                     //bins value_1={1}; 
}
  cp_switch_enabled: coverpoint cov_switch_enabled { bins value_1 = {1}; }
  cp_busy:           coverpoint cov_busy           { //bins value_1 = {1}; 
}
  cp_ready:          coverpoint cov_ready          { bins value_0={0};
                                                     //bins value_1={1}; 
}
 endgroup 

  function new(string name = "switch_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    switch_status_reg_cg = new();
  endfunction

  virtual function void build();
    reserved_31_18 = uvm_reg_field::type_id::create("reserved_31_18");
    reserved_31_18.configure(this, 14, 18, "RO", 0, 32'h00000000, 1, 0, 1);

    gen_fsm = uvm_reg_field::type_id::create("gen_fsm");
    gen_fsm.configure(this, 2, 16, "RO", 1, 32'h00000000, 1, 0, 1);

    reserved_15_10 = uvm_reg_field::type_id::create("reserved_15_10");
    reserved_15_10.configure(this, 6, 10, "RO", 0, 32'h00000000, 1, 0, 1);

    err_pending = uvm_reg_field::type_id::create("err_pending");
    err_pending.configure(this, 1, 9, "RO", 1, 32'h00000000, 1, 0, 1);

    gen_running = uvm_reg_field::type_id::create("gen_running");
    gen_running.configure(this, 1, 8, "RO", 1, 32'h00000000, 1, 0, 1);

    port_enabled = uvm_reg_field::type_id::create("port_enabled");
    port_enabled.configure(this, 4, 4, "RO", 1, 32'h0000000F, 1, 0, 1);

    locked = uvm_reg_field::type_id::create("locked");
    locked.configure(this, 1, 3, "RO", 1, 32'h00000001, 1, 0, 1);

    switch_enabled = uvm_reg_field::type_id::create("switch_enabled");
    switch_enabled.configure(this, 1, 2, "RO", 1, 32'h00000000, 1, 0, 1);

    busy = uvm_reg_field::type_id::create("busy");
    busy.configure(this, 1, 1, "RO", 1, 32'h00000000, 1, 0, 1);

    ready = uvm_reg_field::type_id::create("ready");
    ready.configure(this, 1, 0, "RO", 1, 32'h00000001, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_gen_fsm = gen_fsm.get_mirrored_value();
      cov_err_pending = err_pending.get_mirrored_value();
      cov_gen_running = gen_running.get_mirrored_value();
      cov_port_enabled = port_enabled.get_mirrored_value();
      cov_locked = locked.get_mirrored_value();
      cov_switch_enabled = switch_enabled.get_mirrored_value();
      cov_busy = busy.get_mirrored_value();
      cov_ready = ready.get_mirrored_value();
      switch_status_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h08 (switch_status_reg)

class port_status_reg extends uvm_reg;
  `uvm_object_utils(port_status_reg)

  rand uvm_reg_field port3_level;
  rand uvm_reg_field port2_level;
  rand uvm_reg_field port1_level;
  rand uvm_reg_field port0_level;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_port3_level;
  uvm_reg_data_t cov_port2_level;
  uvm_reg_data_t cov_port1_level;
  uvm_reg_data_t cov_port0_level;

  covergroup port_status_reg_cg;
    cp_port3_level: coverpoint cov_port3_level {
      bins value_0={0};
      bins value_1={1};
    }
    cp_port2_level: coverpoint cov_port2_level {
      bins value_0={0};
      bins value_1={1};
    }
    cp_port1_level: coverpoint cov_port1_level {
      bins value_0={0};
      bins value_1={1};
    }
    cp_port0_level: coverpoint cov_port0_level {
      bins value_0={0};
      bins value_1={1};
    }
  endgroup


  function new(string name = "port_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    port_status_reg_cg = new();
  endfunction

  virtual function void build();
    port3_level = uvm_reg_field::type_id::create("port3_level");
    port3_level.configure(this, 8, 24, "RO", 1, 32'h00000000, 1, 0, 1);

    port2_level = uvm_reg_field::type_id::create("port2_level");
    port2_level.configure(this, 8, 16, "RO", 1, 32'h00000000, 1, 0, 1);

    port1_level = uvm_reg_field::type_id::create("port1_level");
    port1_level.configure(this, 8, 8, "RO", 1, 32'h00000000, 1, 0, 1);

    port0_level = uvm_reg_field::type_id::create("port0_level");
    port0_level.configure(this, 8, 0, "RO", 1, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_port3_level = port3_level.get_mirrored_value();
      cov_port2_level = port2_level.get_mirrored_value();
      cov_port1_level = port1_level.get_mirrored_value();
      cov_port0_level = port0_level.get_mirrored_value();
      port_status_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h0C (port_status_reg)

class gen_status_reg extends uvm_reg;
  `uvm_object_utils(gen_status_reg)

  rand uvm_reg_field reserved_31_24;
  rand uvm_reg_field remaining;
  rand uvm_reg_field reserved_7_4;
  rand uvm_reg_field fsm;
  rand uvm_reg_field done;
  rand uvm_reg_field running;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_remaining;
  uvm_reg_data_t cov_fsm;
  uvm_reg_data_t cov_done;
  uvm_reg_data_t cov_running;

  // GEN_STATUS
covergroup gen_status_reg_cg;
  cp_remaining: coverpoint cov_remaining { bins value_0 = {0}; }
  cp_fsm:       coverpoint cov_fsm       { bins value_0 = {0}; }
  cp_done:      coverpoint cov_done      { bins value_0 = {0}; }
  cp_running:   coverpoint cov_running   { bins value_0 = {0}; }
endgroup  

  function new(string name = "gen_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    gen_status_reg_cg = new();
  endfunction

  virtual function void build();
    reserved_31_24 = uvm_reg_field::type_id::create("reserved_31_24");
    reserved_31_24.configure(this, 8, 24, "RO", 0, 32'h00000000, 1, 0, 1);

    remaining = uvm_reg_field::type_id::create("remaining");
    remaining.configure(this, 16, 8, "RO", 1, 32'h00000000, 1, 0, 1);

    reserved_7_4 = uvm_reg_field::type_id::create("reserved_7_4");
    reserved_7_4.configure(this, 4, 4, "RO", 0, 32'h00000000, 1, 0, 1);

    fsm = uvm_reg_field::type_id::create("fsm");
    fsm.configure(this, 2, 2, "RO", 1, 32'h00000000, 1, 0, 1);

    done = uvm_reg_field::type_id::create("done");
    done.configure(this, 1, 1, "RO", 1, 32'h00000000, 1, 0, 1);

    running = uvm_reg_field::type_id::create("running");
    running.configure(this, 1, 0, "RO", 1, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_remaining = remaining.get_mirrored_value();
      cov_fsm = fsm.get_mirrored_value();
      cov_done = done.get_mirrored_value();
      cov_running = running.get_mirrored_value();
      gen_status_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h10 (gen_status_reg)

class stat_rx_reg extends uvm_reg;
  `uvm_object_utils(stat_rx_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field rx_packets;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_rx_packets;

    covergroup stat_rx_reg_cg;
    cp_rx_packets: coverpoint cov_rx_packets {
      bins value_0={0};
      //bins value_1={1};
    }
  endgroup


  function new(string name = "stat_rx_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    stat_rx_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 32'h00000000, 1, 0, 1);

    rx_packets = uvm_reg_field::type_id::create("rx_packets");
    rx_packets.configure(this, 16, 0, "RO", 1, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_rx_packets = rx_packets.get_mirrored_value();
      stat_rx_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h14 (stat_rx_reg)

class stat_tx_reg extends uvm_reg;
  `uvm_object_utils(stat_tx_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field tx_packets;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_tx_packets;

 // STAT_TX
covergroup stat_tx_reg_cg;
  cp_tx_packets: coverpoint cov_tx_packets { bins value_1 = {[16'h0:16'hFFFF]}; }
endgroup

  function new(string name = "stat_tx_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    stat_tx_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 32'h00000000, 1, 0, 1);

    tx_packets = uvm_reg_field::type_id::create("tx_packets");
    tx_packets.configure(this, 16, 0, "RO", 1, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_tx_packets = tx_packets.get_mirrored_value();
      stat_tx_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h18 (stat_tx_reg)

class stat_drop_reg extends uvm_reg;
  `uvm_object_utils(stat_drop_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field dropped_packets;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_dropped_packets;

 // STAT_DROP
covergroup stat_drop_reg_cg;
  cp_dropped_packets: coverpoint cov_dropped_packets { bins value_0={0};
                                               bins value_1={1}; }
endgroup

  function new(string name = "stat_drop_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    stat_drop_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 32'h00000000, 1, 0, 1);

    dropped_packets = uvm_reg_field::type_id::create("dropped_packets");
    dropped_packets.configure(this, 16, 0, "RO", 1, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_dropped_packets = dropped_packets.get_mirrored_value();
      stat_drop_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h1C (stat_drop_reg)

class switch_ctrl_reg extends uvm_reg;
  `uvm_object_utils(switch_ctrl_reg)

  rand uvm_reg_field reserved_31_4;
  rand uvm_reg_field irq_global_en;
  rand uvm_reg_field reserved_2;
  rand uvm_reg_field stat_clear;
  rand uvm_reg_field enable;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_irq_global_en;
  uvm_reg_data_t cov_stat_clear;
  uvm_reg_data_t cov_enable;

  // SWITCH_CTRL
covergroup switch_ctrl_reg_cg;
  cp_irq_global_en: coverpoint cov_irq_global_en { bins value_1 = {1}; }
  cp_stat_clear:    coverpoint cov_stat_clear    { bins value_1 = {1}; }
  cp_enable:        coverpoint cov_enable        { bins value_1 = {1}; }
endgroup

  function new(string name = "switch_ctrl_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    switch_ctrl_reg_cg = new();
  endfunction

  virtual function void build();
    reserved_31_4 = uvm_reg_field::type_id::create("reserved_31_4");
    reserved_31_4.configure(this, 28, 4, "RO", 0, 32'h00000000, 1, 0, 1);

    irq_global_en = uvm_reg_field::type_id::create("irq_global_en");
    irq_global_en.configure(this, 1, 3, "RW", 0, 32'h00000000, 1, 0, 1);

    reserved_2 = uvm_reg_field::type_id::create("reserved_2");
    reserved_2.configure(this, 1, 2, "RO", 0, 32'h00000000, 1, 0, 1);

    stat_clear = uvm_reg_field::type_id::create("stat_clear");
    stat_clear.configure(this, 1, 1, "WO", 0, 32'h00000000, 1, 0, 1);

    enable = uvm_reg_field::type_id::create("enable");
    enable.configure(this, 1, 0, "RW", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_irq_global_en = irq_global_en.get_mirrored_value();
      cov_stat_clear = stat_clear.get_mirrored_value();
      cov_enable = enable.get_mirrored_value();
      switch_ctrl_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h20 (switch_ctrl_reg)

class port_enable_reg extends uvm_reg;
  `uvm_object_utils(port_enable_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field port3_en;
  rand uvm_reg_field port2_en;
  rand uvm_reg_field port1_en;
  rand uvm_reg_field port0_en;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_port3_en;
  uvm_reg_data_t cov_port2_en;
  uvm_reg_data_t cov_port1_en;
  uvm_reg_data_t cov_port0_en;

// PORT_ENABLE
covergroup port_enable_reg_cg;
  cp_port3_en: coverpoint cov_port3_en { bins value_1 = {1}; }
  cp_port2_en: coverpoint cov_port2_en { bins value_1 = {1}; }
  cp_port1_en: coverpoint cov_port1_en { bins value_1 = {1}; }
  cp_port0_en: coverpoint cov_port0_en { bins value_1 = {1}; }
endgroup

  function new(string name = "port_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    port_enable_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 28, 4, "RO", 0, 32'h00000000, 1, 0, 1);

    port3_en = uvm_reg_field::type_id::create("port3_en");
    port3_en.configure(this, 1, 3, "RW", 0, 32'h00000001, 1, 0, 1);

    port2_en = uvm_reg_field::type_id::create("port2_en");
    port2_en.configure(this, 1, 2, "RW", 0, 32'h00000001, 1, 0, 1);

    port1_en = uvm_reg_field::type_id::create("port1_en");
    port1_en.configure(this, 1, 1, "RW", 0, 32'h00000001, 1, 0, 1);

    port0_en = uvm_reg_field::type_id::create("port0_en");
    port0_en.configure(this, 1, 0, "RW", 0, 32'h00000001, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_port3_en = port3_en.get_mirrored_value();
      cov_port2_en = port2_en.get_mirrored_value();
      cov_port1_en = port1_en.get_mirrored_value();
      cov_port0_en = port0_en.get_mirrored_value();
      port_enable_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h24 (port_enable_reg)

class fwd_enable_reg extends uvm_reg;
  `uvm_object_utils(fwd_enable_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field fwd3_en;
  rand uvm_reg_field fwd2_en;
  rand uvm_reg_field fwd1_en;
  rand uvm_reg_field fwd0_en;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_fwd3_en;
  uvm_reg_data_t cov_fwd2_en;
  uvm_reg_data_t cov_fwd1_en;
  uvm_reg_data_t cov_fwd0_en;

 // FWD_ENABLE
covergroup fwd_enable_reg_cg;
  cp_fwd3_en: coverpoint cov_fwd3_en { bins value_1 = {1}; }
  cp_fwd2_en: coverpoint cov_fwd2_en { bins value_1 = {1}; }
  cp_fwd1_en: coverpoint cov_fwd1_en { bins value_1 = {1}; }
  cp_fwd0_en: coverpoint cov_fwd0_en { bins value_1 = {1}; }
endgroup

  function new(string name = "fwd_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    fwd_enable_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 28, 4, "RO", 0, 32'h00000000, 1, 0, 1);

    fwd3_en = uvm_reg_field::type_id::create("fwd3_en");
    fwd3_en.configure(this, 1, 3, "RW", 0, 32'h00000001, 1, 0, 1);

    fwd2_en = uvm_reg_field::type_id::create("fwd2_en");
    fwd2_en.configure(this, 1, 2, "RW", 0, 32'h00000001, 1, 0, 1);

    fwd1_en = uvm_reg_field::type_id::create("fwd1_en");
    fwd1_en.configure(this, 1, 1, "RW", 0, 32'h00000001, 1, 0, 1);

    fwd0_en = uvm_reg_field::type_id::create("fwd0_en");
    fwd0_en.configure(this, 1, 0, "RW", 0, 32'h00000001, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_fwd3_en = fwd3_en.get_mirrored_value();
      cov_fwd2_en = fwd2_en.get_mirrored_value();
      cov_fwd1_en = fwd1_en.get_mirrored_value();
      cov_fwd0_en = fwd0_en.get_mirrored_value();
      fwd_enable_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h28 (fwd_enable_reg)

class gen_ctrl_reg extends uvm_reg;
  `uvm_object_utils(gen_ctrl_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field continuous;
  rand uvm_reg_field stop;
  rand uvm_reg_field start;
  rand uvm_reg_field enable;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_continuous;
  uvm_reg_data_t cov_stop;
  uvm_reg_data_t cov_start;
  uvm_reg_data_t cov_enable;

 // GEN_CTRL
covergroup gen_ctrl_reg_cg;
  cp_continuous: coverpoint cov_continuous { bins value_1 = {1}; }
  //cp_stop:       coverpoint cov_stop       { bins value_1 = {1}; }
  //cp_start:      coverpoint cov_start      { bins value_1 = {1}; }
  cp_enable:     coverpoint cov_enable     { bins value_1 = {1}; }
endgroup


  function new(string name = "gen_ctrl_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    gen_ctrl_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 28, 4, "RO", 0, 32'h00000000, 1, 0, 1);

    continuous = uvm_reg_field::type_id::create("continuous");
    continuous.configure(this, 1, 3, "RW", 0, 32'h00000000, 1, 0, 1);

    stop = uvm_reg_field::type_id::create("stop");
    stop.configure(this, 1, 2, "WO", 0, 32'h00000000, 1, 0, 1);

    start = uvm_reg_field::type_id::create("start");
    start.configure(this, 1, 1, "WO", 0, 32'h00000000, 1, 0, 1);

    enable = uvm_reg_field::type_id::create("enable");
    enable.configure(this, 1, 0, "RW", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_continuous = continuous.get_mirrored_value();
      cov_stop = stop.get_mirrored_value();
      cov_start = start.get_mirrored_value();
      cov_enable = enable.get_mirrored_value();
      gen_ctrl_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h2C (gen_ctrl_reg)

class gen_pkt_cfg_reg extends uvm_reg;
  `uvm_object_utils(gen_pkt_cfg_reg)

  rand uvm_reg_field reserved_31_24;
  rand uvm_reg_field seed;
  rand uvm_reg_field length;
  rand uvm_reg_field reserved_7_4;
  rand uvm_reg_field src_port;
  rand uvm_reg_field dst_port;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_seed;
  uvm_reg_data_t cov_length;
  uvm_reg_data_t cov_src_port;
  uvm_reg_data_t cov_dst_port;

// GEN_PKT_CFG
covergroup gen_pkt_cfg_reg_cg;
  cp_seed:     coverpoint cov_seed     { bins value_1 = {1}; }
  cp_length:   coverpoint cov_length   { bins value_1 = {1}; }
  cp_src_port: coverpoint cov_src_port { bins value_1 = {1}; }
  cp_dst_port: coverpoint cov_dst_port { bins value_1 = {1}; }
endgroup
 
  function new(string name = "gen_pkt_cfg_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    gen_pkt_cfg_reg_cg = new();
  endfunction

  virtual function void build();
    reserved_31_24 = uvm_reg_field::type_id::create("reserved_31_24");
    reserved_31_24.configure(this, 8, 24, "RO", 0, 32'h00000000, 1, 0, 1);

    seed = uvm_reg_field::type_id::create("seed");
    seed.configure(this, 8, 16, "RW", 0, 32'h00000000, 1, 0, 1);

    length = uvm_reg_field::type_id::create("length");
    length.configure(this, 8, 8, "RW", 0, 32'h00000004, 1, 0, 1);

    reserved_7_4 = uvm_reg_field::type_id::create("reserved_7_4");
    reserved_7_4.configure(this, 4, 4, "RO", 0, 32'h00000000, 1, 0, 1);

    src_port = uvm_reg_field::type_id::create("src_port");
    src_port.configure(this, 2, 2, "RW", 0, 32'h00000000, 1, 0, 1);

    dst_port = uvm_reg_field::type_id::create("dst_port");
    dst_port.configure(this, 2, 0, "RW", 0, 32'h00000001, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_seed = seed.get_mirrored_value();
      cov_length = length.get_mirrored_value();
      cov_src_port = src_port.get_mirrored_value();
      cov_dst_port = dst_port.get_mirrored_value();
      gen_pkt_cfg_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h30 (GEN_PKT_CFG)

class gen_interval_reg extends uvm_reg;
  `uvm_object_utils(gen_interval_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field interval;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_interval;

// GEN_INTERVAL
covergroup gen_interval_reg_cg;
  cp_interval: coverpoint cov_interval { bins value_1 = {1}; }
endgroup

 
  function new(string name = "gen_interval_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    gen_interval_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 32'h00000000, 1, 0, 1);

    interval = uvm_reg_field::type_id::create("interval");
    interval.configure(this, 16, 0, "RW", 0, 32'h00000002, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_interval = interval.get_mirrored_value();
      gen_interval_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h34 (GEN_INTERVAL)

class gen_count_reg extends uvm_reg;
  `uvm_object_utils(gen_count_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field packet_count;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_packet_count;

  // GEN_COUNT
covergroup gen_count_reg_cg;
  cp_packet_count: coverpoint cov_packet_count { bins value_1 = {1}; }
endgroup

  function new(string name = "gen_count_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    gen_count_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 32'h00000000, 1, 0, 1);

    packet_count = uvm_reg_field::type_id::create("packet_count");
    packet_count.configure(this, 16, 0, "RW", 0, 32'h00000004, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_packet_count = packet_count.get_mirrored_value();
      gen_count_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h38 (GEN_COUNT)

class irq_status_reg extends uvm_reg;
  `uvm_object_utils(irq_status_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field sw_event;
  rand uvm_reg_field start_ack;
  rand uvm_reg_field queue_almost_full;
  rand uvm_reg_field packet_forwarded;
  rand uvm_reg_field packet_dropped;
  rand uvm_reg_field queue_overflow;
  rand uvm_reg_field error;
  rand uvm_reg_field gen_done;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_sw_event;
  uvm_reg_data_t cov_start_ack;
  uvm_reg_data_t cov_queue_almost_full;
  uvm_reg_data_t cov_packet_forwarded;
  uvm_reg_data_t cov_packet_dropped;
  uvm_reg_data_t cov_queue_overflow;
  uvm_reg_data_t cov_error;
  uvm_reg_data_t cov_gen_done;

// IRQ_STATUS
covergroup irq_status_reg_cg;
  cp_sw_event:          coverpoint cov_sw_event          {bins value_0={0};
                                                          bins value_1={1}; }
  cp_start_ack:         coverpoint cov_start_ack         {bins value_0={0};
                                                          bins value_1={1};}
  cp_queue_almost_full: coverpoint cov_queue_almost_full { bins value_0={0};
                                                          bins value_1={1}; }
  cp_packet_forwarded:  coverpoint cov_packet_forwarded  { bins value_1 = {1}; }
  cp_packet_dropped:    coverpoint cov_packet_dropped    { bins value_0={0};
                                                          bins value_1={1}; }
  cp_queue_overflow:    coverpoint cov_queue_overflow    { bins value_1 = {1}; }
  cp_error:             coverpoint cov_error             { bins value_1 = {1}; }
  cp_gen_done:          coverpoint cov_gen_done          { bins value_0={0};
                                                          bins value_1={1}; }
endgroup 


  function new(string name = "irq_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    irq_status_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "RO", 0, 32'h00000000, 1, 0, 1);

    sw_event = uvm_reg_field::type_id::create("sw_event");
    sw_event.configure(this, 1, 7, "W1C", 0, 32'h00000000, 1, 0, 1);

    start_ack = uvm_reg_field::type_id::create("start_ack");
    start_ack.configure(this, 1, 6, "W1C", 0, 32'h00000000, 1, 0, 1);

    queue_almost_full = uvm_reg_field::type_id::create("queue_almost_full");
    queue_almost_full.configure(this, 1, 5, "W1C", 0, 32'h00000000, 1, 0, 1);

    packet_forwarded = uvm_reg_field::type_id::create("packet_forwarded");
    packet_forwarded.configure(this, 1, 4, "W1C", 0, 32'h00000000, 1, 0, 1);

    packet_dropped = uvm_reg_field::type_id::create("packet_dropped");
    packet_dropped.configure(this, 1, 3, "W1C", 0, 32'h00000000, 1, 0, 1);

    queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
    queue_overflow.configure(this, 1, 2, "W1C", 0, 32'h00000000, 1, 0, 1);

    error = uvm_reg_field::type_id::create("error");
    error.configure(this, 1, 1, "W1C", 0, 32'h00000000, 1, 0, 1);

    gen_done = uvm_reg_field::type_id::create("gen_done");
    gen_done.configure(this, 1, 0, "W1C", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_sw_event = sw_event.get_mirrored_value();
      cov_start_ack = start_ack.get_mirrored_value();
      cov_queue_almost_full = queue_almost_full.get_mirrored_value();
      cov_packet_forwarded = packet_forwarded.get_mirrored_value();
      cov_packet_dropped = packet_dropped.get_mirrored_value();
      cov_queue_overflow = queue_overflow.get_mirrored_value();
      cov_error = error.get_mirrored_value();
      cov_gen_done = gen_done.get_mirrored_value();
      irq_status_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h3C (IRQ_STATUS)

class irq_enable_reg extends uvm_reg;
  `uvm_object_utils(irq_enable_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field sw_event_en;
  rand uvm_reg_field start_ack_en;
  rand uvm_reg_field queue_af_en;
  rand uvm_reg_field packet_fwd_en;
  rand uvm_reg_field packet_drop_en;
  rand uvm_reg_field overflow_en;
  rand uvm_reg_field error_en;
  rand uvm_reg_field gen_done_en;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_sw_event_en;
  uvm_reg_data_t cov_start_ack_en;
  uvm_reg_data_t cov_queue_af_en;
  uvm_reg_data_t cov_packet_fwd_en;
  uvm_reg_data_t cov_packet_drop_en;
  uvm_reg_data_t cov_overflow_en;
  uvm_reg_data_t cov_error_en;
  uvm_reg_data_t cov_gen_done_en;



// IRQ_ENABLE
covergroup irq_enable_reg_cg;
  cp_sw_event_en:     coverpoint cov_sw_event_en     { bins value_0={0};
                                                       bins value_1={1}; }
  cp_start_ack_en:    coverpoint cov_start_ack_en    { bins value_1 = {1}; }
  cp_queue_af_en:     coverpoint cov_queue_af_en     { bins value_1 = {1}; }
  cp_packet_fwd_en:   coverpoint cov_packet_fwd_en   { bins value_0={0};
                                                       bins value_1={1}; }
  cp_packet_drop_en:  coverpoint cov_packet_drop_en  { bins value_1 = {1}; }
  cp_overflow_en:     coverpoint cov_overflow_en     { bins value_0={0};
                                                       bins value_1={1}; }
  cp_error_en:        coverpoint cov_error_en        { bins value_1 = {1}; }
  cp_gen_done_en:     coverpoint cov_gen_done_en     { bins value_0={0};
                                                       bins value_1={1}; }
endgroup


  function new(string name = "irq_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    irq_enable_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "RO", 0, 32'h00000000, 1, 0, 1);

    sw_event_en = uvm_reg_field::type_id::create("sw_event_en");
    sw_event_en.configure(this, 1, 7, "RW", 0, 32'h00000000, 1, 0, 1);

    start_ack_en = uvm_reg_field::type_id::create("start_ack_en");
    start_ack_en.configure(this, 1, 6, "RW", 0, 32'h00000000, 1, 0, 1);

    queue_af_en = uvm_reg_field::type_id::create("queue_af_en");
    queue_af_en.configure(this, 1, 5, "RW", 0, 32'h00000000, 1, 0, 1);

    packet_fwd_en = uvm_reg_field::type_id::create("packet_fwd_en");
    packet_fwd_en.configure(this, 1, 4, "RW", 0, 32'h00000000, 1, 0, 1);

    packet_drop_en = uvm_reg_field::type_id::create("packet_drop_en");
    packet_drop_en.configure(this, 1, 3, "RW", 0, 32'h00000000, 1, 0, 1);

    overflow_en = uvm_reg_field::type_id::create("overflow_en");
    overflow_en.configure(this, 1, 2, "RW", 0, 32'h00000000, 1, 0, 1);

    error_en = uvm_reg_field::type_id::create("error_en");
    error_en.configure(this, 1, 1, "RW", 0, 32'h00000000, 1, 0, 1);

    gen_done_en = uvm_reg_field::type_id::create("gen_done_en");
    gen_done_en.configure(this, 1, 0, "RW", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_sw_event_en = sw_event_en.get_mirrored_value();
      cov_start_ack_en = start_ack_en.get_mirrored_value();
      cov_queue_af_en = queue_af_en.get_mirrored_value();
      cov_packet_fwd_en = packet_fwd_en.get_mirrored_value();
      cov_packet_drop_en = packet_drop_en.get_mirrored_value();
      cov_overflow_en = overflow_en.get_mirrored_value();
      cov_error_en = error_en.get_mirrored_value();
      cov_gen_done_en = gen_done_en.get_mirrored_value();
      irq_enable_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h40 (IRQ_ENABLE)

class irq_force_reg extends uvm_reg;
  `uvm_object_utils(irq_force_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field force_field;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_force_field;

 // IRQ_FORCE
covergroup irq_force_reg_cg;
  cp_force_field: coverpoint cov_force_field { bins value_1 = {1}; }
endgroup

  function new(string name = "irq_force_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    irq_force_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "RO", 0, 32'h00000000, 1, 0, 1);

    force_field = uvm_reg_field::type_id::create("force_field");
    force_field.configure(this, 8, 0, "WO", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_force_field = force_field.get_mirrored_value();
      irq_force_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h44 (IRQ_FORCE)

class err_status_reg extends uvm_reg;
  `uvm_object_utils(err_status_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field injected;
  rand uvm_reg_field length_error;
  rand uvm_reg_field crc_error;
  rand uvm_reg_field protocol_error;
  rand uvm_reg_field undersize;
  rand uvm_reg_field queue_overflow;
  rand uvm_reg_field dest_error;
  rand uvm_reg_field bus_error;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_injected;
  uvm_reg_data_t cov_length_error;
  uvm_reg_data_t cov_crc_error;
  uvm_reg_data_t cov_protocol_error;
  uvm_reg_data_t cov_undersize;
  uvm_reg_data_t cov_queue_overflow;
  uvm_reg_data_t cov_dest_error;
  uvm_reg_data_t cov_bus_error;

 // ERR_STATUS
covergroup err_status_reg_cg;
  cp_injected:       coverpoint cov_injected       {bins value_0={0};
                                                    bins value_1={1}; }
  cp_length_error:   coverpoint cov_length_error   {bins value_0={0};
                                                    bins value_1={1};}
  cp_crc_error:      coverpoint cov_crc_error      {bins value_0={0};
                                                    bins value_1={1};}
  cp_protocol_error: coverpoint cov_protocol_error {bins value_0={0};
                                                    bins value_1={1}; }
  cp_undersize:      coverpoint cov_undersize      {bins value_0={0};
                                                    bins value_1={1}; }
  cp_queue_overflow: coverpoint cov_queue_overflow {bins value_0={0};
                                                    bins value_1={1};}
  cp_dest_error:     coverpoint cov_dest_error     {bins value_0={0};
                                                    bins value_1={1};}
  cp_bus_error:      coverpoint cov_bus_error      {bins value_0={0};
                                                    bins value_1={1}; }
endgroup


  function new(string name = "err_status_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    err_status_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "RO", 0, 32'h00000000, 1, 0, 1);

    injected = uvm_reg_field::type_id::create("injected");
    injected.configure(this, 1, 7, "W1C", 0, 32'h00000000, 1, 0, 1);

    length_error = uvm_reg_field::type_id::create("length_error");
    length_error.configure(this, 1, 6, "W1C", 0, 32'h00000000, 1, 0, 1);

    crc_error = uvm_reg_field::type_id::create("crc_error");
    crc_error.configure(this, 1, 5, "W1C", 0, 32'h00000000, 1, 0, 1);

    protocol_error = uvm_reg_field::type_id::create("protocol_error");
    protocol_error.configure(this, 1, 4, "W1C", 0, 32'h00000000, 1, 0, 1);

    undersize = uvm_reg_field::type_id::create("undersize");
    undersize.configure(this, 1, 3, "W1C", 0, 32'h00000000, 1, 0, 1);

    queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
    queue_overflow.configure(this, 1, 2, "W1C", 0, 32'h00000000, 1, 0, 1);

    dest_error = uvm_reg_field::type_id::create("dest_error");
    dest_error.configure(this, 1, 1, "W1C", 0, 32'h00000000, 1, 0, 1);

    bus_error = uvm_reg_field::type_id::create("bus_error");
    bus_error.configure(this, 1, 0, "W1C", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_injected = injected.get_mirrored_value();
      cov_length_error = length_error.get_mirrored_value();
      cov_crc_error = crc_error.get_mirrored_value();
      cov_protocol_error = protocol_error.get_mirrored_value();
      cov_undersize = undersize.get_mirrored_value();
      cov_queue_overflow = queue_overflow.get_mirrored_value();
      cov_dest_error = dest_error.get_mirrored_value();
      cov_bus_error = bus_error.get_mirrored_value();
      err_status_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h48 (ERR_STATUS)

class err_enable_reg extends uvm_reg;
  `uvm_object_utils(err_enable_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field injected_en;
  rand uvm_reg_field length_en;
  rand uvm_reg_field crc_en;
  rand uvm_reg_field protocol_en;
  rand uvm_reg_field undersize_en;
  rand uvm_reg_field overflow_en;
  rand uvm_reg_field dest_en;
  rand uvm_reg_field bus_en;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_injected_en;
  uvm_reg_data_t cov_length_en;
  uvm_reg_data_t cov_crc_en;
  uvm_reg_data_t cov_protocol_en;
  uvm_reg_data_t cov_undersize_en;
  uvm_reg_data_t cov_overflow_en;
  uvm_reg_data_t cov_dest_en;
  uvm_reg_data_t cov_bus_en;

 
// ERR_ENABLE
covergroup err_enable_reg_cg;
  cp_injected_en:  coverpoint cov_injected_en  {bins value_0={0};
                                                bins value_1={1}; }
  cp_length_en:    coverpoint cov_length_en    { bins value_1 = {1}; }
  cp_crc_en:       coverpoint cov_crc_en       {bins value_0={0};
                                                bins value_1={1};}
  cp_protocol_en:  coverpoint cov_protocol_en  { bins value_1 = {1}; }
  cp_undersize_en: coverpoint cov_undersize_en { bins value_1 = {1}; }
  cp_overflow_en:  coverpoint cov_overflow_en  {bins value_0={0};
                                                bins value_1={1};}
  cp_dest_en:      coverpoint cov_dest_en      { bins value_1 = {1}; }
  cp_bus_en:       coverpoint cov_bus_en       {bins value_0={0};
                                                bins value_1={1}; }
endgroup


  function new(string name = "err_enable_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    err_enable_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 24, 8, "RO", 0, 32'h00000000, 1, 0, 1);

    injected_en = uvm_reg_field::type_id::create("injected_en");
    injected_en.configure(this, 1, 7, "RW", 0, 32'h00000000, 1, 0, 1);

    length_en = uvm_reg_field::type_id::create("length_en");
    length_en.configure(this, 1, 6, "RW", 0, 32'h00000000, 1, 0, 1);

    crc_en = uvm_reg_field::type_id::create("crc_en");
    crc_en.configure(this, 1, 5, "RW", 0, 32'h00000000, 1, 0, 1);

    protocol_en = uvm_reg_field::type_id::create("protocol_en");
    protocol_en.configure(this, 1, 4, "RW", 0, 32'h00000000, 1, 0, 1);

    undersize_en = uvm_reg_field::type_id::create("undersize_en");
    undersize_en.configure(this, 1, 3, "RW", 0, 32'h00000000, 1, 0, 1);

    overflow_en = uvm_reg_field::type_id::create("overflow_en");
    overflow_en.configure(this, 1, 2, "RW", 0, 32'h00000000, 1, 0, 1);

    dest_en = uvm_reg_field::type_id::create("dest_en");
    dest_en.configure(this, 1, 1, "RW", 0, 32'h00000000, 1, 0, 1);

    bus_en = uvm_reg_field::type_id::create("bus_en");
    bus_en.configure(this, 1, 0, "RW", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_injected_en = injected_en.get_mirrored_value();
      cov_length_en = length_en.get_mirrored_value();
      cov_crc_en = crc_en.get_mirrored_value();
      cov_protocol_en = protocol_en.get_mirrored_value();
      cov_undersize_en = undersize_en.get_mirrored_value();
      cov_overflow_en = overflow_en.get_mirrored_value();
      cov_dest_en = dest_en.get_mirrored_value();
      cov_bus_en = bus_en.get_mirrored_value();
      err_enable_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h4C (ERR_ENABLE)

class err_inject_reg extends uvm_reg;
  `uvm_object_utils(err_inject_reg)

  rand uvm_reg_field clear_count;
  rand uvm_reg_field reserved;
  rand uvm_reg_field injected;
  rand uvm_reg_field length;
  rand uvm_reg_field crc;
  rand uvm_reg_field protocol;
  rand uvm_reg_field undersize;
  rand uvm_reg_field overflow;
  rand uvm_reg_field dest;
  rand uvm_reg_field bus;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_clear_count;
  uvm_reg_data_t cov_injected;
  uvm_reg_data_t cov_length;
  uvm_reg_data_t cov_crc;
  uvm_reg_data_t cov_protocol;
  uvm_reg_data_t cov_undersize;
  uvm_reg_data_t cov_overflow;
  uvm_reg_data_t cov_dest;
  uvm_reg_data_t cov_bus;

// ERR_INJECT
covergroup err_inject_reg_cg;
  cp_clear_count: coverpoint cov_clear_count { bins value_0={0};
                                               bins value_1={1}; }
  cp_injected:    coverpoint cov_injected    { bins value_0={0};
                                               bins value_1={1}; }
  cp_length:      coverpoint cov_length      { bins value_0={0};
                                               bins value_1={1}; }
  cp_crc:         coverpoint cov_crc         { bins value_0={0};
                                               bins value_1={1}; }
  cp_protocol:    coverpoint cov_protocol    { bins value_0={0};
                                               bins value_1={1};}
  cp_undersize:   coverpoint cov_undersize   { bins value_0={0};
                                               bins value_1={1}; }
  cp_overflow:    coverpoint cov_overflow    { bins value_0={0};
                                               bins value_1={1};}
  cp_dest:        coverpoint cov_dest        {bins value_0={0};
                                               bins value_1={1}; }
  cp_bus:         coverpoint cov_bus         { bins value_0={0};
                                               bins value_1={1}; }
endgroup 

  function new(string name = "err_inject_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    err_inject_reg_cg = new();
  endfunction

  virtual function void build();
    clear_count = uvm_reg_field::type_id::create("clear_count");
    clear_count.configure(this, 1, 31, "WO", 0, 32'h00000000, 1, 0, 1);

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 23, 8, "RO", 0, 32'h00000000, 1, 0, 1);

    injected = uvm_reg_field::type_id::create("injected");
    injected.configure(this, 1, 7, "WO", 0, 32'h00000000, 1, 0, 1);

    length = uvm_reg_field::type_id::create("length");
    length.configure(this, 1, 6, "WO", 0, 32'h00000000, 1, 0, 1);

    crc = uvm_reg_field::type_id::create("crc");
    crc.configure(this, 1, 5, "WO", 0, 32'h00000000, 1, 0, 1);

    protocol = uvm_reg_field::type_id::create("protocol");
    protocol.configure(this, 1, 4, "WO", 0, 32'h00000000, 1, 0, 1);

    undersize = uvm_reg_field::type_id::create("undersize");
    undersize.configure(this, 1, 3, "WO", 0, 32'h00000000, 1, 0, 1);

    overflow = uvm_reg_field::type_id::create("overflow");
    overflow.configure(this, 1, 2, "WO", 0, 32'h00000000, 1, 0, 1);

    dest = uvm_reg_field::type_id::create("dest");
    dest.configure(this, 1, 1, "WO", 0, 32'h00000000, 1, 0, 1);

    bus = uvm_reg_field::type_id::create("bus");
    bus.configure(this, 1, 0, "WO", 0, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_clear_count = clear_count.get_mirrored_value();
      cov_injected = injected.get_mirrored_value();
      cov_length = length.get_mirrored_value();
      cov_crc = crc.get_mirrored_value();
      cov_protocol = protocol.get_mirrored_value();
      cov_undersize = undersize.get_mirrored_value();
      cov_overflow = overflow.get_mirrored_value();
      cov_dest = dest.get_mirrored_value();
      cov_bus = bus.get_mirrored_value();
      err_inject_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h50 (ERR_INJECT)

class err_count_reg extends uvm_reg;
  `uvm_object_utils(err_count_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field error_count;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_error_count;

 // ERR_COUNT
covergroup err_count_reg_cg;
  cp_error_count: coverpoint cov_error_count { bins value_0={0};
                                               bins value_1={1}; }
endgroup

  function new(string name = "err_count_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    err_count_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 16, 16, "RO", 0, 32'h00000000, 1, 0, 1);

    error_count = uvm_reg_field::type_id::create("error_count");
    error_count.configure(this, 16, 0, "RO", 1, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_error_count = error_count.get_mirrored_value();
      err_count_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h54 (ERR_COUNT)

class err_info_reg extends uvm_reg;
  `uvm_object_utils(err_info_reg)

  rand uvm_reg_field tx_snapshot;
  rand uvm_reg_field reserved;
  rand uvm_reg_field dest_port;
  rand uvm_reg_field source;
  rand uvm_reg_field last_code;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_tx_snapshot;
  uvm_reg_data_t cov_dest_port;
  uvm_reg_data_t cov_source;
  uvm_reg_data_t cov_last_code;

  // ERR_INFO
covergroup err_info_reg_cg;
  cp_tx_snapshot: coverpoint cov_tx_snapshot { bins value_0 = {0};
					       bins value_1={1}; }
  cp_dest_port:   coverpoint cov_dest_port   { bins value_0 = {[0:1]}; }
  cp_source:      coverpoint cov_source      { bins value_0 = {[0:1]}; }
  cp_last_code:   coverpoint cov_last_code   { bins value_0 = {[0:1]}; }
endgroup



  function new(string name = "err_info_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    err_info_reg_cg = new();
  endfunction

  virtual function void build();
    tx_snapshot = uvm_reg_field::type_id::create("tx_snapshot");
    tx_snapshot.configure(this, 12, 20, "RO", 1, 32'h00000000, 1, 0, 1);

    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 2, 18, "RO", 0, 32'h00000000, 1, 0, 1);

    dest_port = uvm_reg_field::type_id::create("dest_port");
    dest_port.configure(this, 2, 16, "RO", 1, 32'h00000000, 1, 0, 1);

    source = uvm_reg_field::type_id::create("source");
    source.configure(this, 8, 8, "RO", 1, 32'h00000000, 1, 0, 1);

    last_code = uvm_reg_field::type_id::create("last_code");
    last_code.configure(this, 8, 0, "RO", 1, 32'h00000000, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_tx_snapshot = tx_snapshot.get_mirrored_value();
      cov_dest_port = dest_port.get_mirrored_value();
      cov_source = source.get_mirrored_value();
      cov_last_code = last_code.get_mirrored_value();
      err_info_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h58 (ERR_INFO)

class lock_reg extends uvm_reg;
  `uvm_object_utils(lock_reg)

  rand uvm_reg_field key_reserved;
  rand uvm_reg_field locked;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_locked;

  covergroup lock_reg_cg;
    cp_locked: coverpoint cov_locked {
      bins zero = {0};
      bins one  = {1};
    }
  endgroup

  function new(string name = "lock_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    lock_reg_cg = new();
  endfunction

  virtual function void build();
    key_reserved = uvm_reg_field::type_id::create("key_reserved");
    key_reserved.configure(this, 31, 1, "WO", 0, 32'h00000000, 1, 0, 1);

    locked = uvm_reg_field::type_id::create("locked");
    locked.configure(this, 1, 0, "RO", 0, 32'h00000001, 1, 0, 1);

  endfunction

  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_locked = locked.get_mirrored_value();
      lock_reg_cg.sample();
    end
  endfunction

endclass

// Address offset: 32'h5C (LOCK)

class soft_reset_reg extends uvm_reg;
  `uvm_object_utils(soft_reset_reg)

  rand uvm_reg_field reserved;
  rand uvm_reg_field pulse;


  // Functional coverage variables (reserved fields excluded)
  uvm_reg_data_t cov_pulse;

  covergroup soft_reset_reg_cg;
    cp_pulse: coverpoint cov_pulse {
      bins zero = {0};
      bins one  = {1};
    }
  endgroup

  function new(string name = "soft_reset_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    soft_reset_reg_cg = new();
  endfunction

  virtual function void build();
    reserved = uvm_reg_field::type_id::create("reserved");
    reserved.configure(this, 31, 1, "RO", 0, 32'h00000000, 1, 0, 1);

    pulse = uvm_reg_field::type_id::create("pulse");
    pulse.configure(this, 1, 0, "WO", 0, 32'h00000000, 1, 0, 1);

  endfunction
  virtual function void sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      cov_pulse = pulse.get_mirrored_value();
      soft_reset_reg_cg.sample();
    end
  endfunction


endclass

// Address offset: 32'h60 (SOFT_RESET)

class reg_block extends uvm_reg_block;

  `uvm_object_utils(reg_block)

  // Register instances
  device_id_reg     device_id_inst;
  version_reg       version_inst;
  switch_status_reg switch_status_inst;
  port_status_reg   port_status_inst;
  gen_status_reg    gen_status_inst;
  stat_rx_reg       stat_rx_inst;
  stat_tx_reg       stat_tx_inst;
  stat_drop_reg     stat_drop_inst;

  switch_ctrl_reg   switch_ctrl_inst;
  port_enable_reg   port_enable_inst;
  fwd_enable_reg    fwd_enable_inst;
  gen_ctrl_reg      gen_ctrl_inst;
  gen_pkt_cfg_reg   gen_pkt_cfg_inst;
  gen_interval_reg  gen_interval_inst;
  gen_count_reg     gen_count_inst;

  irq_status_reg    irq_status_inst;
  irq_enable_reg    irq_enable_inst;
  irq_force_reg     irq_force_inst;

  err_status_reg    err_status_inst;
  err_enable_reg    err_enable_inst;
  err_inject_reg    err_inject_inst;
  err_count_reg     err_count_inst;
  err_info_reg      err_info_inst;
  
  lock_reg          lock_reg_inst;
  soft_reset_reg    soft_reset_reg_inst;
  
  function new(string name = "reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    uvm_reg::include_coverage("*", UVM_CVR_ALL);

    // Existing register block HDL path
    add_hdl_path("tb.DUT", "RTL");

    // DEVICE_ID : 0x00, RO
    device_id_inst =device_id_reg::type_id::create("device_id_inst");
    device_id_inst.configure(this);
    device_id_inst.build();
    void'(device_id_inst.set_coverage(UVM_CVR_FIELD_VALS));
// VERSION : 0x04, RO
    version_inst = version_reg::type_id::create("version_inst");
    version_inst.configure(this);
    version_inst.build();
    void'(version_inst.set_coverage(UVM_CVR_FIELD_VALS));

    // SWITCH_STATUS : 0x08, RO
    switch_status_inst =switch_status_reg::type_id::create("switch_status_inst");
    switch_status_inst.configure(this);
    switch_status_inst.build();
    void'(switch_status_inst.set_coverage(UVM_CVR_FIELD_VALS));
    switch_status_inst.add_hdl_path_slice("switch_status_r", 0, 32);


    // PORT_STATUS : 0x0C, RO
    port_status_inst = port_status_reg::type_id::create("port_status_inst");
    port_status_inst.configure(this);
    port_status_inst.build();
    void'(port_status_inst.set_coverage(UVM_CVR_FIELD_VALS));
    port_status_inst.add_hdl_path_slice  ("port_status_r",   0, 32);


    // GEN_STATUS : 0x10, RO
    gen_status_inst = gen_status_reg::type_id::create("gen_status_inst");
    gen_status_inst.configure(this);
    gen_status_inst.build();
    void'(gen_status_inst.set_coverage(UVM_CVR_FIELD_VALS));
    gen_status_inst.add_hdl_path_slice   ("gen_status_r",    0, 32);


    // STAT_RX : 0x14, RO
    stat_rx_inst = stat_rx_reg::type_id::create("stat_rx_inst");
    stat_rx_inst.configure(this);
    stat_rx_inst.build();
    void'(stat_rx_inst.set_coverage(UVM_CVR_FIELD_VALS));
    stat_rx_inst.add_hdl_path_slice   ("stat_rx",   0, 16);


    // STAT_TX : 0x18, RO
    stat_tx_inst = stat_tx_reg::type_id::create("stat_tx_inst");
    stat_tx_inst.configure(this);
    stat_tx_inst.build();
    void'(stat_tx_inst.set_coverage(UVM_CVR_FIELD_VALS));
    stat_tx_inst.add_hdl_path_slice   ("stat_tx",   0, 16);


    // STAT_DROP : 0x1C, RO
    stat_drop_inst = stat_drop_reg::type_id::create("stat_drop_inst");
    stat_drop_inst.configure(this);
    stat_drop_inst.build();
    void'(stat_drop_inst.set_coverage(UVM_CVR_FIELD_VALS));
    stat_drop_inst.add_hdl_path_slice ("stat_drop", 0, 16);

    // SWITCH_CTRL : 0x20
    switch_ctrl_inst = switch_ctrl_reg::type_id::create("switch_ctrl_inst");
    switch_ctrl_inst.configure(this);
    switch_ctrl_inst.build();
    void'(switch_ctrl_inst.set_coverage(UVM_CVR_FIELD_VALS));
    switch_ctrl_inst.add_hdl_path_slice ("switch_ctrl_q",  0, 32);


    // PORT_ENABLE : 0x24, RW
    port_enable_inst =port_enable_reg::type_id::create("port_enable_inst");
    port_enable_inst.configure(this);
    port_enable_inst.build();
    void'(port_enable_inst.set_coverage(UVM_CVR_FIELD_VALS));
     // Backdoor path for port_enable
    port_enable_inst.add_hdl_path_slice("port_enable_q", 0, 4);

    // FWD_ENABLE : 0x28, RW
    fwd_enable_inst =fwd_enable_reg::type_id::create("fwd_enable_inst");
    fwd_enable_inst.configure(this);
    fwd_enable_inst.build();
    void'(fwd_enable_inst.set_coverage(UVM_CVR_FIELD_VALS));
    fwd_enable_inst.add_hdl_path_slice ("fwd_enable_q",    0, 4);


    // GEN_CTRL : 0x2C
    gen_ctrl_inst = gen_ctrl_reg::type_id::create("gen_ctrl_inst");
    gen_ctrl_inst.configure(this);
    gen_ctrl_inst.build();
    void'(gen_ctrl_inst.set_coverage(UVM_CVR_FIELD_VALS));
    gen_ctrl_inst.add_hdl_path_slice   ("gen_ctrl_q",      0, 32);

    // GEN_PKT_CFG : 0x30, RW
    gen_pkt_cfg_inst = gen_pkt_cfg_reg::type_id::create("gen_pkt_cfg_inst");
    gen_pkt_cfg_inst.configure(this);
    gen_pkt_cfg_inst.build();
    void'(gen_pkt_cfg_inst.set_coverage(UVM_CVR_FIELD_VALS));
    gen_pkt_cfg_inst.add_hdl_path_slice("gen_pkt_cfg_q",  0, 32);

    // GEN_INTERVAL : 0x34, RW
    gen_interval_inst =gen_interval_reg::type_id::create("gen_interval_inst");
    gen_interval_inst.configure(this);
    gen_interval_inst.build();
    void'(gen_interval_inst.set_coverage(UVM_CVR_FIELD_VALS));
    gen_interval_inst.add_hdl_path_slice("gen_interval_q", 0, 16);

    // GEN_COUNT : 0x38, RW
    gen_count_inst = gen_count_reg::type_id::create("gen_count_inst");
    gen_count_inst.configure(this);
    gen_count_inst.build();
    void'(gen_count_inst.set_coverage(UVM_CVR_FIELD_VALS));
    gen_count_inst.add_hdl_path_slice  ("gen_count_q",     0, 16);


    // IRQ_STATUS : 0x3C, W1C
    irq_status_inst =irq_status_reg::type_id::create("irq_status_inst");
    irq_status_inst.configure(this);
    irq_status_inst.build();
    void'(irq_status_inst.set_coverage(UVM_CVR_FIELD_VALS));
    irq_status_inst.add_hdl_path_slice ("irq_status_q", 0, 8);


    // IRQ_ENABLE : 0x40, RW
    irq_enable_inst =irq_enable_reg::type_id::create("irq_enable_inst");
    irq_enable_inst.configure(this);
    irq_enable_inst.build();
    void'(irq_enable_inst.set_coverage(UVM_CVR_FIELD_VALS));
    irq_enable_inst.add_hdl_path_slice ("irq_enable_q", 0, 8);

    // IRQ_FORCE : 0x44, WO
    irq_force_inst =irq_force_reg::type_id::create("irq_force_inst");
    irq_force_inst.configure(this);
    irq_force_inst.build();
    void'(irq_force_inst.set_coverage(UVM_CVR_FIELD_VALS));
    
    // ERR_STATUS : 0x48, W1C
    err_status_inst =err_status_reg::type_id::create("err_status_inst");
    err_status_inst.configure(this);
    err_status_inst.build();
    void'(err_status_inst.set_coverage(UVM_CVR_FIELD_VALS));
    err_status_inst.add_hdl_path_slice ("err_status_q", 0, 8);

    // ERR_ENABLE : 0x4C, RW
    err_enable_inst =err_enable_reg::type_id::create("err_enable_inst");
    err_enable_inst.configure(this);
    err_enable_inst.build();
    void'(err_enable_inst.set_coverage(UVM_CVR_FIELD_VALS));
    err_enable_inst.add_hdl_path_slice ("err_enable_q", 0, 8);

    // ERR_INJECT : 0x50, WO
    err_inject_inst =err_inject_reg::type_id::create("err_inject_inst");
    err_inject_inst.configure(this);
    err_inject_inst.build();
    void'(err_inject_inst.set_coverage(UVM_CVR_FIELD_VALS));
    

    // ERR_COUNT : 0x54, RO
    err_count_inst = err_count_reg::type_id::create("err_count_inst");
    err_count_inst.configure(this);
    err_count_inst.build();
    void'(err_count_inst.set_coverage(UVM_CVR_FIELD_VALS));
    err_count_inst.add_hdl_path_slice ("err_count_q", 0, 16);

    // ERR_INFO : 0x58
    err_info_inst = err_info_reg::type_id::create("err_info_inst");
    err_info_inst.configure(this);
    err_info_inst.build();
    void'(err_info_inst.set_coverage(UVM_CVR_FIELD_VALS));
    err_info_inst.add_hdl_path_slice  ("err_info_q",  0, 32);
        
    lock_reg_inst = lock_reg::type_id::create("lock_reg_inst");
    lock_reg_inst.configure(this);
    lock_reg_inst.build();
    void'(lock_reg_inst.set_coverage(UVM_CVR_FIELD_VALS));
    lock_reg_inst.add_hdl_path_slice("locked", 0, 1);
    soft_reset_reg_inst = soft_reset_reg::type_id::create("soft_reset_reg_inst");
    soft_reset_reg_inst.configure(this);
    soft_reset_reg_inst.build();
    void'(soft_reset_reg_inst.set_coverage(UVM_CVR_FIELD_VALS));
    

    // Address map: base address 0, 32-bit registers, little endian
    default_map = create_map("default_map",'h0,4,UVM_LITTLE_ENDIAN);

    default_map.add_reg(device_id_inst,     'h00, "RO");
    default_map.add_reg(version_inst,       'h04, "RO");
    default_map.add_reg(switch_status_inst, 'h08, "RO");
    default_map.add_reg(port_status_inst,   'h0C, "RO");
    default_map.add_reg(gen_status_inst,    'h10, "RO");
    default_map.add_reg(stat_rx_inst,       'h14, "RO");
    default_map.add_reg(stat_tx_inst,       'h18, "RO");
    default_map.add_reg(stat_drop_inst,     'h1C, "RO");

    default_map.add_reg(switch_ctrl_inst,   'h20, "RW");
    default_map.add_reg(port_enable_inst,   'h24, "RW");
    default_map.add_reg(fwd_enable_inst,    'h28, "RW");
    default_map.add_reg(gen_ctrl_inst,      'h2C, "RW");
    default_map.add_reg(gen_pkt_cfg_inst,   'h30, "RW");
    default_map.add_reg(gen_interval_inst,  'h34, "RW");
    default_map.add_reg(gen_count_inst,     'h38, "RW");

    default_map.add_reg(irq_status_inst,    'h3C, "RW");
    default_map.add_reg(irq_enable_inst,    'h40, "RW");
    default_map.add_reg(irq_force_inst,     'h44, "WO");

    default_map.add_reg(err_status_inst,    'h48, "RW");
    default_map.add_reg(err_enable_inst,    'h4C, "RW");
    default_map.add_reg(err_inject_inst,    'h50, "WO");
    default_map.add_reg(err_count_inst,     'h54, "RO");
    default_map.add_reg(err_info_inst,      'h58, "RO");
    default_map.add_reg(lock_reg_inst,      'h5C, "RO");
    default_map.add_reg(soft_reset_reg_inst,'h60, "RO");
    lock_model();

  endfunction


endclass


