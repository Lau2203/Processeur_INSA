LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY InstructionMemory_test IS
END InstructionMemory_test;
 
ARCHITECTURE behavior OF InstructionMemory_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionMemory
    PORT(
         CLK : IN  std_logic;
         ADDR : IN  std_logic_vector(7 downto 0);
         OUTPUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal ADDR : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal OUTPUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionMemory PORT MAP (
          CLK => CLK,
          ADDR => ADDR,
          OUTPUT => OUTPUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

   tb: process
   begin
		wait for 100 ns;
		
      -- TEST READ MEMORY AT ADDRESS "000000001"
		-- if the instruction memory is not initialized, it is
		-- normal to get an OUTPUT value of all 'U's
		ADDR	<= "00000001";
		wait for 100 ns;
   end process;

END;
