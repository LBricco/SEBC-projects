library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Logic is
    port(   A, B : in std_logic_vector(7 downto 0);
            funcL : in std_logic_vector(1 downto 0);
            Y : out std_logic_vector(7 downto 0));
end Logic;

architecture structure of Logic is
    begin
    Y <=    (A and B) when funcL = "00" else
            (A or B) when funcL = "01" else
            (A xor B) when funcL = "10" else
            (others => '0');
end structure;
