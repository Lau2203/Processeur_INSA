library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.constants.ALL;

entity LC_RE is
	Port(
		OPCODE		: in	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
		
		WRITE_REQ	: out	std_logic
	);
end LC_RE;

architecture Behavioral of LC_RE is

begin

WRITE_REQ	<= 	CONSTANT_REG_WRITE_FLAG_OFF when (OPCODE = CONSTANT_OP_STORE or OPCODE = CONSTANT_OP_NOP) else
				CONSTANT_REG_WRITE_FLAG_ON;
				

end Behavioral;

