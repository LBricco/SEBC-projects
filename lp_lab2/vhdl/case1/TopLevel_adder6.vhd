library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel_adder6 is
	port (
		CK    : in std_logic;
		reset : in std_logic;
		MUX00 : in std_logic_vector(15 downto 0);
		MUX01 : in std_logic_vector(15 downto 0);
		MUX02 : in std_logic_vector(15 downto 0);
		MUX03 : in std_logic_vector(15 downto 0);
		MUX10 : in std_logic_vector(15 downto 0);
		MUX11 : in std_logic_vector(15 downto 0);
		MUX12 : in std_logic_vector(15 downto 0);
		MUX13 : in std_logic_vector(15 downto 0);
		SUM   : out std_logic_vector(15 downto 0)
	);
end TopLevel_adder6;

architecture structural of TopLevel_adder6 is

	component FSM_adder6 is
		port (
			CK    : in std_logic;
			reset : in std_logic;
			s_0   : out std_logic;
			s_1   : out std_logic;
			s_2   : out std_logic;
			s_3   : out std_logic
		);
	end component;

	component datapath_adder is
		port (
			MUX00 : in std_logic_vector(15 downto 0);
			MUX01 : in std_logic_vector(15 downto 0);
			MUX02 : in std_logic_vector(15 downto 0);
			MUX03 : in std_logic_vector(15 downto 0);
			MUX10 : in std_logic_vector(15 downto 0);
			MUX11 : in std_logic_vector(15 downto 0);
			MUX12 : in std_logic_vector(15 downto 0);
			MUX13 : in std_logic_vector(15 downto 0);
			clock : in std_logic;
			reset : in std_logic;
			SEL00 : in std_logic;
			SEL01 : in std_logic;
			SEL10 : in std_logic;
			SEL11 : in std_logic;
			SUM   : out std_logic_vector(15 downto 0)
		);
	end component;

	signal SEL00 : std_logic;
	signal SEL01 : std_logic;
	signal SEL10 : std_logic;
	signal SEL11 : std_logic;

begin

	DP_adder6 : datapath_adder port map(
		MUX00 => MUX00,
		MUX01 => MUX01,
		MUX02 => MUX02,
		MUX03 => MUX03,
		MUX10 => MUX10,
		MUX11 => MUX11,
		MUX12 => MUX12,
		MUX13 => MUX13,
		clock => CK,
		reset => reset,
		SEL00 => SEL00,
		SEL01 => SEL01,
		SEL10 => SEL10,
		SEL11 => SEL11,
		SUM   => SUM
	);

	FSM_add6 : FSM_adder6 port map(
		CK    => CK,
		reset => reset,
		s_0   => SEL00,
		s_1   => SEL01,
		s_2   => SEL10,
		s_3   => SEL11
	);

end architecture;