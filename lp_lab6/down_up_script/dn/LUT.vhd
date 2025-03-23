library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LUT is
    port (
        LUT_in  : in std_logic_vector(7 downto 0);
        LUT_sel : in std_logic_vector(2 downto 0);
        LUT_O   : out std_logic);
end LUT;

architecture structure of LUT is
begin
    LUT_O <=
        LUT_in(0) when LUT_sel = "000" else
        LUT_in(1) when LUT_sel = "001" else
        LUT_in(2) when LUT_sel = "010" else
        LUT_in(3) when LUT_sel = "011" else
        LUT_in(4) when LUT_sel = "100" else
        LUT_in(5) when LUT_sel = "101" else
        LUT_in(6) when LUT_sel = "110" else
        LUT_in(7);
end structure;
