library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity pipe is
   generic (
        ARRAY_SIZE : integer := 128;-- Define the size of the array
		  SIZE : integer:=9
    );

port(clock		: IN STD_LOGIC;
		reset: IN std_logic;
		wraddr		: out STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdaddr		: out STD_LOGIC_VECTOR (15 DOWNTO 0)
--		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
		end entity;
architecture struct of pipe is
--component bram is
--PORT
--	(
--		clock		: IN STD_LOGIC  := '1';
--		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--		rdaddress		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
--		rden		: IN STD_LOGIC  := '1';
--		wraddress		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
--		wren		: IN STD_LOGIC  := '0';
--		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--	);
--end component;
component bram is
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
end component;
type state1 is (S0, S1, S2, S3,S4);	
signal i: INTEGER:=0;
signal in1, in2, int1, int2, k: INTEGER:=0;
signal y_pre1,y_next: state1:=S0;
signal add1, add2: std_logic_vector(15 downto 0):=(others=>'0');
signal d,med, bin: std_logic_vector(7 downto 0);
signal e,f: std_logic_vector(7 downto 0):=(others=>'0');
type my_array is array(0 to ARRAY_SIZE - 1) of std_logic_vector(7 downto 0);
type sort is array(0 to SIZE - 1) of std_logic_vector(7 downto 0);
signal arr1,arr2, arr3, arr4 :my_array;
signal sort1, sort2: sort;
function SortArray(ArrayIn:sort) return sort is
        variable TempArray: sort:= ArrayIn;
    begin
        for i in 0 to 8 loop
            for j in 0 to 8 loop
                if TempArray(i) > TempArray(j) then
                    TempArray(i) := ArrayIn(j);
                    TempArray(j) := ArrayIn(i);
                end if;
            end loop;
        end loop;
        return TempArray;
    end SortArray;
	 
function binaryThresholding( A : std_logic_vector( 7 downto 0 ) ) return std_logic_vector is
			variable Threshold : std_logic_vector( 7 downto 0 ) := "10001100";
			variable Temp : std_logic_vector( 7 downto 0 );							
	begin
		if A > Threshold then
			Temp := "11111111";
		else
			Temp := "00000000";
		end if;
	return Temp;
end binaryThresholding;

begin
-------------------------Changes done by RA------------------------------------

------rd and wr adresss testing
wraddr<=add2;
rdaddr<=add1;









--------------------------------------------------------------------------------


--br1: bram port map(clock, e , add1, '1', add2, '0', d ));																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										, add2, '0', d);
clk_process: process( clock, reset)
begin
if reset ='0' then 
if clock='1' and clock'event then
y_pre1<=y_next;
Int1<= to_integer(unsigned(add1));
in1<=Int1+1;
add1 <= std_logic_vector(to_unsigned(in1, 16));

Int2<= to_integer(unsigned(add2));
in2<= Int2+1;
add2 <= std_logic_vector(to_unsigned(in2, 16));
end if;
else 
y_pre1<=S0;
end if;
end process;
br1: bram port map(clock, e, add1, '1', add2, '0', d);	
--q<=d;
state_run_proc:process(y_pre1,i,k, arr1,d,arr2, arr3, arr4, sort1, sort2, med, bin)
begin
if k<49152 then
case y_pre1 is
when S0=>
	if i<128*3 then --s has been detected
			if i<128 then
				arr1(i)<=d;
				y_next<= s0;
			elsif i<128*2 and i>127 then
				arr2(i-128)<=d;
				y_next<= s0;
			else 
				arr3(i-256)<=d;
				y_next<= s0;
			end if;
		i<=i+1;
		k<=k+1;
		y_next<= s0;-- Fill the code here
	else
		i<=i+1;
		y_next<=s1;
		k<=k+1;
	end if;

when S1=>
--for j in 0 to 127 loop
--arr4(j)<="00000000";
--end loop;
		if i<128*4 and i>(128*3-1) then --s has been detected
			arr4(i-128*3)<=d;
			i<=i+1;
			k<=k+1;
			sort1(0) <= arr1(i-128*3);
			sort1(1) <= arr1(i-128*3+1);
			sort1(2) <= arr1(i-128*3+2);
			sort1(3) <= arr2(i-128*3);
			sort1(4) <= arr2(i-128*3+1);
			sort1(5) <= arr2(i-128*3+2);
			sort1(6) <= arr3(i-128*3);
			sort1(7) <= arr3(i-128*3+1);
			sort1(8) <= arr3(i-128*3+2);
			sort2<= SortArray(sort1);
			med <= sort2(4);
			bin<= binaryThresholding(med);
		--median filtering and writing on memory
			y_next<= s1;-- Fill the code here
		else
			y_next<=s2;
			k<=k+1;
		end if;

when S2=>
--for j in 0 to 127 loop
--arr1(j)<="00000000";
--end loop;
if i<128*5 and i>(128*4-1) then --s has been detected
arr1(i-128*4)<=d;
i<=i+1;
k<=k+1;
sort1(0) <= arr2(i-128*4);
sort1(1) <= arr2(i-128*4+1);
sort1(2) <= arr2(i-128*4+2);
sort1(3) <= arr3(i-128*4);
sort1(4) <= arr3(i-128*4+1);
sort1(5) <= arr3(i-128*4+2);
sort1(6) <= arr4(i-128*4);
sort1(7) <= arr4(i-128*4+1);
sort1(8) <= arr4(i-128*4+2);
sort2<= SortArray(sort1);
med <= sort2(4);
bin<= binaryThresholding(med);
--median filtering and writing on memory
y_next<= s2;-- Fill the code here
else
y_next<=s3;
k<=k+1;
end if;

when S3=>
--for j in 0 to 127 loop
--arr2(j)<="00000000";
--end loop;
if i<128*6 and i>(128*5-1) then --s has been detected
arr2(i-128*5)<=d;
i<=i+1;
k<=k+1;
sort1(0) <= arr3(i-128*5);
sort1(1) <= arr3(i-128*5+1);
sort1(2) <= arr3(i-128*5+2);
sort1(3) <= arr4(i-128*5);
sort1(4) <= arr4(i-128*5+1);
sort1(5) <= arr4(i-128*5+2);
sort1(6) <= arr1(i-128*5);
sort1(7) <= arr1(i-128*5+1);
sort1(8) <= arr1(i-128*5+2);
sort2<= SortArray(sort1);
med <= sort2(4);
bin<= binaryThresholding(med);
--median filtering and writing on memory
y_next<= s3;-- Fill the code here
else
y_next<=s4;
k<=k+1;
end if;

when S4=>
--for j in 0 to 127 loop
--arr3(j)<="00000000";
--end loop;
if i<128*7 and i>(128*6-1) then --s has been detected
arr3(i-128*6)<=d;
i<=i+1;
k<=k+1;
sort1(0) <= arr4(i-128*5);
sort1(1) <= arr4(i-128*5+1);
sort1(2) <= arr4(i-128*5+2);
sort1(3) <= arr1(i-128*5);
sort1(4) <= arr1(i-128*5+1);
sort1(5) <= arr1(i-128*5+2);
sort1(6) <= arr2(i-128*5);
sort1(7) <= arr2(i-128*5+1);
sort1(8) <= arr2(i-128*5+2);
sort2<= SortArray(sort1);
med <= sort2(4);
bin<= binaryThresholding(med);
--median filtering and writing on memory
y_next<= s4;-- Fill the code here
else
i<=128*3;
y_next<= s1;
k<=k+1;
end if;
end case;
end if;
end process;
--br2: bram port map(clock, bin, add1, '0', add2, '1', f);
end struct;