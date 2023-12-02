library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Encoder is

Port ( A : in  STD_LOGIC_vector(23 downto 0);
B : in  STD_LOGIC_vector(23 downto 0);
C : in  STD_LOGIC_vector(23 downto 0);
D : in  STD_LOGIC_vector(23 downto 0);

S : in STD_LOGIC_VECTOR (1 downto 0);

Y : out STD_LOGIC_VECTOR (71 downto 0));

end Encoder;


architecture Behavioral of Encoder is

begin

process (S)

begin

if (S <= "00") then

Y(23 downto 0)<=B ;
Y(47 downto 24)<= C;
Y(71 downto 48)<=D;


elsif (S <= "01") then

Y(23 downto 0)<=C ;
Y(47 downto 24)<= D;
Y(71 downto 48)<=A;


elsif (S <= "10") then

Y(23 downto 0)<=D ;
Y(47 downto 24)<= A;
Y(71 downto 48)<= B;


elsif  (S <= "11") then

Y(23 downto 0)<=A ;
Y(47 downto 24)<= B;
Y(71 downto 48)<=C;

end if;

end process;

end Behavioral;










