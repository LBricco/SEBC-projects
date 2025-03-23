library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.all;

entity grayencoder is
	port (
		ck  : in std_logic;
		rst : in std_logic;
		A   : in std_logic_vector(7 downto 0);
		B   : out std_logic_vector(7 downto 0);
		C   : out std_logic_vector(7 downto 0));
end grayencoder;

architecture behavioral of grayencoder is

	signal BTMP, C_tmp, buss : std_logic_vector(7 downto 0);

begin

	pck : process (ck, rst)
	begin
		if rst = '1' then
			buss <= (others => '0');
		elsif ck'event and ck = '1' then
			buss(7) <= A(7);
			for I in 0 to 7 - 1 loop
				buss(I) <= A(I) xor A(I + 1);
			end loop;
		end if;
	end process;

	B <= buss;

	pdec : process (ck, rst)
	begin
		if rst = '1' then
			BTMP <= (others => '0');
		elsif ck'event and ck = '1' then
			BTMP <= buss;
		end if;
	end process;

	C_tmp(7) <= BTMP(7);
	BancoRx : for I in 0 to 7 - 1 generate
		C_tmp(I) <= C_tmp(I + 1) xor BTMP(I);
	end generate;
	C <= C_tmp;
	
end behavioral;