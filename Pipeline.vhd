library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity Pipeline is
    Port (
				CLK					: in 	STD_LOGIC;
				RST					: in	STD_LOGIC;
				
				OPERAND_A_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				OPCODE_IN			: in	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);
				
				OPERAND_B_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				OPERAND_C_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				
				
				OPERAND_A_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				OPCODE_OUT			: out	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);
				
				OPERAND_B_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				OPERAND_C_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0)
			);
end Pipeline;

architecture Behavioral of Pipeline is

begin

	process (clk)
		begin
			if rising_edge(clk) then
			
				if RST = '0' then
					OPERAND_A_OUT 	<= (others => '0');
					OPCODE_OUT 		<= (others => '0');
					OPERAND_B_OUT 	<= (others => '0');
					OPERAND_C_OUT 	<= (others => '0');
					
				else
					OPERAND_A_OUT	<= OPERAND_A_IN;
					OPCODE_OUT		<= OPCODE_IN;
					OPERAND_B_OUT	<= OPERAND_B_IN;
					OPERAND_C_OUT	<= OPERAND_C_IN;
					
				end if;
			end if;
		end process;

end Behavioral;

