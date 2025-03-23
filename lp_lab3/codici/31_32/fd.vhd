library IEEE;
use IEEE.std_logic_1164.all;

entity FD is
	port (
		D     : in std_logic;
		CK    : in std_logic;
		RESET : in std_logic;
		Q     : out std_logic);
end FD;

architecture PIPPO of FD is -- flip flop D con reset SINCRONO

begin
	PSYNCH : process (CK, RESET)
	begin
		if CK'event and CK = '1' then -- positive edge triggered:
			if RESET = '1' then           -- reset sincrono attivo alto
				Q <= '0';
			else
				Q <= D after 0.1 ps; -- copia l'ingresso sull'uscita
			end if;
		end if;
	end process;

end PIPPO;

architecture PLUTO of FD is -- flip flop D con reset ASINCRONO

begin

	PASYNCH : process (CK, RESET)
	begin
		if RESET = '1' then -- reset asincrono attivo alto
			Q <= '0';
		elsif CK'event and CK = '1' then -- positive edge triggered:
			Q <= D after 0.1 ps;             -- copia l'ingresso sull'uscita
		end if;
	end process;

end PLUTO;

configuration CFG_FD_PIPPO of FD is
	for PIPPO
	end for;
end CFG_FD_PIPPO;
configuration CFG_FD_PLUTO of FD is
	for PLUTO
	end for;
end CFG_FD_PLUTO;