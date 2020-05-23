
module asyncReset(
                    input wire          clk,
                    input wire   asyncrst_n,
                    output reg        rst_n
                  );

  reg        rff1;

  always  @(posedge clk or negedge asyncrst_n)  begin

    if (!asyncrst_n)
          {rst_n,rff1} <= 2'b0;
    else
          {rst_n,rff1} <= {rff1,1'b1};

  end

endmodule
