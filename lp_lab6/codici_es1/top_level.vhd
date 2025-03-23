library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
  port (
    clk                               : in std_logic;
    rst_n                             : in std_logic;
    O                                 : out std_logic_vector(15 downto 0);
    B                                 : in std_logic_vector(7 downto 0);
    A                                 : in std_logic_vector(7 downto 0);
    turn_off_add, turn_off_mul        : in std_logic;
    iso_add, iso_mul                  : in std_logic;
    ret_reg_rest_in, ret_reg_rest_out : in std_logic;
    OP_CODE                           : in std_logic
  );
end top_level;

architecture structure of top_level is

  component Multiplier
    generic (nbit : integer := 8);
    port (
      A : in std_logic_vector(7 downto 0);
      B : in std_logic_vector(7 downto 0);
      O : out std_logic_vector(15 downto 0)
    );
  end component;

  component Adder
    generic (nbit : integer := 8);
    port (
      A   : in std_logic_vector(nbit - 1 downto 0);
      B   : in std_logic_vector(nbit - 1 downto 0);
      AS  : in std_logic;
      SUM : out std_logic_vector(nbit - 1 downto 0)
    );
  end component;

  component Reg
    generic (nbit : integer := 8);
    port (
      CK : in std_logic;
      EN : in std_logic;
      R  : in std_logic;
      D  : in std_logic_vector(nbit - 1 downto 0);
      Q  : out std_logic_vector(nbit - 1 downto 0)
    );
  end component;

  component FLIPFLOP
    port (
      CK  : in std_logic;
      RN  : in std_logic;
      WR  : in std_logic;
      RD  : out std_logic;
      RDN : out std_logic
    );
  end component;

  signal Multiplier_O : std_logic_vector(15 downto 0);
  signal Adder_O      : std_logic_vector(7 downto 0);

  signal A_sum_in_s : std_logic_vector(7 downto 0);
  signal B_sum_in_s : std_logic_vector(7 downto 0);
  signal A_mul_in_s : std_logic_vector(7 downto 0);
  signal B_mul_in_s : std_logic_vector(7 downto 0);

  signal O_s : std_logic_vector(15 downto 0);

  signal all_zeroes : std_logic_vector(7 downto 0);
  signal Mux_s      : std_logic_vector(15 downto 0);
  signal n_OP_CODE  : std_logic;
  signal d_OP_CODE  : std_logic;

begin

  ff_opcode : FLIPFLOP port map(clk, rst_n, OP_CODE, d_OP_CODE);

  Mux_s <= (all_zeroes & Adder_O) when d_OP_CODE = '1' else
    Multiplier_O;

  n_OP_CODE <= not(OP_CODE);

  all_zeroes <= (others => '0');

  O <= O_s;

  ff_sum_in_a : reg generic map(8) port map(clk, OP_CODE, rst_n, A, A_sum_in_s);
  ff_sum_in_b : reg generic map(8) port map(clk, OP_CODE, rst_n, B, B_sum_in_s);
  ff_mul_in_a : reg generic map(8) port map(clk, n_OP_CODE, rst_n, A, A_mul_in_s);
  ff_mul_in_b : reg generic map(8) port map(clk, n_OP_CODE, rst_n, B, B_mul_in_s);
  ff_out      : reg generic map(16) port map(clk, '1', rst_n, Mux_s, O_s);

  Multiplier_1 : Multiplier generic map(8) port map(A_mul_in_s, B_mul_in_s, Multiplier_O);
  Adder_1      : Adder generic map(8) port map(A_sum_in_s, B_sum_in_s, '0', Adder_O);

end structure;