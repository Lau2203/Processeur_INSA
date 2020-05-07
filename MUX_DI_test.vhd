LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.constants.ALL;
 
ENTITY MUX_DI_test IS
END MUX_DI_test;
 
ARCHITECTURE behavior OF MUX_DI_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT MUX_DI
	PORT(
			OPCODE_IN : IN  std_logic_vector(7 downto 0);
			OPERAND_B_DIRECT_IN : IN  std_logic_vector(7 downto 0);
			OPERAND_B_REG_IN : IN  std_logic_vector(7 downto 0);
			OPERAND_B_OUT : OUT  std_logic_vector(7 downto 0)
	);
	END COMPONENT;
    

	--Inputs
	signal OPCODE_IN : std_logic_vector(7 downto 0) := (others => '0');
	signal OPERAND_B_DIRECT_IN : std_logic_vector(7 downto 0) := (others => '0');
	signal OPERAND_B_REG_IN : std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal OPERAND_B_OUT : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX_DI PORT MAP (
			OPCODE_IN => OPCODE_IN,
			OPERAND_B_DIRECT_IN => OPERAND_B_DIRECT_IN,
			OPERAND_B_REG_IN => OPERAND_B_REG_IN,
			OPERAND_B_OUT => OPERAND_B_OUT
        );
 
   tb: process
   begin

		-- TEST FOR AFC OPCODE
		OPCODE_IN				<= CONSTANT_OP_AFC;
		OPERAND_B_DIRECT_IN		<= "00000001";
		OPERAND_B_REG_IN		<= "00000011";
		wait for 100 ns;
		
		-- TEST FOR COP OPCODE
		OPCODE_IN				<= CONSTANT_OP_COP;
		OPERAND_B_DIRECT_IN		<= "00000001";
		OPERAND_B_REG_IN		<= "00000011";
		wait for 100 ns;
	
   end process;

END;
