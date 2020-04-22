library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity InsMemory is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           OUTs : out  STD_LOGIC_VECTOR (7 downto 0));
end InsMemory;

architecture Behavioral of InsMemory is

begin

	process (clk)
		begin
			if clk'event and clk = '1' then
			
			
			end if;
	end process;
	
	
end Behavioral;
