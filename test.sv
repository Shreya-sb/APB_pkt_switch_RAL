class test extends uvm_test;
  `uvm_component_utils(test)

  function new(string name = "test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  environment env;
  //reg_seq rseq;
  port_enable_seq rseq;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    rseq = port_enable_seq::type_id::create("rseq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.regmodel.set_coverage(UVM_CVR_FIELD_VALS);
    rseq.regmodel = env.regmodel;
    rseq.start(env.agent_inst.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  endtask
endclass

class all_test extends uvm_test;
  `uvm_component_utils(all_test)

  function new(string name = "all_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  environment env;
  //reg_seq rseq;
  all_registers_seq  rseq;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    rseq = all_registers_seq ::type_id::create("rseq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.regmodel.set_coverage(UVM_CVR_FIELD_VALS);
    rseq.regmodel = env.regmodel;
    rseq.start(env.agent_inst.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  endtask
endclass



//backdoor///


class port_enable_backdoor_test extends uvm_test;
  `uvm_component_utils(port_enable_backdoor_test)

  function new(string name = "port_enable_backdoor_test",uvm_component parent = null);
    super.new(name, parent);
  endfunction

  environment env;
  port_enable_backdoor_seq rseq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    rseq = port_enable_backdoor_seq::type_id::create("rseq");
  endfunction


  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.regmodel.set_coverage(UVM_CVR_FIELD_VALS);
    rseq.regmodel = env.regmodel;
    rseq.start(env.agent_inst.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  endtask
endclass



///backdoor peek poke//////

class port_enable_peekpoke_test extends uvm_test;
  `uvm_component_utils(port_enable_peekpoke_test)

  function new(string name = "port_enable_peekpoke_test",uvm_component parent = null);
    super.new(name, parent);
  endfunction

  environment env;
  port_enable_peekpoke_seq rseq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    rseq = port_enable_peekpoke_seq::type_id::create("rseq");
  endfunction


  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.regmodel.set_coverage(UVM_CVR_FIELD_VALS);
    rseq.regmodel = env.regmodel;
    rseq.start(env.agent_inst.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  endtask
endclass


//reset test//

/*class reg_hw_reset_test extends uvm_test;
  `uvm_component_utils(reg_hw_reset_test)

  function new(string name = "reg_hw_reset_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  environment env;
  uvm_reg_hw_reset_seq rstSeq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = environment::type_id::create("env", this);

    rstSeq = uvm_reg_hw_reset_seq::type_id::create("rstSeq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #20;
    rstSeq.model = env.regmodel;
    rstSeq.start(null);

    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  endtask

endclass*/


class reg_hw_reset_test extends uvm_test;
  `uvm_component_utils(reg_hw_reset_test)

  function new(string name = "reg_hw_reset_test",uvm_component parent = null);
    super.new(name, parent);
  endfunction

  environment env;
  reg_reset_check_seq rseq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
    rseq = reg_reset_check_seq::type_id::create("rseq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.regmodel.set_coverage(UVM_CVR_FIELD_VALS);
    rseq.regmodel = env.regmodel;
    rseq.start(env.agent_inst.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  endtask

endclass

class all_backdoor_test extends uvm_test;
  `uvm_component_utils(all_backdoor_test)

  function new(string name = "all_backdoor_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  environment env;
  all_registers_backdoor_seq rseq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    rseq = all_registers_backdoor_seq::type_id::create("rseq");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.regmodel.set_coverage(UVM_CVR_FIELD_VALS);
    rseq.regmodel = env.regmodel;
    rseq.start(env.agent_inst.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  endtask
endclass



//regression///

class ral_regression_test extends uvm_test;
  `uvm_component_utils(ral_regression_test)
  environment env;

  port_enable_seq  pe_seq;
  all_registers_seq fd_seq;
  port_enable_backdoor_seq pe_bd_seq;
  port_enable_peekpoke_seq pe_bd1_seq;
  //reg_reset_check_seq reset_seq;
  all_registers_backdoor_seq bd_seq;


  function new(string name = "ral_regression_test",uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    pe_seq = port_enable_seq::type_id::create("pe_seq");
    fd_seq = all_registers_seq::type_id::create("fd_seq");
    pe_bd_seq = port_enable_backdoor_seq::type_id::create("pe_bd_seq");
    pe_bd1_seq = port_enable_peekpoke_seq::type_id::create("pe_bd1_seq");
    bd_seq = all_registers_backdoor_seq::type_id::create("bd_seq");
    //reset_seq = reg_reset_check_seq::type_id::create("reset_seq");    
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.regmodel.set_coverage(UVM_CVR_FIELD_VALS);
    pe_seq.regmodel = env.regmodel;
    `uvm_info("REGRESSION", "Starting RAL Regression", UVM_LOW)
    //1.port enable frontdoor
    `uvm_info("REGRESSION", "Starting port enable Frontdoor Test", UVM_LOW)
    pe_seq.start(env.agent_inst.seqr);

    //2. Frontdoor test
    `uvm_info("REGRESSION", "Starting Frontdoor Test", UVM_LOW)
    fd_seq.regmodel = env.regmodel;    
    fd_seq.start(env.agent_inst.seqr);

    // 3. port enable Backdoor test
    `uvm_info("REGRESSION", "Starting port enable Backdoor Test", UVM_LOW)
    pe_bd_seq.regmodel = env.regmodel;
    pe_bd_seq.start(env.agent_inst.seqr);

    // 4. port enable Backdoor methods test
    `uvm_info("REGRESSION", "Starting port enable peek poke Test", UVM_LOW)
    pe_bd1_seq.regmodel = env.regmodel;
    pe_bd1_seq.start(env.agent_inst.seqr);

    // 5.all register backdoor test
    `uvm_info("REGRESSION", "Starting all register backdoor Test", UVM_LOW)
    bd_seq.regmodel = env.regmodel;    
    bd_seq.start(env.agent_inst.seqr);

     // Apply hardware reset
     //apply_reset();
    // 5. Hardware reset test
   // `uvm_info("REGRESSION", "Starting Hardware Reset Test", UVM_LOW)
    //reset_seq.regmodel = env.regmodel;    
   // reset_seq.start(env.agent_inst.seqr);
    
    `uvm_info("REGRESSION", "RAL Regression Completed", UVM_LOW)
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 30);
  //  env.regmodel.sample_values();
  endtask
endclass
