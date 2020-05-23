`timescale 1ns/1ps

`define CLKPERIOD1 100 // in nanoSeconds
`define CLKPERIOD2 85  // in nanoSeconds

function int run_nS( int time_innS );

  run_nS = time_innS;

endfunction

function int run_uS( int time_inuS );

  run_uS = (time_inuS * `CLKPERIOD1 *10 );

endfunction

module test ();

localparam WIDTH = 8;

bit                     clkA      ;
bit                     clkB      ;
logic   [WIDTH-1:0]     A         ;
logic   [WIDTH-1:0]     B         ;

multiBitCdc   #( .WIDTH        (8)         )
        dut    ( .clkA         (clkA       ),
                 .wordA        (A          ),
                 .clkB         (clkB       ),
                 .sync_wordB   (B          ));

always #(`CLKPERIOD1/2)       clkA = ~clkA;

always #(`CLKPERIOD2/2)       clkB = ~clkB;

initial begin

  $monitor("@%08d: A: %d, B%d",$time, A, B);

  #(run_uS(1)) A     =  7;
  @ (posedge clkB);
  @ (posedge clkB);
  @ (posedge clkB);
  assert( B == A )
    $display("CDC Test Successful");
  else
    $error("CDC Test Failed!");

  #(run_uS(1))  $finish;

end

endmodule
