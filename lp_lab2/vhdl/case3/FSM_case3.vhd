library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM_case3 is
	port (
		CK    : in std_logic;
		reset : in std_logic;
		s_0   : out std_logic;
		s_1   : out std_logic;
		s_2   : out std_logic;
		s_3   : out std_logic
	);
end FSM_case3;

architecture behav of FSM_case3 is

	type state_type is (AB, XC, XD, XE, XF);
	attribute enum_encoding               : string;
	attribute enum_encoding of state_type : type is "00001 00010 00100 01000 10000";
	signal PS, NS                         : state_type; -- present state (PS) e next state (NS)

begin

	controlASM_segnali : process (PS)
	begin

		case PS is
			when AB =>
				s_0 <= '0';
				s_1 <= '0';
				s_2 <= '0';
				s_3 <= '0';

			when XC =>
				s_0 <= '1';
				s_1 <= '0';
				s_2 <= '1';
				s_3 <= '1';

			when XD =>
				s_0 <= '0';
				s_1 <= '1';
				s_2 <= '0';
				s_3 <= '1';

			when XE =>
				s_0 <= '1';
				s_1 <= '0';
				s_2 <= '1';
				s_3 <= '0';

			when XF =>
				s_0 <= '1';
				s_1 <= '1';
				s_2 <= '0';
				s_3 <= '1';

			when others =>
				s_0 <= '0';
				s_1 <= '0';
				s_2 <= '0';
				s_3 <= '0';
		end case;

	end process controlASM_segnali;

	controlASM_stati : process (PS)
	begin

		case PS is
			when AB =>
				NS <= XC;
			when XC =>
				NS <= XD;
			when XD =>
				NS <= XE;
			when XE =>
				NS <= XF;
			when XF =>
				NS <= AB;
			when others =>
				NS <= AB;
		end case;

	end process controlASM_stati;

	transitionsFSM : process (reset, CK)
	begin
		if (reset = '1') then -- RST asincrono attivo alto
			PS <= AB;
		elsif (CK'event and CK = '1') then -- fronte di salita del CK
			PS <= NS;
		end if;
	end process transitionsFSM;
end architecture behav;