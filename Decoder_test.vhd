LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

LIBRARY work;
USE work.constants.ALL;
 
ENTITY Decoder_test IS
END Decoder_test;
 
ARCHITECTURE behavior OF Decoder_test IS 
 
	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT Decoder
	PORT(
			INSTRUCTION	: IN  std_logic_vector(31 downto 0);
			OPERAND_A	: OUT  std_logic_vector(7 downto 0);
			OPCODE		: OUT  std_logic_vector(7 downto 0);
			OPERAND_B	: OUT  std_logic_vector(7 downto 0);
			OPERAND_C	: OUT  std_logic_vector(7 downto 0)
	);
	END COMPONENT;
    

   --Inputs
   signal INSTRUCTION : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal OPERAND_A : std_logic_vector(7 downto 0);
   signal OPCODE : std_logic_vector(7 downto 0);
   signal OPERAND_B : std_logic_vector(7 downto 0);
   signal OPERAND_C : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: Decoder PORT MAP (
			INSTRUCTION	=> INSTRUCTION,
			
			OPERAND_A	=> OPERAND_A,
			OPCODE 		=> OPCODE,
			OPERAND_B 	=> OPERAND_B,
			OPERAND_C	=> OPERAND_C
	);
 

	-- Stimulus process
	tb: process
	begin
		wait for 100 ns;	

		INSTRUCTION	<= x"09" & x"0f" & x"05" & CONSTANT_OP_ADD;
		
		wait for 100 ns;	

		INSTRUCTION	<= x"09" & x"0f" & x"05" & CONSTANT_OP_LOAD;
		
		wait for 100 ns;	

	  wait;
	end process;

END;
