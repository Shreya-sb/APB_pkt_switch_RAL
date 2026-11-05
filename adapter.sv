class top_adapter extends uvm_reg_adapter;
  `uvm_object_utils(top_adapter)
  
  function new( string name = "top_adapter");
    super.new(name);
  endfunction
  
  function uvm_sequence_item reg2bus (const ref uvm_reg_bus_op rw);
    seq_item apb_item;
    apb_item = seq_item::type_id::create("apb_item");
    apb_item.pwrite = (rw.kind == UVM_WRITE)?1'b1:1'b0;
    apb_item.paddr = rw.addr;
    apb_item.pwdata = rw.data;
    return apb_item;
  endfunction
  
  function void bus2reg (uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
    seq_item apb_item;
    assert ($cast(apb_item,bus_item));
    rw.kind = (apb_item.pwrite == 1'b1)?UVM_WRITE:UVM_READ;
    rw.data = (apb_item.pwrite == 1'b1)?apb_item.pwdata:apb_item.prdata;
    rw.addr = apb_item.paddr;
    rw.status = UVM_IS_OK;
  endfunction
endclass
  
