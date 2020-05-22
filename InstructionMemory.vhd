library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity InstructionMemory is

    Port ( 
			CLK 	: in  	STD_LOGIC;	--< CLK
			EN		: in 	STD_LOGIC;	--< Enable
			ADDR 	: in  	STD_LOGIC_VECTOR (CONSTANT_INST_MEMORY_ADDR_SIZE - 1 downto 0);	--< The address of the instruction to be fetched
			OUTPUT 	: out  	STD_LOGIC_VECTOR (CONSTANT_INSTRUCTION_SIZE - 1 downto 0)		--> The very fetched instruction
	);
end InstructionMemory;

architecture Behavioral of InstructionMemory is

	type instr_mem_type is array (0 to CONSTANT_INST_MEMORY_SIZE - 1) of STD_LOGIC_VECTOR (CONSTANT_INSTRUCTION_SIZE - 1 downto 0);

	signal INSTR_MEMORY : instr_mem_type;
	
	signal current_instruction : std_logic_vector (CONSTANT_INSTRUCTION_SIZE - 1 downto 0) := (others => '0');
	
begin
	-- Test sample
	INSTR_MEMORY	<= (
						CONSTANT_OP_AFC & x"05" & x"06" & x"09",	-- r5 = 0x6;
						CONSTANT_OP_AFC & x"09" & x"04" & x"09",	-- r9 = 0x4;
						
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
						
						CONSTANT_OP_MUL & x"06" & x"05" & x"09",	-- r6 = r5 * r9;
						
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
						
						CONSTANT_OP_STORE & x"08" & x"06" & x"09",	-- [@0x8] = r6;
						
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
						
						CONSTANT_OP_LOAD & x"01" & x"08" & x"09",	-- r1 = [@0x8];
						
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
--						CONSTANT_OP_NOP & x"09" & x"04" & x"09",
						
						CONSTANT_OP_COP & x"07" & x"01" & x"09",	-- r7 = r1;
						
						others => (others => '0')
						);

	process (clk)
		begin
			if falling_edge(clk) then
			
				if EN = '1' then
					OUTPUT <= INSTR_MEMORY(to_integer(unsigned(ADDR)));
					current_instruction <= INSTR_MEMORY(to_integer(unsigned(ADDR)));
				else
					OUTPUT <= current_instruction;
				end if;
			end if;
	end process;
	
end Behavioral;
