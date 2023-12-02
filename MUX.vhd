--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
--entity MUX1 is
--port (a,b1,b2,b3,b4:in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
--end entity MUX1;
--
--architecture Struct of MUX1 is
--
--process(clk)
--if s1='0' and s0='0' then
--c<=a;
--else c<=b1;
--end if;
--
--if s1='0' and s0='1' then
--c<=a;
--else c<=b2;
--end if;
--if s1='1' and s0='0' then
--c<=a;
--else c<=b3;
--end if;
--
--if s1='1' and s0='1' then
--c<=a;
--else c<=b4;
--end if;
--
--end process;
--end Struct


-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX1 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end entity MUX1;

architecture Struct_MUX1 of MUX1 is
begin
process(clk)
begin
if s1='0' and s0='0' then
c<=a;
else c<=b;
end if;

end process;
end Struct_MUX1;

----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX2 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end entity MUX2;

architecture Struct_MUX2 of MUX2 is
begin
process(clk)
begin
if s1='0' and s0='1' then
c<=a;
else 
c<=b;
end if;

end process;
end Struct_MUX2;

------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX3 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end entity MUX3;

architecture Struct_MUX3 of MUX3 is
begin
process(clk)
begin
if s1='1' and s0='0' then
c<=a;
else c<=b;
end if;

end process;
end Struct_MUX3;

-----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX4 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end entity MUX4;

architecture Struct_MUX4 of MUX4 is
begin
process(clk)
begin
if s1='1' and s0='1' then
c<=a;
else c<=b;
end if;

end process;
end Struct_MUX4;