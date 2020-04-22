
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registers is
    Port ( W : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           aA : in  STD_LOGIC_VECTOR (3 downto 0);
           aB : in  STD_LOGIC_VECTOR (3 downto 0);
           aW : in  STD_LOGIC_VECTOR (3 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end registers;

architecture Behavioral of registers is

	signal --à compléter;

begin
	

	-- LECTURE ASYNCHRONE
	-- Si écriture et lecture sur le même registre, alors QA ou QB <= DATA 
	-- Sinon (else) on va procéder à une lecture simple 
	QA <= DATA when ((W='1') and (aA = aW) and (RST='1')) 
		        else --à compléter
	QB <= DATA when ((W='1') and (aB = aW) and (RST='1')) 
	           else --à compléter

	-- ECRITURE SYNCHRONE
	process (Ck)
	begin
		wait until Ck'event and Ck='1';
		-- Quand le signal RST est actif à '0', le contenu du BR est initialisé à 0x00.
		if RST = '0' then
			-- à compléter
		else -- Ecriture simple
			if W = '1' then
				-- à compléter
			end if;
		end if;
	end process;
	

end Behavioral;

