`include "svunit_defines.svh"
import uvm_pkg::*;
`include "my_driver.sv"
  import svunit_uvm_mock_pkg::*;

class my_driver_uvm_wrapper extends my_driver;

  `uvm_component_utils(my_driver_uvm_wrapper)
  function new(string name = "my_driver_uvm_wrapper", uvm_component parent);
    super.new(name, parent);
  endfunction

  //===================================
  // Build
  //===================================
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
    /* Place Build Code Here */
  endfunction

  //==================================
  // Connect
  //=================================
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    /* Place Connection Code Here */
  endfunction
endclass

module my_driver_unit_test;
  import svunit_pkg::svunit_testcase;

  string name = "my_driver_ut";
  svunit_testcase svunit_ut;


  //===================================
  // This is the UUT that we're 
  // running the Unit Tests on
  //===================================
  my_driver_uvm_wrapper my_my_driver;


  //===================================
  // Build
  //===================================
  function void build();
    svunit_ut = new(name);

    my_my_driver = my_driver_uvm_wrapper::type_id::create("", null);

    svunit_deactivate_uvm_component(my_my_driver);
  endfunction


  //===================================
  // Setup for running the Unit Tests
  //===================================
  task setup();
    svunit_ut.setup();
    /* Place Setup Code Here */

    svunit_activate_uvm_component(my_my_driver);

    //-----------------------------
    // start the testing phase
    //-----------------------------
    svunit_uvm_test_start();



  endtask


  //===================================
  // Here we deconstruct anything we 
  // need after running the Unit Tests
  //===================================
  task teardown();
    svunit_ut.teardown();
    //-----------------------------
    // terminate the testing phase 
    //-----------------------------
    svunit_uvm_test_finish();

    /* Place Teardown Code Here */

    svunit_deactivate_uvm_component(my_my_driver);
  endtask


  //===================================
  // All tests are defined between the
  // SVUNIT_TESTS_BEGIN/END macros
  //
  // Each individual test must be
  // defined between `SVTEST(_NAME_)
  // `SVTEST_END
  //
  // i.e.
  //   `SVTEST(mytest)
  //     <test code>
  //   `SVTEST_END
  //===================================
  `SVUNIT_TESTS_BEGIN



  `SVUNIT_TESTS_END

endmodule
