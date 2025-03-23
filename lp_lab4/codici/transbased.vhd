library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.all;

entity transbased is
	port (
		ck  : in std_logic;
		rst : in std_logic;
		A   : in std_logic_vector(7 downto 0);
		B   : out std_logic_vector(7 downto 0);
		C   : out std_logic_vector(7 downto 0));
end transbased;

architecture behavioral of transbased is

	signal buss, CENC, CENCOLD, CDECTMP : std_logic_vector(7 downto 0);

begin
	penc : process (ck, rst)
	begin
		if rst = '1' then
			buss <= (others => '0');
		elsif ck'event and ck = '1' then
			buss <= buss xor A;
		end if;
	end process;

	B <= buss;

	pdec : process (rst, ck)
	begin
		if rst = '1' then
			CENC <= (others => '0');
		elsif ck'event and ck = '1' then
			CENC <= buss;
		end if;
	end process;

	pdecold : process (rst, ck)
	begin
		if rst = '1' then
			CENCOLD <= (others => '0');
		elsif ck'event and ck = '1' then
			CENCOLD <= CENC;
		end if;
	end process;

	CDECTMP <= CENC xor CENCOLD;
	C       <= CDECTMP;

end behavioral;