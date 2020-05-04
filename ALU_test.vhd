LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.constants.ALL;

ENTITY ALU_test IS
END ALU_test;
 
ARCHITECTURE behavior OF ALU_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         OPERAND_1 : IN  std_logic_vector(7 downto 0);
         OPERAND_2 : IN  std_logic_vector(7 downto 0);
         ALU_CTRL : IN  std_logic_vector(2 downto 0);
         RESULT : OUT  std_logic_vector(7 downto 0);
         NEG_FLAG : OUT  std_logic;
         OVF_FLAG : OUT  std_logic;
         ZER_FLAG : OUT  std_logic;
         CAR_FLAG : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal OPERAND_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal OPERAND_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal ALU_CTRL : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal RESULT : std_logic_vector(7 downto 0);
   signal NEG_FLAG : std_logic;
   signal OVF_FLAG : std_logic;
   signal ZER_FLAG : std_logic;
   signal CAR_FLAG : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          OPERAND_1 => OPERAND_1,
          OPERAND_2 => OPERAND_2,
          ALU_CTRL => ALU_CTRL,
          RESULT => RESULT,
          NEG_FLAG => NEG_FLAG,
          OVF_FLAG => OVF_FLAG,
          ZER_FLAG => ZER_FLAG,
          CAR_FLAG => CAR_FLAG
        );

   tb :
		process
		begin
			wait for 100 ns;
			
			-- Initialize
			OPERAND_1 	<= "00000001";
			OPERAND_2 	<= "00000010";
			
			ALU_CTRL		<= CONSTANT_ALU_ADD;
			wait for 100 ns;
			
			ALU_CTRL		<= CONSTANT_ALU_SUB;
			wait for 100 ns;
			
			ALU_CTRL		<= CONSTANT_ALU_MUL;
			wait for 100 ns;
			
			ALU_CTRL		<= CONSTANT_ALU_AND;
			wait for 100 ns;
			
			ALU_CTRL		<= CONSTANT_ALU_XOR;
			wait for 100 ns;
			
			ALU_CTRL		<= CONSTANT_ALU_OR;
			wait for 100 ns;
			
		end process;

END;
