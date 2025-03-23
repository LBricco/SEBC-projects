library ieee;
use ieee.std_logic_1164.all;

--opcode = 0 -> MUL
--opcode = 1 -> SUM

entity PMU is
	port (
		opcode, go_sleep, clk             : in std_logic;
		turn_off_add, turn_off_mul        : out std_logic
		iso_add, iso_mul                  : out std_logic
		ret_reg_rest_in, ret_reg_rest_out : out std_logic
	);
end PMU;

architecture behaviour of PMU is

	signal turn_off_add_int, turn_off_mul_int : std_logic;
	iso_add_int, iso_mul_int                  : std_logic;
	ret_reg_rest_int                          : std_logic;

begin
	-- go_sleep attivo basso per selezionare active mode/sleep mode
	-- op_code u-istruzione
	process (opcode, go_sleep)
	begin
		if go_sleep = '1' then -- active mode
			if opcode = '0' then
				--MUL 
				turn_off_add_int <= '1'; -- disable adder
				iso_add_int      <= '0'; -- set isolation
				turn_off_mul_int <= '0'; -- enable mult
				iso_mul_int      <= '1'; -- NOT set isolation
				ret_reg_rest_int <= '1'; -- set registers in transparent mode
			else
				--ADD
				turn_off_add_int <= '0'; -- enable adder
				iso_add_int      <= '1'; -- NOT set isolation
				turn_off_mul_int <= '1'; -- disable mult
				iso_mul_int      <= '0'; -- set isolation
				ret_reg_rest_int <= '1'; -- set registers in transparent mode
			end if;
		else                     -- sleep mode
			turn_off_add_int <= '1'; -- disable adder
			iso_add_int      <= '0'; -- set isolation
			turn_off_mul_int <= '1'; -- disable mult
			iso_mul_int      <= '0'; -- set isolation
			ret_reg_rest_int <= '0'; -- NOT set registers in transparent mode
		end if;
	end process;

	ret_reg_rest_in <= ret_reg_rest_int;

	process (clk)
	begin
		if (rising_edge(clk)) then
			turn_off_add     <= turn_off_add_int;
			iso_add          <= iso_add_int;
			turn_off_mul     <= turn_off_mul_int;
			iso_mul          <= iso_mul_int;
			ret_reg_rest_out <= ret_reg_rest_int;
		end if;
	end process;

end architecture;