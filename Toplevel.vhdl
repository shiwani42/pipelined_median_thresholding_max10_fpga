library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Toplevel is
   generic (
        ARRAY_SIZE : integer := 128;-- Define the size of the array
		  SIZE : integer:=9
    );
port(clock		: IN STD_LOGIC;
		reset: IN std_logic;
		rden: IN std_logic;
		wren: IN std_logic;
	wraddr		: in STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdaddr		: in STD_LOGIC_VECTOR (15 DOWNTO 0);
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		demuxout: OUT std_logic_vector(31 downto 0);
		op_1,op_2,op_3,op_4 : out std_logic_vector(23 downto 0) ;
	med_out : out STD_LOGIC_VECTOR(7 downto 0);
		binary_threshold: out STD_LOGIC_VECTOR(7 downto 0)
		);
		end entity;
architecture struct of Toplevel is

----------------------------------------Component Declaration Area---------


Component bram IS
	PORT
	(
		clock		: IN STD_LOGIC;
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rden		: IN STD_LOGIC;
		wraddress		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren		: IN STD_LOGIC;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END Component;

----demux code below!

component DEMUX is

Port ( I : in  STD_LOGIC_vector(7 downto 0);

S : in STD_LOGIC_VECTOR (1 downto 0);

Y : out STD_LOGIC_VECTOR (31 downto 0));

end component;

component up_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component buffer_register is
port (
A: in std_logic_vector(7 downto 0);
clock: in std_logic;
R : in std_logic;
E: in std_logic;
op : out std_logic_vector(23 downto 0) );

end component;

component Encoder is

Port ( A : in  STD_LOGIC_vector(23 downto 0);
B : in  STD_LOGIC_vector(23 downto 0);
C : in  STD_LOGIC_vector(23 downto 0);
D : in  STD_LOGIC_vector(23 downto 0);
S : in STD_LOGIC_VECTOR (1 downto 0);
Y : out STD_LOGIC_VECTOR (71 downto 0));
end component;

component median_filter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pixel0 : in STD_LOGIC_VECTOR(7 downto 0);
           pixel1 : in STD_LOGIC_VECTOR(7 downto 0);
			  pixel2 : in STD_LOGIC_VECTOR(7 downto 0);
			  pixel3 : in STD_LOGIC_VECTOR(7 downto 0);
			  pixel4 : in STD_LOGIC_VECTOR(7 downto 0);
			  pixel5 : in STD_LOGIC_VECTOR(7 downto 0);
			  pixel6 : in STD_LOGIC_VECTOR(7 downto 0);
			  pixel7 : in STD_LOGIC_VECTOR(7 downto 0);
			  pixel8 : in STD_LOGIC_VECTOR(7 downto 0);
           median_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component median_filter;

component binary_thresholding is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pixel_in : in STD_LOGIC_VECTOR(7 downto 0);
           threshold : in STD_LOGIC_VECTOR(7 downto 0);
           pixel_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component binary_thresholding;

component MUX1 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end component;

component MUX2 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end component;

component MUX3 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end component;

component MUX4 is
port (a,b :in std_logic_vector(7 downto 0);s1,s0,clk: in std_logic;c:out std_logic_vector(7 downto 0));
end component;


---------------------------------------------------------------------------


--------------Signal Declarations Area---------------
--signal radr,wadr:STD_LOGIC_VECTOR (15 DOWNTO 0);

signal data : std_logic_vector(7 downto 0);
signal rst: std_logic:='0';
signal o,T: std_logic_vector(7 downto 0);
signal count: std_logic_vector(15 downto 0):=(others=>'0');
signal demout,deout,d: std_logic_vector(31 downto 0);
signal encoder_out: std_logic_vector(71 downto 0);
signal op1,op2,op3,op4:std_logic_vector(23 downto 0);
signal median,bth:std_logic_vector(7 downto 0);
signal th:std_logic_vector(7 downto 0):="10001100";
signal Enabl:std_logic;
signal count1:  integer;

-----------------------------------------------------








begin
data<="10001000";


--------------Component Instantiation Area----------

			Enabl<='1' when count>"0000000110000000"
			else '0';


--BR: bram port map(clock, data, count, rden, count, wren, o);
BR: bram port map(clock, bth, count, rden, count, Enabl, o);

q<=o;
cnt:up_counter port map(clock, rst, count);


mux: demux port map(o, count( 8 downto 7), demout);
--------------
linebuffer1: buffer_register port map( deout(7 downto 0), clock, '0', '1', op1);
mux_1: MUX1 port map ( demout(7 downto 0), op1(23 downto 16), count(8), count(7), clock, d(7 downto 0) );
--------------------------
linebuffer2: buffer_register port map( deout(15 downto 8), clock, '0', '1', op2);
mux_2: MUX2 port map ( demout(15 downto 8), op2(23 downto 16), count(8), count(7), clock, d(15 downto 8) );
--------------------------
linebuffer3: buffer_register port map( deout(23 downto 16), clock, '0', '1', op3);
mux_3: MUX3 port map ( demout(23 downto 16), op3(23 downto 16), count(8), count(7), clock, d(23 downto 16) );
----------------------------
linebuffer4: buffer_register port map( deout(31 downto 24), clock, '0', '1', op4);
mux_4: MUX4 port map ( demout(31 downto 24), op4(23 downto 16), count(8), count(7), clock, d(31 downto 24) );
deout<=d;
demuxout <= demout;

encoder1: encoder port map( op1,op2,op3,op4,count( 8 downto 7), encoder_out);

med_filter1: median_filter port map (clock, reset, encoder_out(7 downto 0), encoder_out(15 downto 8), encoder_out(23 downto 16), encoder_out(31 downto 24), encoder_out(39 downto 32), encoder_out(47 downto 40), encoder_out(55 downto 48), encoder_out(63 downto 56), encoder_out(71 downto 64),median);
med_out<=median;
b_th: binary_thresholding port map(clock ,reset ,median,th,bth);
binary_threshold<=bth;

--count1<=to_integer(unsigned(count));




--l1: if to_integer( unsigned count1) > 384 generate
-- BR1: bram port map(clock, bth, count, rden, std_logic_vector(to_unsigned(to_integer( unsigned count1) - 384, 16)), '1', Q);   
--end generate l1;

--			Enabl<='1' when count>"0000000110000000"
--			else '0';

-- BR1: bram port map(clock, bth, count, rden, count, Enabl, T);

------------------------------------------------------




end struct;