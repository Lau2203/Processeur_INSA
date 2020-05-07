library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

-- This MUX receives 3 inputs : OPCODE_IN, OPERAND_B_DIRECT_IN and OPERAND_B_ALU_IN

-- The first of the OPERAND_* is a direct link to the previous pipeline,
-- whereas the second operand is the value of that same operand value once processed
-- through the ALU.

-- Basically, according to the value of the incoming OPCODE, it can choose to output
-- whether the direct previous pipeline's value, or ALU's result.

entity MUX_EX is
	
    Port (
			OPCODE_IN			: in	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);	--< The opcode which will define whether we will choose the 
																																--   OPERAND_B_DIRECT_IN or OPERAND_B_ALU_IN to output

			OPERAND_B_DIRECT_IN	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The operand comming directly from the last pipeline
			OPERAND_B_ALU_IN	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The output of the ALU

			OPERAND_B_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0)	--> The chosen output, whether OPERAND_B_DIRECT_IN or OPERAND_B_ALU_IN
	);
end MUX_EX;

architecture Behavioral of MUX_EX is

begin

-- Only arithmetic and logic opcodes needs the ALU's result

OPERAND_B_OUT <= 	OPERAND_B_ALU_IN when 	OPCODE_IN = CONSTANT_OP_ADD or
											OPCODE_IN = CONSTANT_OP_MUL or
											OPCODE_IN = CONSTANT_OP_SUB or
											OPCODE_IN = CONSTANT_OP_DIV
											else
					OPERAND_B_DIRECT_IN;				



end Behavioral;

