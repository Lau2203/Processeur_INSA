library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

-- This MUX receives 3 inputs : OPCODE, OPERAND_A and OPERAND_B

-- OPERAND_A and OPERAND_B are a direct link to the previous pipeline
-- .

-- Basically, according to the value of the incoming OPCODE, it can choose to output
-- whether the direct previous pipeline's value, or memory unit's result.

entity MUX_MEM is
	
    Port (
			CLK			: in 	STD_LOGIC;

			OPCODE		: in	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);	--< The opcode which will define whether we will choose the 
																						--   OPERAND_A or OPERAND_B to output

			OPERAND_A	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The first operand
			OPERAND_B	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The second operand

			OPERAND_OUT	: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0)	--> The chosen output, whether OPERAND_A or OPERAND_B
	);
end MUX_MEM;

architecture Behavioral of MUX_MEM is

begin

	process (clk)
		begin
			if rising_edge(clk) then
				-- Only the STORE opcode requires its first operand to be an address
				if	OPCODE = CONSTANT_OP_STORE then
					OPERAND_OUT <= OPERAND_A;
					
				-- CAREFUL ---
				
				-- Actually, the only other opcode that needs the B operand to be an address
				-- is the LOAD opcode, but since there is another MUX right after the memory
				-- we can do that 'else' process for every other instructions opcode
				-- CAREFUL though when adding new instructions
				else
					OPERAND_OUT <= OPERAND_B;
				 
				end if;
			end if;
		end process;

end Behavioral;

