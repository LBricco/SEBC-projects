library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.all;

entity businvbeh is
	port (
		ck  : in std_logic;
		rst : in std_logic;
		A   : in std_logic_vector(7 downto 0);
		B   : out std_logic_vector(8 downto 0);
		C   : out std_logic_vector(7 downto 0));
end businvbeh;

architecture behavioral of businvbeh is

	signal AOLD, buss  : std_logic_vector(7 downto 0);
	signal AX          : std_logic_vector(8 downto 0);
	signal inv, invold : std_logic;
	signal invtmp      : std_logic;

begin

	inv <= invold;

	pck : process (ck, rst)
	begin
		if rst = '1' then
			AOLD   <= (others => '0');
			invold <= '0';
		elsif ck'event and ck = '1' then
			if invtmp = '0' then
				AOLD <= A;
			else
				AOLD <= not(A);
			end if;
			invold <= invtmp;
		end if;
	end process;

	AX(7 downto 0) <= A xor AOLD;
	AX(8)          <= invold;

	buss <= AOLD;
	pinv : process (AX)
		variable hamdist : integer := 0;
	begin
		hamdist := 0;
		for I in 0 to 8 loop
			if AX(I) = '1' then
				hamdist := hamdist + 1;
			end if;
		end loop;
		if (hamdist > 4) then
			invtmp <= '1';
		else
			invtmp <= '0';
		end if;
	end process;

	pdec : process (ck, rst)
	begin
		if rst = '1' then
			C <= (others => '0');
		elsif ck'event and ck = '1' then
			if inv = '0' then
				C <= buss;
			else
				C <= not(buss);
			end if;
		end if;
	end process;

	B(7 downto 0) <= buss;
	B(8)          <= inv;

end behavioral;