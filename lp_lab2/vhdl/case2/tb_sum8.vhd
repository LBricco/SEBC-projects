library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_sum8 is
end entity tb_sum8;

architecture behavioral of tb_sum8 is

    -- dichiarazione segnali interni
    signal A_int : integer := 0;
    signal B_int : integer := 0;
    signal C_int : integer := 0;
    signal D_int : integer := 0;
    signal E_int : integer := 0;
    signal F_int : integer := 0;
    signal G_int : integer := 0;
    signal H_int : integer := 0;
    signal X_int : integer := 0;

    signal A : std_logic_vector(15 downto 0);
    signal B : std_logic_vector(15 downto 0);
    signal C : std_logic_vector(15 downto 0);
    signal D : std_logic_vector(15 downto 0);
    signal E : std_logic_vector(15 downto 0);
    signal F : std_logic_vector(15 downto 0);
    signal G : std_logic_vector(15 downto 0);
    signal H : std_logic_vector(15 downto 0);
    signal X : std_logic_vector(15 downto 0);
    signal z : std_logic_vector(15 downto 0);

    signal clock : std_logic := '0';
    signal reset : std_logic := '0';

    -- dichiarazione component
    component top_level_adder8 is
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
    end component;

begin

    -- istanza component
    SUM8 : top_level_adder8 port map(
        MUX0_0 => A,
        MUX0_1 => C,
        MUX0_2 => E,
        MUX0_3 => D,
        MUX0_4 => z,
        MUX0_5 => H,
        MUX0_6 => F,
        MUX0_7 => G,
        MUX1_0 => B,
        MUX1_1 => X,
        CK     => clock,
        RST    => reset,
        SUM    => X
    );

    -- segnale di clock
    CK_process : process
    begin
        wait for 50 ns;
        clock <= not clock;
    end process CK_process;

    A_int <= 1;
    B_int <= 4;
    D_int <= 7;
    C_int <= 12;
    E_int <= 30;
    F_int <= 21;
    G_int <= 5;
    H_int <= 42;

    A <= std_logic_vector(to_unsigned(A_int, 16));
    B <= std_logic_vector(to_unsigned(B_int, 16));
    C <= std_logic_vector(to_unsigned(C_int, 16));
    D <= std_logic_vector(to_unsigned(D_int, 16));
    E <= std_logic_vector(to_unsigned(E_int, 16));
    F <= std_logic_vector(to_unsigned(F_int, 16));
    G <= std_logic_vector(to_unsigned(G_int, 16));
    H <= std_logic_vector(to_unsigned(H_int, 16));
    z <= (others => '0');

    X_int <= to_integer(unsigned(X));

end architecture behavioral;