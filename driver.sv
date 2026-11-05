class driver extends uvm_driver#(seq_item);
 `uvm_component_utils(driver)
  seq_item tr;
  virtual top_if.mp_drv vif;
 
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  //tr = seq_item::type_id::create("tr",this);
    if(!uvm_config_db#(virtual top_if.mp_drv)::get(this,"","vif",vif))
      `uvm_error("drv","Unable to access Interface");
  endfunction
  
  ///////////////main task of driver
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
 // tr = seq_item::type_id::create("tr");
    vif.cb_drv.psel    <= 1'b0;
    vif.cb_drv.penable <= 1'b0;
    vif.cb_drv.pwrite  <= 1'b0;
    vif.cb_drv.paddr   <= 16'h0;
    vif.cb_drv.pwdata  <= 32'h0;

  forever begin
  seq_item_port.get_next_item(tr);
  drive();
  seq_item_port.item_done();
  $display("-----------DRIVER----------"); 
  end
  endtask
  
  
  //////////////drive DUT
  task drive();
 // if(vif.cb_drv.rst == 1'b1)begin
 if(tr.pwrite == 1'b1)
  begin 
  @(vif.cb_drv);
     vif.cb_drv.paddr <= tr.paddr;
     vif.cb_drv.pwrite <= 1'b1;
     vif.cb_drv.pwdata <= tr.pwdata;
     vif.cb_drv.psel <= 1'b1;
     vif.cb_drv.penable <= 1'b0; 
     @( vif.cb_drv);
     vif.cb_drv.penable <=1'b1;
     `uvm_info("DRV", $sformatf("Data Write -> Wdata : %0h",tr.pwdata),UVM_NONE);
     do
      @(vif.cb_drv);
     while(!vif.cb_drv.pready);
     
     // Check error
     if (vif.cb_drv.pslverr) begin
        `uvm_error("DRV", "APB WRITE ERROR")
     end

     // IDLE
     vif.cb_drv.psel    <= 1'b0;
     vif.cb_drv.penable <= 1'b0;
   end

 else
  begin
     @(vif.cb_drv);
     vif.cb_drv.pwrite <= 1'b0;
     vif.cb_drv.paddr <= tr.paddr;
     vif.cb_drv.psel <= 1'b1;
     vif.cb_drv.penable <= 1'b0;
     // ACCESS
     @(vif.cb_drv);
     vif.cb_drv.penable <= 1'b1; 
     `uvm_info("DRV", $sformatf("Data READ -> read data : %0h",tr.prdata),UVM_NONE);
     // Wait for completion
     do
     @(vif.cb_drv);
     while (!vif.cb_drv.pready);

     tr.prdata = vif.cb_drv.prdata;
     // Check error
     if (vif.cb_drv.pslverr) begin
       `uvm_error("DRV", "APB READ ERROR")
     end
     vif.cb_drv.psel <= 1'b0;
     vif.cb_drv.penable <=1'b0;
  end
  endtask
endclass
