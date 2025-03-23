library ieee;
use ieee.std_logic_1164.all;

entity tb_glitch_chain is
end entity tb_glitch_chain;

architecture structure of tb_glitch_chain is

    signal A  : std_logic;
    signal B  : std_logic;
    signal C  : std_logic;
    signal D  : std_logic;
    signal X1 : std_logic;
    signal X2 : std_logic;
    signal X3 : std_logic;

begin

    A <= '1';
    B <= '1';
    C <= '1';
    D <= '1', '0' after 0.1 ns;

    X1P : process (A, B)
    begin
        X1 <= A and B;
    end process X1P;

    X2P : process (X1, C)
    begin
        X2 <= X1 and C;
    end process X2P;

    X3P : process (X2, D)
    begin
        X3 <= X2 and D;
    end process X3P;

end architecture structure;