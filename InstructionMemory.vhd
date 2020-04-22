library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity InsMemory is
	generic(
		instruction_memory_size : Natural := 128;
		instruction_size : Natural := 8;
		);
    Port ( ADDR : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end InsMemory;

architecture Behavioral of InsMemory is

signal INSTR_MEMORY : STD_LOGIC_VECTOR((instruction_memory_size * instruction_size - 1) downto 0);

begin

	process (clk)
		begin
			if clk'event and clk = '1' then
				OUTPUT <= INSTR_MEMORY((to_integer(unsigned(ADDR)) * instruction_size - 1) downto (to_integer(unsigned(ADDR)) * instruction_size));
			end if;
	end process;
	
	
end Behavioral;
