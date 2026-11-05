class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  uvm_analysis_port #(seq_item) mon_ap;
  virtual top_if.mp_mon vif;
  seq_item tr;
  
  function new(string name = "monitor", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap",this);
    if(! uvm_config_db#(virtual top_if.mp_mon)::get (this, "", "vif", vif))`uvm_error("MON", "Error getting Interface Handle");
  endfunction
 

virtual task run_phase(uvm_phase phase);
    tr = seq_item::type_id::create("tr");
    forever begin
      @(vif.cb_mon);
      $display("-------------monitor begin----------");
      tr.paddr    =   vif.cb_mon.paddr;
      tr.pwrite   =   vif.cb_mon.pwrite;
      tr.psel     =   vif.cb_mon.psel;
      tr.penable  =   vif.cb_mon.penable;
      tr.pwdata   =   vif.cb_mon.pwdata;
      tr.prdata   =   vif.cb_mon.prdata;
      tr.pready   =   vif.cb_mon.pready;
      tr.pslverr  =   vif.cb_mon.pslverr;
      tr.irq      =   vif.cb_mon.irq;
      mon_ap.write(tr);

    end
  endtask

endclass
