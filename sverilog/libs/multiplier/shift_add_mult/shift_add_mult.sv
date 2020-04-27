/*

  Simple unsigned shift add multiplier
  The product is shifted, hence no need to bit-bloat the inputs

*/

module shift_add_mult #( parameter  WIDTH = 8)
                (
                input                                 clk       ,
                input                                 start     ,
                input         [WIDTH-1:0]             A         ,
                input         [WIDTH-1:0]             B         ,

                output logic                          done      ,
                output logic  [2*WIDTH-1:0]           product   );


logic                             adden         ; // enable addition
logic   [$clog2(WIDTH):0]         multcounter   ; // counter for number of shift/adds
logic   [2*WIDTH:0]               adderRes      ;

assign  adden = product[0] & !done;

assign  done  = (multcounter == WIDTH) ? 1: 0;

assign  adderRes = product + { B, {WIDTH{1'b0}} };    // using replication operator

always @(posedge clk) begin

  // mult counter
  if ( start )
    multcounter <= 0;
  else if ( !done )
    multcounter <= multcounter + 1;

  // Product computation
  if ( start )
      product <= A;   // The multiplier is appended to the LSB
  else if(adden)
    product <= { adderRes[2*WIDTH:1]  };
  else if ( !done )
    product <= { 1'b0, product[2*WIDTH-1:1] };

end

endmodule
