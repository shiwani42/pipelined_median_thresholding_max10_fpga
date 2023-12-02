library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity ddff is
   port (D,E,R,P,clock: in std_logic; Q: out std_logic);
end entity ddff;

architecture behav of ddff is
 component ppff is
   port (J,K,E,R,P,clock: in std_logic; Q: out std_logic);
end component ppff;
signal B : std_logic;
begin
A1: INVERTER port map(A=>D, Y=>B);
F1: ppff port map (J=>D,K=>B,E=>E,R=>R,P=>P,clock=>clock,Q=>Q);
end behav;
