/*
* Using 2FF synchronizer with gray encoding
* Assuming Frequency of clkB > clkA for no data loss
*/

module multiBitCdc #( parameter  WIDTH = 8 )

          (   input   wire                        clkA            ,
              input   wire    [ WIDTH-1   : 0 ]   wordA           ,
              input   wire                        clkB            ,
              output  wire    [ WIDTH-1   : 0 ]   sync_wordB      );


  wire    [ WIDTH-1    : 0 ]        gray_wordA;
  reg     [ WIDTH-1    : 0 ]    reg_gray_wordA;
  reg     [ WIDTH-1    : 0 ]   sync_gray_wordB;

  // Conversion to input Gray codes
  assign gray_wordA             = wordA ^ { 1'b0, wordA [WIDTH -1: 1]  } ;

  // Conversion to output Binary codes
  genvar i;

  generate for( i = 0; i < WIDTH; i=i+1 ) begin

      assign sync_wordB[i]      = ^sync_gray_wordB[WIDTH-1:i];

  end endgenerate

  always  @(posedge clkB) begin

    reg_gray_wordA    <=        gray_wordA;
    sync_gray_wordB   <=    reg_gray_wordA;

  end

endmodule
