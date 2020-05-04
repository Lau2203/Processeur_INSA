library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainProcessor is
	port (
		MainProcessor_CLK		: in std_logic;
		MainProcessor_OUTPUT	: out	std_logic
	);
end MainProcessor;

architecture Behavioral of MainProcessor is

	signal GLOBAL_RST	: std_logic := '1';

	------------------------------------------------
	------					CLOCK						------
	------------------------------------------------
	
   signal GLOBAL_CLK : std_logic := '0';
	-- Clock period definitions
   constant CLK_period : time := 10 ns;

	------------------------------------------------
	------			InstructionMemory				------
	------------------------------------------------
	COMPONENT InstructionMemory
		PORT(
				CLK 		: IN  std_logic;
				ADDR 		: IN  std_logic_vector(7 downto 0);
				
				OUTPUT 	: OUT  std_logic_vector(31 downto 0)
			  );
   END COMPONENT;
    

   -- Inputs
	signal InstructionMemory_CLK 	: std_logic := '0';
   signal InstructionMemory_ADDR : std_logic_vector(7 downto 0) := (others => '0');

 	-- Outputs
   signal InstructionMemory_OUTPUT : std_logic_vector(31 downto 0);
	
	
	------------------------------------------------
	------					ALU						------
	------------------------------------------------
	COMPONENT ALU
    PORT(
         OPERAND_1	: IN  std_logic_vector(7 downto 0);
         OPERAND_2 	: IN  std_logic_vector(7 downto 0);
         ALU_CTRL 	: IN  std_logic_vector(2 downto 0);
			
         RESULT 	: OUT  std_logic_vector(7 downto 0);
         NEG_FLAG : OUT  std_logic;
         OVF_FLAG : OUT  std_logic;
         ZER_FLAG : OUT  std_logic;
         CAR_FLAG : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ALU_OPERAND_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal ALU_OPERAND_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal ALU_ALU_CTRL 	: std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal ALU_RESULT : std_logic_vector(7 downto 0);
   signal ALU_NEG_FLAG : std_logic;
   signal ALU_OVF_FLAG : std_logic;
   signal ALU_ZER_FLAG : std_logic;
   signal ALU_CAR_FLAG : std_logic;


	------------------------------------------------
	------				DataMemory					------
	------------------------------------------------
	COMPONENT DataMemory
    PORT(
         ADDR		: IN  std_logic_vector(7 downto 0);
         DATA 		: IN  std_logic_vector(7 downto 0);
         RW 		: IN  std_logic;
         RST 		: IN  std_logic;
         CLK 		: IN  std_logic;
         OUTPUT	: OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataMemory_ADDR 		: std_logic_vector(7 downto 0) := (others => '0');
   signal DataMemory_DATA 		: std_logic_vector(7 downto 0) := (others => '0');
   signal DataMemory_RW 		: std_logic := '0';
   signal DataMemory_RST 		: std_logic := '0';
   signal DataMemory_CLK 		: std_logic := '0';

 	--Outputs
   signal DataMemory_OUTPUT 	: std_logic_vector(7 downto 0);
	
	
	
	------------------------------------------------
	------					MUX_DI					------
	------------------------------------------------
	COMPONENT MUX_DI
    PORT(
         CLK 						: IN  std_logic;
         OPCODE_IN 				: IN  std_logic_vector(7 downto 0);
         OPERAND_B_DIRECT_IN 	: IN  std_logic_vector(7 downto 0);
         OPERAND_B_REG_IN 		: IN  std_logic_vector(7 downto 0);
			
         OPERAND_B_OUT 			: OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal MUX_DI_CLK 						: std_logic := '0';
   signal MUX_DI_OPCODE_IN 				: std_logic_vector(7 downto 0) := (others => '0');
   signal MUX_DI_OPERAND_B_DIRECT_IN 	: std_logic_vector(7 downto 0) := (others => '0');
   signal MUX_DI_OPERAND_B_REG_IN 		: std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal MUX_DI_OPERAND_B_OUT 			: std_logic_vector(7 downto 0);
   

begin
	------------------------------------------------
	------					Creation					------
	------------------------------------------------
	instruction_memory_object: InstructionMemory PORT MAP (
          CLK 		=> InstructionMemory_CLK,
          ADDR 	=> InstructionMemory_ADDR,
			 
          OUTPUT 	=> InstructionMemory_OUTPUT
        );
		  
	alu_object: ALU PORT MAP (
          OPERAND_1 	=> ALU_OPERAND_1,
          OPERAND_2 	=> ALU_OPERAND_2,
          ALU_CTRL 	=> ALU_ALU_CTRL,
			 
          RESULT 		=> ALU_RESULT,
          NEG_FLAG 	=> ALU_NEG_FLAG,
          OVF_FLAG 	=> ALU_OVF_FLAG,
          ZER_FLAG 	=> ALU_ZER_FLAG,
          CAR_FLAG 	=> ALU_CAR_FLAG
        );
		  
	data_memory_object: DataMemory PORT MAP (
          ADDR		=> DataMemory_ADDR,
          DATA		=> DataMemory_DATA,
          RW 		=> DataMemory_RW,
          RST 		=> DataMemory_RST,
          CLK 		=> DataMemory_CLK,
			 
          OUTPUT	=> DataMemory_OUTPUT
        );
		  
	mux_di_object: MUX_DI PORT MAP (
          CLK 						=> MUX_DI_CLK,
          OPCODE_IN 				=> MUX_DI_OPCODE_IN,
          OPERAND_B_DIRECT_IN => MUX_DI_OPERAND_B_DIRECT_IN,
          OPERAND_B_REG_IN 	=> MUX_DI_OPERAND_B_REG_IN,
			 
          OPERAND_B_OUT 		=> MUX_DI_OPERAND_B_OUT
        );
		  
		  
	------------------------------------------------
	------				Processing					------
	------------------------------------------------
	-- Synchronize all the RST's
	DataMemory_RST	<= GLOBAL_RST;
	-- Synchronize all CLK's
	InstructionMemory_CLK	<= GLOBAL_CLK;
	DataMemory_CLK				<= GLOBAL_CLK;
	MUX_DI_CLK					<= GLOBAL_CLK;
	
	
	
	
	-- If we don't process anything the compiler throws an error, so
	-- leave that here for the moment
	MainProcessor_OUTPUT <= '0' when MainProcessor_CLK = '0' else
									'1';

end Behavioral;

