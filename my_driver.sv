// my_driver.sv

class my_driver extends uvm_driver#(my_transaction);
  `uvm_component_utils(my_driver)

  // Puerto TLM para enviar el estado (Analysis Port)
  uvm_analysis_port#(bit [7:0]) status_ap;

  // El estado interno: ¡Nuestra lógica a probar!
  protected bit [7:0] status_reg; // Usamos protected para un mejor encapsulamiento,
                                  // pero SVUnit tendrá que acceder a ella de algún modo.
                                  // (En un test real, podríamos necesitar un método 'get' público)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    status_ap = new("status_ap", this);
    status_reg = 8'h00; // Valor inicial
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      my_transaction req;
      // Esperar y obtener la próxima transacción del sequencer
      seq_item_port.get_next_item(req); 
      process_transaction(req);
      seq_item_port.item_done();
    end
  endtask

  // Función que contiene la lógica de negocio a verificar
  virtual protected function void process_transaction(my_transaction tr);
    case(tr.cmd)
      my_transaction::SET: begin
        status_reg = tr.data;
      end
      my_transaction::INCREMENT: begin
        status_reg++;
      end
      my_transaction::DECREMENT: begin
        status_reg--;
      end
      my_transaction::GET_STATUS: begin
        // Enviar el estado actual por el Analysis Port
        status_ap.write(status_reg); 
      end
      default: begin
        // NO_OP o cualquier otro
      end
    endcase
  endfunction

endclass