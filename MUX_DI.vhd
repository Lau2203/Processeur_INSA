library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

-- This MUX receives 3 inputs : OPCODE_IN, OPERAND_B_DIRECT_IN and OPERAND_B_REG_IN

-- The first of the OPERAND_* is a direct link to the initial instruction's operand value,
-- whereas the second operand is the value of that same operand value once processed
-- through the register file unit.

-- Basically, according to the value of the incoming OPCODE, it can choose to output
-- whether the direct initial instruction's operand value, or the register

-- This is handy when having different instructions sharing the same operand positions but with
-- different meanings for each of these operands (immediate value or memory address or register)

entity MUX_DI is
	
    Port (
			CLK						: in 	STD_LOGIC;

			OPCODE_IN				: in	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);		--< The opcode which will define whether we will choose the 
																																--   OPERAND_B_DIRECT_IN or OPERAND_B_REG_IN to output

			OPERAND_B_DIRECT_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The operand comming directly from the last pipeline
			OPERAND_B_REG_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);	--< The output of the register file

			OPERAND_B_OUT			: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0)		--> The chosen output, whether OPERAND_B_DIRECT_IN or OPERAND_B_REG_IN
	);
end MUX_DI;

architecture Behavioral of MUX_DI is

begin

	process (clk)
		begin
			if rising_edge(clk) then
			
				if OPCODE_IN = CONSTANT_OP_AFC then
					OPERAND_B_OUT <= OPERAND_B_DIRECT_IN;
					
				else
					OPERAND_B_OUT <= OPERAND_B_REG_IN;
				 
				end if;
			end if;
		end process;

end Behavioral;

