class environment extends uvm_env;
  agent agent_inst;
  reg_block regmodel; 
  top_adapter adapter_inst;
//scoreboard scb;
 `uvm_component_utils(environment)

  function new(string name = "environment", uvm_component parent);
  super.new(name, parent);
  endfunction : new

  // build_phase - create the components
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    agent_inst = agent::type_id::create("agent_inst", this);
    regmodel = reg_block::type_id::create("regmodel", this);
    adapter_inst = top_adapter::type_id::create("adapter_inst",, get_full_name());
    //scb = scoreboard::type_id::create("scb", this);
    regmodel.configure(null,"");
    regmodel.build();
    regmodel.lock_model();
  endfunction


  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    //agent_inst.mon.mon_ap.connect(scb.received_value); 
    regmodel.default_map.set_sequencer( .sequencer(agent_inst.seqr), .adapter(adapter_inst) );
    regmodel.default_map.set_base_addr(0);
    regmodel.default_map.set_auto_predict(1);    
  endfunction
endclass
