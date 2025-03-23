library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder3to8 is
	generic (decDelay : time := 0 ns);
	port (
		w   : in std_logic_vector(2 downto 0);
		en  : in std_logic;
		clk : in std_logic;
		y   : out std_logic_vector(7 downto 0));
end decoder3to8;

architecture structural of decoder3to8 is

	component decoder1to2
		generic (decDelay : time := 0 ns);
		port (
			w  : in std_logic;
			en : in std_logic;
			y1 : out std_logic;
			y0 : out std_logic
		);
	end component;

	component D_FF
		port (
			D   : in std_logic;
			clk : in std_logic;
			Q   : out std_logic
		);
	end component;

	signal y_asynch  : std_logic_vector(7 downto 0);
	signal en_layer0 : std_logic_vector(3 downto 0);
	signal en_layer1 : std_logic_vector(1 downto 0);

begin
	layer0 : for i in 0 to 3 generate
		dec_lay0 : decoder1to2 generic map(decDelay => decDelay)
		port map(w => w(0), en => en_layer0(i), y1 => y_asynch(2 * i + 1), y0 => y_asynch(2 * i));
		FF_lay0_0 : D_FF port map(D => y_asynch(2 * i), clk => clk, Q => y(2 * i));
		FF_lay0_1 : D_FF port map(D => y_asynch(2 * i + 1), clk => clk, Q => y(2 * i + 1));
	end generate layer0;

	layer1 : for i in 0 to 1 generate
		dec_lay1 : decoder1to2 generic map(decDelay => decDelay)
		port map(w => w(1), en => en_layer1(i), y1 => en_layer0(2 * i + 1), y0 => en_layer0(2 * i));
	end generate layer1;

	-- layer2
	dec_lay2 : decoder1to2 generic map(decDelay => decDelay)
	port map(w => w(2), en => en, y1 => en_layer1(1), y0 => en_layer1(0));
end structural;