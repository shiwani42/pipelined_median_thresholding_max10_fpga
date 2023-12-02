library ieee;
use ieee.std_logic_1164.all;
entity Testbench is
end;

architecture beh of Testbench is
component Toplevel is
port(clock		: IN STD_LOGIC;
		reset: IN std_logic;
		rden: IN std_logic;
		wren: IN std_logic;
	wraddr		: in STD_LOGIC_VECTOR (15 DOWNTO 0);
rdaddr		: in STD_LOGIC_VECTOR (15 DOWNTO 0);
	q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
demuxout: OUT std_logic_vector(31 downto 0);
--		op_1,op_2,op_3,op_4 : out std_logic_vector(23 downto 0) ;
	med_out : out STD_LOGIC_VECTOR(7 downto 0);
		binary_threshold: out STD_LOGIC_VECTOR(7 downto 0)
		);
end component Toplevel;
signal rden, clk: std_logic:='1';
signal rdadd, wradd: std_logic_vector(15 downto 0):= (others=>'0');
signal wren, reset: std_logic:='0';
signal data: std_logic_vector(7 downto 0):=(others=>'0');
signal q: std_logic_vector(7 downto 0) ;
signal demuxout: std_logic_vector(31 downto 0);
signal med_out_test :  std_logic_vector(7 downto 0) ;
signal bth_test:std_logic_vector(7 downto 0);

begin
wradd<="0000000000000001";
rdadd<="0000000000000001";
reset<='0';
rden<= '1';
wren<= '0';
clk<= not clk after 5ns;
pipeline : Toplevel port map(clk,reset,rden,wren,wradd, rdadd, q, demuxout, med_out_test, bth_test);
end beh;