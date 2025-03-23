library ieee;
use ieee.std_logic_1164.all;

entity dummyALU is
port(
		clk : in std_logic;
		rst_n : in std_logic;  	
		O : out std_logic_vector(15 downto 0);
		B : in std_logic_vector(7 downto 0);
		A : in std_logic_vector(7 downto 0);
		PROG : in std_logic_vector(7 downto 0);
		go_sleep : in std_logic_vector(1 downto 0);
		OP_CODE : in std_logic_vector(1 downto 0); -- bit che vanno a finire in func
		prog_logic : in std_logic_vector(1 downto 0) -- bit che vanno a finire funcL
	);
end dummyALU;


architecture structure of dummyALU is
	component PMU
		port (
			opcode                                                   : in std_logic_vector(1 downto 0);
			go_sleep                                                 : in std_logic_vector(1 downto 0);
			clk                                                      : in std_logic;
			turn_off_add, turn_off_mul, turn_off_logic, turn_off_LUT : out std_logic;
			iso_add, iso_mul, iso_logic, iso_LUT                     : out std_logic;
			ret_reg_rest_in, ret_reg_rest_out                        : out std_logic);
	end component;

	component top_level
		port(
			clk : in std_logic;
			rst_n : in std_logic;  	
			O : out std_logic_vector(15 downto 0);
			B : in std_logic_vector(7 downto 0);
			A : in std_logic_vector(7 downto 0);
			PROG : in std_logic_vector(7 downto 0);
			turn_off_add, turn_off_mul, turn_off_logic, turn_off_LUT : in std_logic;
			iso_add, iso_mul, iso_logic, iso_LUT                     : in std_logic;
			ret_reg_rest_in, ret_reg_rest_out                        : in std_logic;
			OP_CODE : in std_logic_vector(1 downto 0); -- bit che vanno a finire in func
			prog_logic : in std_logic_vector(1 downto 0) -- bit che vanno a finire funcL
		);
	end component;

	-- i segnali hanno gli stessi nomi delle entity
	signal turn_off_add, turn_off_mul, turn_off_logic, turn_off_LUT : std_logic;
	signal iso_add, iso_mul, iso_logic, iso_LUT                     : std_logic;
	signal ret_reg_rest_in, ret_reg_rest_out                        : std_logic;

begin

	comp_PMU : PMU port map (	OP_CODE,
								go_sleep,
								clk,
								turn_off_add, turn_off_mul, turn_off_logic, turn_off_LUT,
								iso_add, iso_mul, iso_logic, iso_LUT,
								ret_reg_rest_in, ret_reg_rest_out);
	comp_top_level : top_level port map(clk,
										rst_n, 	
										O, 
										B,
										A,
										PROG,
										turn_off_add, turn_off_mul, turn_off_logic, turn_off_LUT,
										iso_add, iso_mul, iso_logic, iso_LUT,
										ret_reg_rest_in, ret_reg_rest_out,
										OP_CODE,
										prog_logic);
end structure;
