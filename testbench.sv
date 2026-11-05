`include "uvm_macros.svh"
 import uvm_pkg::*;
`include "package.sv"
`include "apb_pkt_pkg.sv"
module tb;
  bit pclk;
  bit presetn;
  top_if vif(.pclk(pclk),.presetn(presetn));  
  apb_pkt_switch DUT(.pclk(vif.pclk),.presetn(vif.presetn),.psel(vif.psel),.penable(vif.penable),.pwrite(vif.pwrite),.paddr(vif.paddr),.pwdata(vif.pwdata),.prdata(vif.prdata),.pready(vif.pready),.pslverr(vif.pslverr),.irq(vif.irq));

  always #10 pclk = ~pclk;

 initial begin
// clk = 0;
 presetn = 0;
#10 presetn =1;
//presetn = 0;
//#10 presetn = 1;
 end

task automatic apply_reset();
  presetn = 0;
  repeat (5) @(posedge pclk);
  presetn = 1;
  repeat (5) @(posedge pclk);
endtask
  
  initial begin
  #1;
  $display("Time=%0t presetn=%0b port_enable_q=%h locked=%b",
           $time, presetn,DUT.port_enable_q,DUT.locked);
  end  
  initial begin
  uvm_config_db#(virtual top_if.mp_drv)::set(null, "*", "vif", vif.mp_drv);
  uvm_config_db#(virtual top_if.mp_mon)::set(null, "*", "vif", vif.mp_mon);
  // $dumpfile("dump.vcd");
  //$dumpvars;
  end
  
  initial begin
  run_test(" ");  
  end

endmodule
