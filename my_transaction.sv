class my_transaction extends uvm_sequence_item;
  // Tipos de comandos que gestionará el driver
  typedef enum {NO_OP, SET, INCREMENT, DECREMENT, GET_STATUS} command_t;

  // Campos de la transacción
  rand command_t cmd;
  rand bit [7:0] data;

  // UVM Object Utilities
  `uvm_object_utils_begin(my_transaction)
    `uvm_field_enum(command_t, cmd, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "my_transaction");
    super.new(name);
  endfunction
endclass