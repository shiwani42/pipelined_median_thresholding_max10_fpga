-- 16-bit Up Synchronous Counter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR(15 downto 0));
end up_counter;

architecture Behavioral of up_counter is
    signal counter_reg : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter_reg <= (others => '0');
        elsif rising_edge(clk) then
            counter_reg <= counter_reg + 1;
        end if;
    end process;

    count <= counter_reg;
end Behavioral;
