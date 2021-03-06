library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.constants.ALL;

entity Decoder is
	Port (
		INSTRUCTION	: in	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		
		OPERAND_A	: out	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
		OPCODE		: out	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
		OPERAND_B	: out	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
		OPERAND_C	: out	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0)
	);
end Decoder;

architecture Behavioral of Decoder is

begin

OPERAND_A	<= INSTRUCTION(CONSTANT_INSTRUCTION_OPERAND_A_POSITION + CONSTANT_OPERAND_SIZE - 1 downto CONSTANT_INSTRUCTION_OPERAND_A_POSITION);

OPCODE		<= INSTRUCTION(CONSTANT_INSTRUCTION_OPCODE_POSITION + CONSTANT_OPCODE_SIZE - 1 downto CONSTANT_INSTRUCTION_OPCODE_POSITION);

OPERAND_B	<= INSTRUCTION(CONSTANT_INSTRUCTION_OPERAND_B_POSITION + CONSTANT_OPERAND_SIZE - 1 downto CONSTANT_INSTRUCTION_OPERAND_B_POSITION);

OPERAND_C	<= INSTRUCTION(CONSTANT_INSTRUCTION_OPERAND_C_POSITION + CONSTANT_OPERAND_SIZE - 1 downto CONSTANT_INSTRUCTION_OPERAND_C_POSITION);

end Behavioral;

