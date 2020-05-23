`timescale 1ns/1ns

`define CLKPERIOD 100 // in nanoSeconds

function int run_nS( int time_innS );

  run_nS = time_innS;

endfunction

function int run_uS( int time_inuS );

  run_uS = (time_inuS * `CLKPERIOD *10 );

endfunction

module test #(parameter WIDTH = 8) ();

bit                     clk       ;
logic                   start     ;
logic   [WIDTH-1:0]     A         ;
logic   [WIDTH-1:0]     B         ;
logic                   done      ;
logic   [2*WIDTH-1:0]   product   ;

signed_shift_add_mult #  (  .WIDTH      (WIDTH)   )
                  dut    (  .clk        (clk      ),
                            .start      (start    ),
                            .A          (A        ),
                            .B          (B        ),

                            .done       (done     ),
                            .product    (product  ));

always #(`CLKPERIOD/2) clk = ~clk;

initial begin

  $monitor("@%08d: start=%d, A: %d, B%d, done:%d prod:%d",$time,start, A, B, done, product);
  start = 0;

  #(run_uS(1))  start = 1;
  A     = -128;
  B     = -128;

  #(run_nS(5 *`CLKPERIOD)) start = 0;

  #(run_uS(10));
  $display("%d x %d = %d (obtained)", $signed(A), $signed(B), $signed(product));
  prod: assert( $signed(product) == $signed(A)*$signed(B) )
    $display("Test Successful");
  else
    $error("Test Failed!");

  #(run_uS(1))  $finish;

end

endmodule
