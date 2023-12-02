library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.all;

entity shifter is
port ( A: in std_logic;   
		 s: out std_logic);
end entity shifter;

architecture Struct of shifter is 
 signal j,k,l,m : std_logic_vector(129 downto 0):='0';
 
 begin
  clock_process: process(clock)
  begin
 if (clock'event and clock='1') then
 count=count+1;--adder to add 1 to counter
 p=p+1;
 end process
 shifter_process: process(count)
 if count="00" then
 j[w]<=A;
 if i<128 then
 i=i+1;
 else 
 i=128;
 end if;
 p=p+1;
 elsif count="01" then
 k[x]<=A;
 if x<128 then
 x=x+1;
 else 
 x=128;
 end if
 p=p+1;
 end if
 elsif count="10" then
 l[y]<=A;
 if x<128 then
 y=y+1;
 else 
 y=128;
 end if
 p=p+1;
 end if
 else
 l[y]<=A;
 if z<128 then
 z=z+1;
 else 
 z=128;
 end if
 p=p+1;
 end if
end process;

if p> 128*2+1 then 
case y_pre is  
 when s1 =>
 if t<128 then 
 --O--median of 9 elements
 else 
 t=0;
 y_pre<=s2;
 when s2 =>
 if t<128 then
 --O--median of 9 elements
 else 
 t=0;
 y_pre<=s3;
  when s3 =>
 if t<128 then
 --O--median of 9 elements
 else 
 t=0;
 y_pre<=s1;
end process;
 output_process
 --<=Memory O
 
	