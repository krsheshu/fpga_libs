/*
* Using 2FF synchronizer
* Assuming frequency of clkB > clkA for no data loss
*/

module singleBitCdc (   input wire     clkA           ,
                        input wire     bitA           ,
                        input wire     clkB           ,
                        output wire    sync_bitB      );


  reg     reg_bitA;
  reg     reg_sync_bitB;

  assign sync_bitB    = reg_sync_bitB;

  always  @(posedge clkB) begin

    {reg_sync_bitB, reg_bitA}   <= {reg_bitA, bitA};

  end

endmodule
