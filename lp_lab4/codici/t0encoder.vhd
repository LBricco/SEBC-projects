library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

entity t0encoder is
	port (
		ck  : in std_logic;
		rst : in std_logic;
		A   : in std_logic_vector(7 downto 0);      -- ingresso
		B   : out std_logic_vector(8 downto 0);     -- uscita codificata
		C   : buffer std_logic_vector(7 downto 0)); -- uscita decodificata
end t0encoder;

architecture behavioral of t0encoder is

	signal Aprev : std_logic_vector(7 downto 0); -- ingresso dello step precedente
	signal buss  : std_logic_vector(7 downto 0); -- segnale codificato
	signal INC   : std_logic;                    -- flag di incremento

begin

	-- process per la codifica
	pck : process (ck, rst)
	begin
		if (rst = '1') then
			buss  <= (others => '0');
			Aprev <= (others => '0');
			INC   <= '0';

		elsif (ck'event and ck = '1') then
			if (A = std_logic_vector(unsigned(Aprev) + "00000001")) then
				INC <= '1';
			else
				INC  <= '0';
				buss <= A;
			end if;
			Aprev <= A;
		end if;
	end process;

	B <= INC & buss; -- uso il bit di incremento come MSB

	-- process per la decodifica
	pout : process (ck, rst)
	begin
		if (rst = '1') then
			C <= (others => '0');

		elsif (ck'event and ck = '1') then
			if (INC = '1') then
				C <= std_logic_vector(unsigned(C) + "00000001");
			else
				C <= buss;
			end if;
		end if;

	end process;

end behavioral;