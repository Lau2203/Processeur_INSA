library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.constants.ALL;

entity LC_EX is
	Port(
		OPCODE		: in	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
		
		ALU_CTRL	: out	std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0)
	);
end LC_EX;

architecture Behavioral of LC_EX is

begin

ALU_CTRL <=	CONSTANT_ALU_ADD	when OPCODE = CONSTANT_OP_ADD else
			CONSTANT_ALU_MUL	when OPCODE = CONSTANT_OP_MUL else
			CONSTANT_ALU_SUB	when OPCODE = CONSTANT_OP_SUB else
			CONSTANT_ALU_DIV	when OPCODE = CONSTANT_OP_DIV else
			CONSTANT_ALU_NONE;

end Behavioral;

