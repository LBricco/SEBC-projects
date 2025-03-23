library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.all;

entity busnormal is
	port (
		ck  : in std_logic;
		rst : in std_logic;
		A   : in std_logic_vector(7 downto 0);
		B   : out std_logic_vector(7 downto 0);
		C   : out std_logic_vector(7 downto 0));
end busnormal;

architecture behavioral of busnormal is

	signal buss : std_logic_vector(7 downto 0);

begin

	pck : process (ck, rst)
	begin
		if rst = '1' then
			buss <= (others => '0');
		elsif ck'event and ck = '1' then
			buss <= A;
		end if;
	end process;

	B <= buss;

	pout : process (ck, rst)
	begin
		if rst = '1' then
			C <= (others => '0');
		elsif ck'event and ck = '1' then
			C <= buss;
		end if;

	end process;

end behavioral;