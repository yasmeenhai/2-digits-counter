`timescale 1ns/1ps

module FSM_COUNT_tb;

  // Declare testbench signals
  logic clk_t, reset_t, start_t;
  logic [3:0] units_t, tens_t;
  logic F_t;

  // Instantiate the FSM_COUNT module
  FSM_COUNT TRY (start_t,clk_t,reset_t,F_t,units_t,tens_t);

  // Clock generation (50MHz clock period: 20ns)
  always #10 clk_t = ~clk_t;

  // Testbench stimulus
  initial begin
    // Initialize signals
    clk_t = 0;
    reset_t = 1;
    start_t = 0;
    $display ("startint the TB. ");
    // Hold reset for a few clock cycles
    #40;
    reset_t = 0;

    // Start the counter
    #10;
    start_t = 1;

    // Wait for the counter to reach its max (59 cycles or 600ns approx.)
    #300;
    #100 start_t= 0;
    
    #100 start_t = 1;
    #1000
     //Check if F is set when tens == 5
    if (F_t == 1 && tens_t == 5)
      $display("Test passed: F is set to 1 when tens == 5.");
    else if (F_t ==1 && tens_t != 5)
      $display("Test failed: F is not set properly.");
    // Stop the counter
    start_t = 0;

    // Reset the system and observe the behavior
    #50;
    reset_t = 1;
    #20;
    reset_t = 0;

    // Wait a few more clock cycles to see if the counter resets correctly
    #100;
    start_t = 0 ;
    #100;
   
   
    
  end
  initial begin
    $monitor("tens: %d,units:%d ,F = %d ,start = %b ,reset = %b ",tens_t,units_t,F_t,start_t,reset_t); 
  end

endmodule
