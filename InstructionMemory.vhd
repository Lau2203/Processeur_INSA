library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity InstructionMemory is

    Port ( 
			CLK 	: in  	STD_LOGIC;	--< CLK
			ADDR 	: in  	STD_LOGIC_VECTOR (CONSTANT_INST_MEMORY_ADDR_SIZE - 1 downto 0);	--< The address of the instruction to be fetched
			OUTPUT 	: out  	STD_LOGIC_VECTOR (CONSTANT_INSTRUCTION_SIZE - 1 downto 0)		--> The very fetched instruction
	);
end InstructionMemory;

architecture Behavioral of InstructionMemory is

	type instr_mem_type is array (0 to CONSTANT_INST_MEMORY_SIZE - 1) of STD_LOGIC_VECTOR (CONSTANT_INSTRUCTION_SIZE - 1 downto 0);

	signal INSTR_MEMORY : instr_mem_type;
	
begin

	process (clk)
		begin
			if clk'event and clk = '1' then
				OUTPUT <= INSTR_MEMORY(to_integer(unsigned(ADDR)));
			end if;
	end process;
	
end Behavioral;
