library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DataMemory is
	generic (MEMORY_SIZE : Natural := 512);
    Port ( ADDR : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

signal MEMORY : STD_LOGIC_VECTOR(MEMORY_SIZE - 1 downto 0);

begin

	--Lecture, écriture et reset synchrones sur l'horloge
	process (clk)
		begin
			if clk'event and clk = '1' then
				-- Quand le signal RST est actif à '0', le contenu de la mémoire initialisé à 0x00.
				if RST = '0' then
					MEMORY <= others '0';
				else 
					-- READ
					if RW = '1' then
						OUTPUT <= MEMORY((to_integer(unsigned(addr)) * 8 - 1) downto (to_integer(unsigned(addr)) * 8));
					-- WRITE
					elsif RW = '0' then
						MEMORY((to_integer(unsigned(addr)) * 8 - 1) downto (to_integer(unsigned(addr)) * 8)) <= DATA;
					end if;
				end if;
			end if;	
		end process;


end Behavioral;

