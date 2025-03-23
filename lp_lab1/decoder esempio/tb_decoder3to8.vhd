library ieee;
use ieee.std_logic_1164.all;

entity tb_decoder3to8 is
end tb_decoder3to8;

architecture test of tb_decoder3to8 is

component decoder3to8
	generic(decDelay : time := 0 ns);
	port(	w	:	in	std_logic_vector(2 downto 0);
			en	:	in	std_logic;
			clk	:	in	std_logic;
			y	:	out	std_logic_vector(7 downto 0));
end component;

constant delay : time := 0.2 ns;
constant period : time := 0.5 ns;

signal w_test : std_logic_vector(2 downto 0);
signal y_test : std_logic_vector(7 downto 0);
signal clk : std_logic;

begin

DUT: decoder3to8	generic map(decDelay => delay)
						port map(w => w_test, en => '1', clk => clk, y => y_test);

clk_gen : process
	begin
	clk <= '0' , '1' after period/2 ;
	wait for period;
end process;

testing : process
	begin
	wait for period*2;
	wait until rising_edge(clk);
	w_test <=	"000",
				"001" after period, 
				"011" after 2*period, 
				"101" after 3*period, 
				"010" after 4*period, 
				"001" after 5*period, 
				"111" after 6*period;
	wait for 7 *period;
end process ;
end test;



