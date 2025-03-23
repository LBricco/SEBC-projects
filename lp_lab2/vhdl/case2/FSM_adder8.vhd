library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FSM_adder8 is
    port (
        CK  : in std_logic;
        RST : in std_logic;
        S0  : out std_logic;
        S1  : out std_logic;
        S2  : out std_logic;
        S3  : out std_logic
    );
end entity FSM_adder8;

architecture structure of FSM_adder8 is

    type state_type is (
        AB, XC, XD, XE, XF, XG, XH
    );
    attribute enum_encoding               : string;
    attribute enum_encoding of state_type : type is "000 001 011 010 110 111 101";
    signal state_vector                   : state_type;
    signal PS, NS                         : state_type; -- present state (PS) e next state (NS)

begin

    controlASM_segnali : process (PS)
    begin

        case PS is
            when AB =>
                S0 <= '0';
                S1 <= '0';
                S2 <= '0';
                S3 <= '0';

            when XC =>
                S0 <= '1';
                S1 <= '0';
                S2 <= '0';
                S3 <= '1';

            when XD =>
                S0 <= '1';
                S1 <= '1';
                S2 <= '0';
                S3 <= '1';

            when XE =>
                S0 <= '0';
                S1 <= '1';
                S2 <= '0';
                S3 <= '1';

            when XF =>
                S0 <= '0';
                S1 <= '1';
                S2 <= '1';
                S3 <= '1';

            when XG =>
                S0 <= '1';
                S1 <= '1';
                S2 <= '1';
                S3 <= '1';

            when XH =>
                S0 <= '1';
                S1 <= '0';
                S2 <= '1';
                S3 <= '1';

            when others =>
                S0 <= '0';
                S1 <= '0';
                S2 <= '0';
                S3 <= '0';
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
                NS <= XG;
            when XG =>
                NS <= XH;
            when XH =>
                NS <= AB;
            when others =>
                NS <= AB;
        end case;

    end process controlASM_stati;

    transitionsFSM : process (RST, CK)
    begin
        if (RST = '1') then -- RST asincrono attivo alto
            PS <= AB;
        elsif (CK'event and CK = '1') then -- fronte di salita del CK
            PS <= NS;
        end if;
    end process transitionsFSM;

end architecture structure;