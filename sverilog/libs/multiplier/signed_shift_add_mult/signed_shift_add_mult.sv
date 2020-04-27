/*

  Simple signed shift add multiplier
  This multiplier has a delay of BITWIDTH clock cycles
  The product is shifted, hence no need to bit-bloat the inputs

*/

module signed_shift_add_mult #( parameter  WIDTH = 8)
                              (
                              input                                 clk       ,
                              input                                 start     ,
                              input         [WIDTH-1:0]             A         ,
                              input         [WIDTH-1:0]             B         ,

                              output logic                          done      ,
                              output logic  [2*WIDTH-1:0]           product   );


logic                             adden             ; // enable addition
logic   [$clog2(WIDTH):0]         multcounter       ; // counter for number of shift/adds
logic   [2*WIDTH-1:0]             adderRes          ; // one bit less than in unsigned shift_add_mult as no overflow
logic   [2*WIDTH-1:0]             prod_uns          ; // unsigned product
logic   [WIDTH-1:0]               A_unsigned        ;
logic   [WIDTH-1:0]               B_unsigned        ;

assign  adden = prod_uns[0] & !done;

assign  done = ( multcounter == WIDTH ) ? 1: 0;

assign  adderRes = prod_uns + { B_unsigned, { WIDTH {1'b0} } };    // using replication operator

assign A_unsigned = ( A[WIDTH-1] ) ? ~A + 1 : A;
assign B_unsigned = ( B[WIDTH-1] ) ? ~B + 1 : B;

assign product =  ( A[WIDTH-1] ^ B[WIDTH-1] ) ? ~prod_uns + 1: prod_uns;

always @(posedge clk) begin

  // mult counter
  if ( start )
    multcounter <= 0;
  else if ( !done )
    multcounter <= multcounter + 1;

  // Product computation
  if ( start )
    prod_uns <= A_unsigned;   // The multiplier is appended to the LSB

  else if(adden)
    prod_uns <= { adderRes[2*WIDTH-1:1]  };

  else if ( !done )
    prod_uns <= { 1'b0, prod_uns[2*WIDTH-1:1] };

end

endmodule
