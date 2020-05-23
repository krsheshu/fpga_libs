library ieee;
use ieee.std_logic_1164.all;

entity asyncReset is
    port (
      clk        : in  std_logic;
      asyncrst_n : in  std_logic;
      rst_n      : out std_logic);
end asyncReset;

architecture rtl of asyncReset is
  signal rff1 : std_logic;
begin

  process (clk, asyncrst_n)
  begin
    if (asyncrst_n = '0') then
      rff1  <= '0';
      rst_n <= '0';
    elsif (clk'event and clk = '1') then
      rff1  <= '1';
      rst_n <= rff1;
    end if;
  end process;

end rtl;
