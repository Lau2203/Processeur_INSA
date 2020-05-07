library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.constants.ALL;

entity LC_MEM is
	Port(
		OPCODE	: in	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
		
		RW		: out	std_logic
	);
end LC_MEM;

architecture Behavioral of LC_MEM is

begin

RW	<= 	CONSTANT_DATA_MEMORY_WRITE_FLAG when OPCODE = CONSTANT_OP_STORE else
		CONSTANT_DATA_MEMORY_READ_FLAG; -- when OPCODE = CONSTANT_OP_LOAD

end Behavioral;

