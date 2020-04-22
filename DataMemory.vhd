library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DataMemory is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           INs : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUTs : out  STD_LOGIC_VECTOR (7 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

begin

	--Lecture, écriture et reset synchrones sur l'horloge
	process (clk)
		begin
			if clk'event and clk = '1' then
				-- Quand le signal RST est actif à '0', le contenu de la mémoire initialisé à 0x00.
				if RST = '0' then
					addr <= 0;
				else 
					-- LECTURE
					if RW = '1' then
						-- à compléter
					-- ECRITURE	- le contenu de INs est copié dans addr
					elsif RW = '0' then
						addr <= INs; 
						
					end if;
				end if;
			end if;	
		end process;


end Behavioral;



