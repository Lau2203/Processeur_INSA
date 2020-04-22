library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port ( W : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           aA : in  STD_LOGIC_VECTOR (3 downto 0);
           aB : in  STD_LOGIC_VECTOR (3 downto 0);
           aW : in  STD_LOGIC_VECTOR (3 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

	signal --à compléter;

begin
	
	-- LECTURE ASYNCHRONE
	-- Si écriture et lecture sur le même registre, alors QA ou QB <= DATA 
	-- Sinon (else) on va procéder à une lecture simple 
	QA <= DATA when ((W='1') and (aA = aW) and (RST='1')) 
		        else --à compléter signal prend aA?
	QB <= DATA when ((W='1') and (aB = aW) and (RST='1')) 
	           else --à compléter signal prend aB?

	-- ECRITURE SYNCHRONE
	process (clk) 
	begin
		if clk'event and clk = '1' then
			-- Quand le signal RST est actif à '0', le contenu du BR est initialisé à 0x00.
			if RST = '0' then
				-- à compléter BR est mis à 0
			else -- Ecriture simple
				if W = '1' then
					-- à compléter aW prend Data
				end if;
			end if;
		end if;	
	end process;
	

end Behavioral;

