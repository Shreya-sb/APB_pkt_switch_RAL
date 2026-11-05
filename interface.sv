interface top_if(input bit pclk,input bit presetn);
  
  logic pwrite;
  logic psel;
  logic penable;
  logic [15:0]paddr;
  logic [31:0]pwdata;
  logic [31:0]prdata;
  logic pready;
  logic pslverr;
  logic irq;

 clocking cb_drv @(posedge pclk);
    default input #0 output #0;
    input presetn;
    output psel;
    output penable;
    output pwrite;
    output paddr;
    output pwdata;
    input prdata;
    input pready;
    input pslverr;
    input irq;
  endclocking

  clocking cb_mon @(posedge pclk);
    default input #0 output #0;
    input psel;
    input penable;
    input pwrite;
    input paddr;
    input pwdata;
    input prdata;
    input pready;
    input pslverr;
    input irq;
  endclocking

  modport mp_drv(clocking cb_drv, input pclk, presetn, prdata);
  modport mp_mon(clocking cb_mon, input pclk, presetn);
   
endinterface
