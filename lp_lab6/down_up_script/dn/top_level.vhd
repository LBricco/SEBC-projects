library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
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
end top_level;

architecture structure of top_level is

component Multiplier
	generic (nbit: integer := 8);
	port(
	A : in std_logic_vector(7 downto 0);
	B : in std_logic_vector(7 downto 0);
	O : out std_logic_vector(15 downto 0)
	);
end component;

component Adder
	generic (nbit: integer := 8);
	port(
	A: in std_logic_vector(nbit-1 downto 0);
	B: in std_logic_vector(nbit-1 downto 0);
	AS: in std_logic; -- primo carry in
	SUM: out std_logic_vector(nbit-1 downto 0)
	);
end component;

component Reg 
  generic(nbit: integer := 8);
  port(
  CK : in std_logic;
  EN : in std_logic;
  R : in std_logic;
  D : in std_logic_vector(nbit-1 downto 0);
  Q : out std_logic_vector(nbit-1 downto 0)
  );
end component;

component FLIPFLOP
  port(
  CK: in std_logic;
  RN: in std_logic;
  WR: in std_logic; --D
  RD: out std_logic; --Q
  RDN: out std_logic --Qn
  );
end component;

component Logic
  port(   A, B : in std_logic_vector(7 downto 0);
          funcL : in std_logic_vector(1 downto 0);
          Y : out std_logic_vector(7 downto 0));
end component;

component LUT
  port (
      LUT_in  : in std_logic_vector(7 downto 0);
      LUT_sel : in std_logic_vector(2 downto 0);
      LUT_O   : out std_logic);
end component;


signal Multiplier_O : std_logic_vector(15 downto 0);
signal Adder_O : std_logic_vector(7 downto 0);
signal Logic_O : std_logic_vector(7 downto 0);
signal LUT_O : std_logic;

signal A_s : std_logic_vector(7 downto 0);
signal B_s : std_logic_vector(7 downto 0);
signal LUT_in : std_logic_vector(7 downto 0);
signal LUT_sel :std_logic_vector(2 downto 0);

signal O_s : std_logic_vector(15 downto 0);

constant zeros_x8 : std_logic_vector(7 downto 0) := (others => '0');
constant zeros_x15 : std_logic_vector(14 downto 0) := (others => '0');

signal Mux_s : std_logic_vector(15 downto 0);

signal func : std_logic_vector(1 downto 0);
signal funcL : std_logic_vector(1 downto 0);

begin

  ff_func_0 : FLIPFLOP port map ( CK => clk ,
                                  RN => rst_n,
                                  WR => OP_CODE(0),
                                  RD => func(0),
                                  RDN => open);
  ff_func_1 : FLIPFLOP port map ( CK => clk ,
                                  RN => rst_n,
                                  WR => OP_CODE(1),
                                  RD => func(1),
                                  RDN => open);
  ff_funcL_0 : FLIPFLOP port map (  CK => clk ,
                                    RN => rst_n,
                                    WR => prog_logic(0),
                                    RD => funcL(0),
                                    RDN => open);
  ff_funcL_1 : FLIPFLOP port map (  CK => clk ,
                                    RN => rst_n,
                                    WR => prog_logic(1),
                                    RD => funcL(1),
                                    RDN => open);
  -- func sono i primi due bit dell op code e pilota il mux di uscita
  -- funcL sono gli altri due bit dell'opcode e pilota la logica programmabile

  -- registri che campionano gli ingressi A B e uscita O
  ff_a : reg generic map(8) port map(clk, '1', rst_n, A, A_s);
  ff_b : reg generic map(8) port map(clk, '1', rst_n, B, B_s); 
  ff_out : reg generic map(16) port map(clk, '1', rst_n, Mux_s, O_s);   
  ff_LUT  : reg generic map(8) port map(clk, '1', rst_n, PROG, LUT_in);

  -- operatori
  Multiplier_1 : Multiplier generic map(8) port map(A_s, B_s, Multiplier_O);
  Adder_1 : Adder generic map(8) port map(A_s, B_s,'0', Adder_O);
  Logic_1 : Logic port map(A_s, B_s, funcL, Logic_O);
  LUT_1 : LUT port map(LUT_in, LUT_sel, LUT_O);

  -- mux di uscita
  Mux_s <=  (zeros_x8 & Adder_O) when func = "00" else 
            Multiplier_O when func = "01" else
            (zeros_x8 & Logic_O) when func = "10" else
            (zeros_x15 & LUT_O) ;

  LUT_sel <= A_s(2 downto 0);
  -- assegnazione uscita
  O <= O_s;
	        
end structure;