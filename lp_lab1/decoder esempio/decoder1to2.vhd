library ieee;
use ieee.std_logic_1164.all;


entity decoder1to2 is
	generic(decDelay	:	time := 0 ns);
	port(	w 	:	in std_logic;
			en	:	in std_logic;
			y1	:	out std_logic;
			y0	:	out std_logic
			);
end decoder1to2 ;

architecture structural of decoder1to2 is
	
	begin
	y1 <= w and en after decDelay;
	y0 <= (not w) and en after decDelay;

end structural;

