library ieee;
use ieee.std_logic_1164.all;

entity tb_glitch_tree is
end entity tb_glitch_tree;

architecture structure of tb_glitch_tree is

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

    X2P : process (C, D)
    begin
        X2 <= C and D;
    end process X2P;

    X3P : process (X1, X2)
    begin
        X3 <= X1 and X2;
    end process X3P;

end architecture structure;