library ieee;
use ieee.std_logic_1164.all;

entity register_block is
port (
A: in std_logic_vector( 7 downto 0);
clock: in std_logic;
R : in std_logic;
E: in std_logic;
op: out std_logic_vector( 7 downto 0)
);
end register_block;

architecture of_register_block of register_block is 

component ddff is
   port (D,E,R,P,clock: in std_logic; Q: out std_logic);
end component ddff;

signal out_pixel : std_logic_vector( 7 downto 0 );

begin

gate1: ddff port map ( D => A(0) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(0) );
gate2: ddff port map ( D => A(1) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(1) );
gate3: ddff port map ( D => A(2) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(2) );
gate4: ddff port map ( D => A(3) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(3) );
gate5: ddff port map ( D => A(4) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(4) );
gate6: ddff port map ( D => A(5) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(5) );
gate7: ddff port map ( D => A(6) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(6) );
gate8: ddff port map ( D => A(7) , E => E, R => R, P => '0', clock => clock , Q => out_pixel(7) );

op <= out_pixel; 
end of_register_block;