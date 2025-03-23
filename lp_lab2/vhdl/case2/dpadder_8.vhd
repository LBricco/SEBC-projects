
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dpadder_8 is
	port (
		MUX0_0 : in std_logic_vector(15 downto 0);
		MUX0_1 : in std_logic_vector(15 downto 0);
		MUX0_2 : in std_logic_vector(15 downto 0);
		MUX0_3 : in std_logic_vector(15 downto 0);
		MUX0_4 : in std_logic_vector(15 downto 0);
		MUX0_5 : in std_logic_vector(15 downto 0);
		MUX0_6 : in std_logic_vector(15 downto 0);
		MUX0_7 : in std_logic_vector(15 downto 0);
		MUX1_0 : in std_logic_vector(15 downto 0);
		MUX1_1 : in std_logic_vector(15 downto 0);
		CK     : in std_logic;
		RST    : in std_logic;
		S0     : in std_logic;
		S1     : in std_logic;
		S2     : in std_logic;
		S3     : in std_logic;
		SUM    : out std_logic_vector(15 downto 0)
	);
end dpadder_8;

---------------------------------------------

architecture behavioral of dpadder_8 is

	type state_type is (
		AB, XC, XD, XE, XF, XG, XH
	);
	signal PS, NS : state_type; -- present state (PS) e next state (NS)

	signal operanda : std_logic_vector(15 downto 0);
	signal operandb : std_logic_vector(15 downto 0);

begin
	P_MUX0 : process (MUX0_0, MUX0_1, MUX0_2, MUX0_3, MUX0_4, MUX0_5, MUX0_6, MUX0_7, S0, S1, S2)
		variable SEL0 : std_logic_vector(2 downto 0);
	begin
		SEL0(0) := S0;
		SEL0(1) := S1;
		SEL0(2) := S2;

		case SEL0 is
			when "000" =>
				operanda <= MUX0_0;
			when "001" =>
				operanda <= MUX0_1;
			when "010" =>
				operanda <= MUX0_2;
			when "011" =>
				operanda <= MUX0_3;
			when "100" =>
				operanda <= MUX0_4;
			when "101" =>
				operanda <= MUX0_5;
			when "110" =>
				operanda <= MUX0_6;
			when "111" =>
				operanda <= MUX0_7;
			when others =>
		end case;
	end process;

	P_MUX1 : process (MUX1_0, MUX1_1, S3)
		variable SEL1 : std_logic;
	begin
		SEL1 := S3;

		case SEL1 is
			when '0' =>
				operandb <= MUX1_0;
			when '1' =>
				operandb <= MUX1_1;
			when others =>
		end case;
	end process;

	P_ADDER_REGISTER : process (CK, RST)
	begin
		if RST = '1' then
			SUM <= (others => '0');
		elsif (CK'event and CK = '1') then
			SUM <= std_logic_vector(unsigned(operanda) + unsigned(operandb));
		end if;
	end process;

end behavioral;

configuration CFG_DP_ADDER of dpadder_8 is
	for behavioral
	end for;
end CFG_DP_ADDER;