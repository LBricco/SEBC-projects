library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_sum6 is
end entity tb_sum6;

architecture behavioral of tb_sum6 is

    -- dichiarazione segnali interni
    signal A_int : integer := 0;
    signal B_int : integer := 0;
    signal C_int : integer := 0;
    signal D_int : integer := 0;
    signal E_int : integer := 0;
    signal F_int : integer := 0;
    signal X_int : integer := 0;

    signal A : std_logic_vector(15 downto 0);
    signal B : std_logic_vector(15 downto 0);
    signal C : std_logic_vector(15 downto 0);
    signal D : std_logic_vector(15 downto 0);
    signal E : std_logic_vector(15 downto 0);
    signal F : std_logic_vector(15 downto 0);
    signal X : std_logic_vector(15 downto 0);

    signal clock : std_logic := '0';
    signal reset : std_logic := '0';

    -- dichiarazione component
    component TopLevel_adder6 is
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
    end component;

begin

    -- istanza component
    SUM6 : TopLevel_adder6 port map(
        MUX00 => A,
        MUX01 => C,
        MUX02 => X,
        MUX03 => D,
        MUX10 => B,
        MUX11 => X,
        MUX12 => F,
        MUX13 => E,
        CK    => clock,
        reset => reset,
        SUM   => X
    );

    -- segnale di clock
    CK_process : process
    begin
        wait for 50 ns;
        clock <= not clock;
    end process CK_process;

    A_int <= 1;
    B_int <= 4;
    C_int <= 7;
    D_int <= 12;
    E_int <= 30;
    F_int <= 21;

    A <= std_logic_vector(to_unsigned(A_int, 16));
    B <= std_logic_vector(to_unsigned(B_int, 16));
    C <= std_logic_vector(to_unsigned(C_int, 16));
    D <= std_logic_vector(to_unsigned(D_int, 16));
    E <= std_logic_vector(to_unsigned(E_int, 16));
    F <= std_logic_vector(to_unsigned(F_int, 16));

    X_int <= to_integer(unsigned(X));

end architecture behavioral;