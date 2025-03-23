library ieee;
use ieee.std_logic_1164.all;

--opcode = 0 -> MUL
--opcode = 1 -> SUM

entity PMU is
	port (
		opcode                                                   : in std_logic_vector(1 downto 0);
		go_sleep                                                 : in std_logic_vector(1 downto 0);
		clk                                                      : in std_logic;
		turn_off_add, turn_off_mul, turn_off_logic, turn_off_LUT : out std_logic;
		iso_add, iso_mul, iso_logic, iso_LUT                     : out std_logic;
		ret_reg_rest_in, ret_reg_rest_out                        : out std_logic);
end PMU;

architecture behaviour of PMU is

	signal turn_off_add_int, turn_off_mul_int, turn_off_logic_int, turn_off_LUT_int : std_logic;
	signal iso_add_int, iso_mul_int, iso_logic_int, iso_LUT_int                     : std_logic;
	signal ret_reg_rest_int                                                         : std_logic;

begin

	-- isolation attivo basso
	-- turn off signal attivi alti
	-- retention signal attivi bassi
	process (opcode, go_sleep)
	begin
		--valori di default, tipo come nelle macchine a stati
		--default sarebbe che funziona tutto, no isolation, registri in transparent modex\
		turn_off_add_int   <= '0';
		turn_off_mul_int   <= '0';
		turn_off_logic_int <= '0';
		turn_off_LUT_int   <= '0';

		iso_add_int   <= '1';
		iso_mul_int   <= '1';
		iso_logic_int <= '1';
		iso_LUT_int   <= '1';

		ret_reg_rest_int <= '1';

		if go_sleep = "11" then -- full power mode

			if opcode = "00" then   --lavora adder
				turn_off_mul_int   <= '1';
				turn_off_logic_int <= '1';
				turn_off_LUT_int   <= '1';

				iso_mul_int   <= '0';
				iso_logic_int <= '0';
				iso_LUT_int   <= '0';

			elsif opcode = "01" then --lavora mply
				turn_off_add_int   <= '1';
				turn_off_logic_int <= '1';
				turn_off_LUT_int   <= '1';

				iso_add_int   <= '0';
				iso_logic_int <= '0';
				iso_LUT_int   <= '0';

			elsif opcode = "10" then -- lavora logica
				turn_off_add_int <= '1';
				turn_off_mul_int <= '1';
				turn_off_LUT_int <= '1';

				iso_add_int <= '0';
				iso_mul_int <= '0';
				iso_LUT_int <= '0';
			else -- opcode = 11 --lavora LUT
				turn_off_add_int   <= '1';
				turn_off_mul_int   <= '1';
				turn_off_logic_int <= '1';

				iso_add_int   <= '0';
				iso_mul_int   <= '0';
				iso_logic_int <= '0';
			end if;

		elsif go_sleep = "10" then -- normal mode

			turn_off_mul_int <= '1'; -- spengo multiply
			iso_mul_int      <= '0'; -- isolation multiply

			if opcode = "00" then --somma -- turn off logica lut
				turn_off_logic_int <= '1';
				turn_off_LUT_int   <= '1';

				iso_logic_int <= '0';
				iso_LUT_int   <= '0';

			elsif opcode = "10" then --logica -- turn off somma lut
				turn_off_add_int <= '1';
				turn_off_LUT_int <= '1';

				iso_add_int <= '0';
				iso_LUT_int <= '0';

			elsif opcode = "11" then --lut -- turn off somma logica
				turn_off_add_int   <= '1';
				turn_off_logic_int <= '1';

				iso_add_int        <= '0';
				iso_logic_int      <= '0';

			else -- turn off tutto il resto
				turn_off_add_int   <= '1';
				turn_off_logic_int <= '1';
				turn_off_LUT_int   <= '1';

				iso_add_int   <= '0';
				iso_logic_int <= '0';
				iso_LUT_int   <= '0';

				ret_reg_rest_int <= '0'; --registri retention mode

			end if;

		elsif go_sleep = "01" then -- low power mode
			-- turn off mply logica lut
			turn_off_mul_int   <= '1';
			turn_off_logic_int <= '1';
			turn_off_LUT_int   <= '1';

			iso_mul_int   <= '0';
			iso_logic_int <= '0';
			iso_LUT_int   <= '0';

			-- se opcode = 00 il sommatore lavora grazie ai default messi prima del if
			-- se opcode != 00 posso spegnere anche il sommatore
			if (opcode = "01" or opcode = "10" or opcode = "11") then
				turn_off_add_int <= '1';

				iso_add_int <= '0';

				ret_reg_rest_int <= '0'; --registri retention mode

			end if;
		else -- go_sleep = 00 (sleep mode)
			turn_off_add_int   <= '1';
			turn_off_mul_int   <= '1';
			turn_off_logic_int <= '1';
			turn_off_LUT_int   <= '1';

			iso_add_int   <= '0';
			iso_mul_int   <= '0';
			iso_logic_int <= '0';
			iso_LUT_int   <= '0';

			ret_reg_rest_int <= '0';

		end if;
	end process;

	--segnale non ritardato
	ret_reg_rest_in <= ret_reg_rest_int;

	--segnali ritardati
	process (clk)
	begin
		if (clk'event and clk = '1') then
			turn_off_add     <= turn_off_add_int;
			turn_off_mul     <= turn_off_mul_int;
			turn_off_logic   <= turn_off_logic_int;
			turn_off_LUT     <= turn_off_LUT_int;
			iso_add          <= iso_add_int;
			iso_mul          <= iso_mul_int;
			iso_logic        <= iso_logic_int;
			iso_LUT          <= iso_LUT_int;
			ret_reg_rest_out <= ret_reg_rest_int;
		end if;
	end process;

end architecture;
