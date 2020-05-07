library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

-- This MUX receives 3 inputs : OPCODE_IN, OPERAND_B_DIRECT_IN and OPERAND_B_MEM_IN

-- The first of the OPERAND_* is a direct link to the previous pipeline,
-- whereas the second operand is the value of that same operand value once processed
-- through the Memory unit.

-- Basically, according to the value of the incoming OPCODE, it can choose to output
-- whether the direct previous pipeline's value, or memory unit's result.

entity MUX_RE is
	
    Port (
			OPCODE_IN			: in	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);	--< The opcode which will define whether we will choose the 
																																--   OPERAND_B_DIRECT_IN or OPERAND_B_MEM_IN to output

			OPERAND_B_DIRECT_IN	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The operand comming directly from the last pipeline
			OPERAND_B_MEM_IN	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The output of the memory unit

			OPERAND_B_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0)	--> The chosen output, whether OPERAND_B_DIRECT_IN or OPERAND_B_MEM_IN
	);
end MUX_RE;

architecture Behavioral of MUX_RE is

begin

-- LOAD and STORE are the only two instructions that need a memory
-- address as one of their operand. However, the LOAD instruction is
-- probably the only one that would need to retrieve the result of the
-- the memory unit since it is a reading operation. Anyway, we assign
-- the memory unit for the STORE too, cannot do any harm.
OPERAND_B_OUT <=	OPERAND_B_MEM_IN when (OPCODE_IN = CONSTANT_OP_LOAD or OPCODE_IN = CONSTANT_OP_STORE) else
					OPERAND_B_DIRECT_IN;


end Behavioral;

