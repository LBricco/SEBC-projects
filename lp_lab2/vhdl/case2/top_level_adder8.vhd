library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_level_adder8 is
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
        SUM    : out std_logic_vector(15 downto 0)
    );
end entity top_level_adder8;

architecture structure of top_level_adder8 is

    -- segnali
    signal sel_0 : std_logic;
    signal sel_1 : std_logic;
    signal sel_2 : std_logic;
    signal sel_3 : std_logic;

    -- datapath
    component dpadder_8 is
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
    end component;

    -- macchina a stati
    component FSM_adder8 is
        port (
            CK  : in std_logic;
            RST : in std_logic;
            S0  : out std_logic;
            S1  : out std_logic;
            S2  : out std_logic;
            S3  : out std_logic
        );
    end component;

begin

    DP : dpadder_8 port map
    (
        MUX0_0 => MUX0_0,
        MUX0_1 => MUX0_1,
        MUX0_2 => MUX0_2,
        MUX0_3 => MUX0_3,
        MUX0_4 => MUX0_4,
        MUX0_5 => MUX0_5,
        MUX0_6 => MUX0_6,
        MUX0_7 => MUX0_7,
        MUX1_0 => MUX1_0,
        MUX1_1 => MUX1_1,
        CK     => CK,
        RST    => RST,
        S0     => sel_0,
        S1     => sel_1,
        S2     => sel_2,
        S3     => sel_3,
        SUM    => SUM
    );

    FSM : FSM_adder8 port map
    (
        CK  => CK,
        RST => RST,
        S0  => sel_0,
        S1  => sel_1,
        S2  => sel_2,
        S3  => sel_3
    );

end architecture structure;
