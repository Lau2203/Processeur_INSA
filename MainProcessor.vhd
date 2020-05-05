library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.constants.ALL;

entity MainProcessor is
	port (
		MainProcessor_CLK		: in 	std_logic;
		MainProcessor_OUTPUT	: out	std_logic
	);
end MainProcessor;

architecture Behavioral of MainProcessor is

	signal GLOBAL_RST	: std_logic := '1';

	------------------------------------------
	------				CLOCK			------
	------------------------------------------
	signal GLOBAL_CLK : std_logic := '0';
	-- Clock period definitions
	constant CLK_period : time := 10 ns;
	
	
	------------------------------------------
	------				Pipeline		------
	------------------------------------------
	COMPONENT Pipeline
		PORT(
				CLK				: in 	STD_LOGIC;
				RST				: in	STD_LOGIC;
				
				OPERAND_A_IN	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				OPCODE_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);
				
				OPERAND_B_IN	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				OPERAND_C_IN	: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				
				
				OPERAND_A_OUT	: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				OPCODE_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);
				
				OPERAND_B_OUT	: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				OPERAND_C_OUT	: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0)
	);
	END COMPONENT;
    
	------------------------------------------
	------			Pipeline LI/DI		------
	------------------------------------------
	-- Inputs
	signal Pipeline_LI_DI_CLK			: STD_LOGIC := '0';
	signal Pipeline_LI_DI_RST			: STD_LOGIC := '0';	
	signal Pipeline_LI_DI_OPERAND_A_IN	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_LI_DI_OPCODE_IN		: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_LI_DI_OPERAND_B_IN	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_LI_DI_OPERAND_C_IN	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

 	-- Outputs
	signal Pipeline_LI_DI_OPERAND_A_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_LI_DI_OPCODE_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_LI_DI_OPERAND_B_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_LI_DI_OPERAND_C_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

	------------------------------------------
	------			Pipeline DI/EX		------
	------------------------------------------
	-- Inputs
	signal Pipeline_DI_EX_CLK			: STD_LOGIC := '0';
	signal Pipeline_DI_EX_RST			: STD_LOGIC := '0';	
	signal Pipeline_DI_EX_OPERAND_A_IN	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_DI_EX_OPCODE_IN		: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_DI_EX_OPERAND_B_IN	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_DI_EX_OPERAND_C_IN	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

 	-- Outputs
	signal Pipeline_DI_EX_OPERAND_A_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_DI_EX_OPCODE_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_DI_EX_OPERAND_B_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_DI_EX_OPERAND_C_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');


	------------------------------------------
	------			Pipeline EX/MEM		------
	------------------------------------------
	-- Inputs
	signal Pipeline_EX_MEM_CLK				: STD_LOGIC := '0';
	signal Pipeline_EX_MEM_RST				: STD_LOGIC := '0';	
	signal Pipeline_EX_MEM_OPERAND_A_IN		: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_EX_MEM_OPCODE_IN		: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_EX_MEM_OPERAND_B_IN		: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_EX_MEM_OPERAND_C_IN		: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

 	-- Outputs
	signal Pipeline_EX_MEM_OPERAND_A_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_EX_MEM_OPCODE_OUT		: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_EX_MEM_OPERAND_B_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	
	------------------------------------------
	------			Pipeline MEM/RE		------
	------------------------------------------
	-- Inputs
	signal Pipeline_MEM_RE_CLK				: STD_LOGIC := '0';
	signal Pipeline_MEM_RE_RST				: STD_LOGIC := '0';	
	signal Pipeline_MEM_RE_OPERAND_A_IN		: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_MEM_RE_OPCODE_IN		: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
				
	signal Pipeline_MEM_RE_OPERAND_B_IN		: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_MEM_RE_OPERAND_C_IN		: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

 	-- Outputs
	signal Pipeline_MEM_RE_OPERAND_A_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_MEM_RE_OPCODE_OUT		: STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal Pipeline_MEM_RE_OPERAND_B_OUT	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	


	------------------------------------------
	------		InstructionMemory		------
	------------------------------------------
	COMPONENT InstructionMemory
		PORT(
				CLK 	: IN	std_logic;
				ADDR 	: IN	std_logic_vector(7 downto 0);
				
				OUTPUT 	: OUT	std_logic_vector(31 downto 0)
			  );
   END COMPONENT;
    

	-- Inputs
	signal InstructionMemory_CLK 	: std_logic := '0';
	signal InstructionMemory_ADDR	: std_logic_vector(7 downto 0) := (others => '0');

 	-- Outputs
	signal InstructionMemory_OUTPUT : std_logic_vector(31 downto 0);
	
	
	------------------------------------------
	------			RegisterFile		------
	------------------------------------------
	COMPONENT RegisterFile
	PORT(
			RST 			: IN  std_logic;
			CLK 			: IN  std_logic;
			READ_REG_ADDR_A : IN  std_logic_vector(3 downto 0);
			READ_REG_ADDR_B	: IN  std_logic_vector(3 downto 0);
			QA 				: OUT  std_logic_vector(7 downto 0);
			QB 				: OUT  std_logic_vector(7 downto 0);
			WRITE_REQ 		: IN  std_logic;
			WRITE_REG_ADDR	: IN  std_logic_vector(3 downto 0);
			DATA 			: IN  std_logic_vector(7 downto 0)
		);
	END COMPONENT;
    

	--Inputs
	signal RegisterFile_RST 			: std_logic := '0';
	signal RegisterFile_CLK 			: std_logic := '0';
	signal RegisterFile_READ_REG_ADDR_A : std_logic_vector(3 downto 0) := (others => '0');
	signal RegisterFile_READ_REG_ADDR_B : std_logic_vector(3 downto 0) := (others => '0');
	signal RegisterFile_WRITE_REQ 		: std_logic := '0';
	signal RegisterFile_WRITE_REG_ADDR 	: std_logic_vector(3 downto 0) := (others => '0');
	signal RegisterFile_DATA 			: std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal RegisterFile_QA : std_logic_vector(7 downto 0);
	signal RegisterFile_QB : std_logic_vector(7 downto 0);
	
	
	------------------------------------------
	------				MUX_DI			------
	------------------------------------------
	COMPONENT MUX_DI
	PORT(
			CLK 					: IN	std_logic;
			OPCODE_IN 				: IN	std_logic_vector(7 downto 0);
			OPERAND_B_DIRECT_IN 	: IN	std_logic_vector(7 downto 0);
			OPERAND_B_REG_IN 		: IN	std_logic_vector(7 downto 0);

			OPERAND_B_OUT 			: OUT	std_logic_vector(7 downto 0)
		);
	END COMPONENT;


	--Inputs
	signal MUX_DI_CLK					: std_logic := '0';
	signal MUX_DI_OPCODE_IN 				: std_logic_vector(7 downto 0) := (others => '0');
	signal MUX_DI_OPERAND_B_DIRECT_IN 	: std_logic_vector(7 downto 0) := (others => '0');
	signal MUX_DI_OPERAND_B_REG_IN 		: std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal MUX_DI_OPERAND_B_OUT 			: std_logic_vector(7 downto 0);
	
	
	------------------------------------------
	------				ALU				------
	------------------------------------------
	COMPONENT ALU
    PORT(
         OPERAND_1	: IN	std_logic_vector(7 downto 0);
         OPERAND_2 	: IN	std_logic_vector(7 downto 0);
         ALU_CTRL 	: IN 	std_logic_vector(2 downto 0);
			
         RESULT 	: OUT	std_logic_vector(7 downto 0);
         NEG_FLAG 	: OUT	std_logic;
         OVF_FLAG 	: OUT	std_logic;
         ZER_FLAG 	: OUT	std_logic;
         CAR_FLAG 	: OUT	std_logic
        );
    END COMPONENT;
    

	--Inputs
	signal ALU_OPERAND_1 	: std_logic_vector(7 downto 0) 	:= (others => '0');
	signal ALU_OPERAND_2 	: std_logic_vector(7 downto 0) 	:= (others => '0');
	signal ALU_ALU_CTRL 	: std_logic_vector(2 downto 0) 	:= (others => '0');

 	--Outputs
	signal ALU_RESULT	: std_logic_vector(7 downto 0);
	signal ALU_NEG_FLAG : std_logic;
	signal ALU_OVF_FLAG : std_logic;
	signal ALU_ZER_FLAG : std_logic;
	signal ALU_CAR_FLAG : std_logic;


	------------------------------------------
	------				MUX_MEM			------
	------------------------------------------
	COMPONENT MUX_MEM
	PORT(
			CLK 		: IN	std_logic;
			OPCODE 		: IN	std_logic_vector(7 downto 0);
			OPERAND_A 	: IN	std_logic_vector(7 downto 0);
			OPERAND_B 	: IN	std_logic_vector(7 downto 0);

			OPERAND_OUT : OUT	std_logic_vector(7 downto 0)
	);
	END COMPONENT;


	--Inputs
	signal MUX_MEM_CLK			: std_logic := '0';
	signal MUX_MEM_OPCODE 		: std_logic_vector(7 downto 0) := (others => '0');
	signal MUX_MEM_OPERAND_A 	: std_logic_vector(7 downto 0) := (others => '0');
	signal MUX_MEM_OPERAND_B 	: std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal MUX_MEM_OPERAND_OUT 	: std_logic_vector(7 downto 0);

	------------------------------------------
	------				LC_MEM			------
	------------------------------------------
	COMPONENT LC_MEM
		PORT(
				OPCODE 	: IN	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);

				RW 		: OUT	std_logic
			  );
	END COMPONENT;
    

	-- Inputs
	signal LC_MEM_OPCODE	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');

 	-- Outputs
	signal LC_MEM_RW		: std_logic := CONSTANT_DATA_MEMORY_READ_FLAG;

	------------------------------------------
	------			DataMemory			------
	------------------------------------------
	COMPONENT DataMemory
    PORT(
         ADDR		: IN	std_logic_vector(7 downto 0);
         DATA 		: IN	std_logic_vector(7 downto 0);
         RW 		: IN	std_logic;
         RST 		: IN	std_logic;
         CLK 		: IN	std_logic;
		 
         OUTPUT		: OUT	std_logic_vector(7 downto 0)
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



	
   
   
	
   

begin
	------------------------------------------
	------			Creation			------
	------------------------------------------
	
	pipeline_li_di_object: Pipeline PORT MAP(
			CLK				=> Pipeline_LI_DI_CLK,
			RST				=> Pipeline_LI_DI_RST,
		
			OPERAND_A_IN	=> Pipeline_LI_DI_OPERAND_A_IN,
			OPCODE_IN		=> Pipeline_LI_DI_OPCODE_IN,
			OPERAND_B_IN	=> Pipeline_LI_DI_OPERAND_B_IN,
			OPERAND_C_IN	=> Pipeline_LI_DI_OPERAND_C_IN,

			OPERAND_A_OUT	=> Pipeline_LI_DI_OPERAND_A_OUT,
			OPCODE_OUT		=> Pipeline_LI_DI_OPCODE_OUT,
			OPERAND_B_OUT	=> Pipeline_LI_DI_OPERAND_B_OUT,
			OPERAND_C_OUT	=> Pipeline_LI_DI_OPERAND_C_OUT
	);
	
	pipeline_di_ex_object: Pipeline PORT MAP(
			CLK				=> Pipeline_DI_EX_CLK,
			RST				=> Pipeline_DI_EX_RST,
		
			OPERAND_A_IN	=> Pipeline_DI_EX_OPERAND_A_IN,
			OPCODE_IN		=> Pipeline_DI_EX_OPCODE_IN,
			OPERAND_B_IN	=> Pipeline_DI_EX_OPERAND_B_IN,
			OPERAND_C_IN	=> Pipeline_DI_EX_OPERAND_C_IN,

			OPERAND_A_OUT	=> Pipeline_DI_EX_OPERAND_A_OUT,
			OPCODE_OUT		=> Pipeline_DI_EX_OPCODE_OUT,
			OPERAND_B_OUT	=> Pipeline_DI_EX_OPERAND_B_OUT,
			OPERAND_C_OUT	=> Pipeline_DI_EX_OPERAND_C_OUT
	);
	
	pipeline_ex_mem_object: Pipeline PORT MAP(
			CLK				=> Pipeline_EX_MEM_CLK,
			RST				=> Pipeline_EX_MEM_RST,
		
			OPERAND_A_IN	=> Pipeline_EX_MEM_OPERAND_A_IN,
			OPCODE_IN		=> Pipeline_EX_MEM_OPCODE_IN,
			OPERAND_B_IN	=> Pipeline_EX_MEM_OPERAND_B_IN,
			OPERAND_C_IN	=> Pipeline_EX_MEM_OPERAND_C_IN,

			OPERAND_A_OUT	=> Pipeline_EX_MEM_OPERAND_A_OUT,
			OPCODE_OUT		=> Pipeline_EX_MEM_OPCODE_OUT,
			OPERAND_B_OUT	=> Pipeline_EX_MEM_OPERAND_B_OUT
	);
	
	pipeline_mem_re_object: Pipeline PORT MAP(
			CLK				=> Pipeline_MEM_RE_CLK,
			RST				=> Pipeline_MEM_RE_RST,
		
			OPERAND_A_IN	=> Pipeline_MEM_RE_OPERAND_A_IN,
			OPCODE_IN		=> Pipeline_MEM_RE_OPCODE_IN,
			OPERAND_B_IN	=> Pipeline_MEM_RE_OPERAND_B_IN,
			OPERAND_C_IN	=> Pipeline_MEM_RE_OPERAND_C_IN,

			OPERAND_A_OUT	=> Pipeline_MEM_RE_OPERAND_A_OUT,
			OPCODE_OUT		=> Pipeline_MEM_RE_OPCODE_OUT,
			OPERAND_B_OUT	=> Pipeline_MEM_RE_OPERAND_B_OUT
	);
	
	instruction_memory_object: InstructionMemory PORT MAP (
			CLK		=> InstructionMemory_CLK,
			ADDR	=> InstructionMemory_ADDR,
			 
			OUTPUT	=> InstructionMemory_OUTPUT
    );
		
		
		
	register_file_object: RegisterFile PORT MAP (
			RST 			=> RegisterFile_RST,
			CLK 			=> RegisterFile_CLK,
			READ_REG_ADDR_A => RegisterFile_READ_REG_ADDR_A,
			READ_REG_ADDR_B => RegisterFile_READ_REG_ADDR_B,
			QA 				=> RegisterFile_QA,
			QB 				=> RegisterFile_QB,
			WRITE_REQ 		=> RegisterFile_WRITE_REQ,
			WRITE_REG_ADDR	=> RegisterFile_WRITE_REG_ADDR,
			DATA 			=> RegisterFile_DATA
	);
		
		  
	mux_di_object: MUX_DI PORT MAP (
			CLK 				=> MUX_DI_CLK,
			OPCODE_IN 			=> MUX_DI_OPCODE_IN,
			OPERAND_B_DIRECT_IN	=> MUX_DI_OPERAND_B_DIRECT_IN,
			OPERAND_B_REG_IN	=> MUX_DI_OPERAND_B_REG_IN,
			 
			OPERAND_B_OUT		=> MUX_DI_OPERAND_B_OUT
	);
	
		  
	alu_object: ALU PORT MAP (
			OPERAND_1	=> ALU_OPERAND_1,
			OPERAND_2	=> ALU_OPERAND_2,
			ALU_CTRL	=> ALU_ALU_CTRL,
			 
			RESULT		=> ALU_RESULT,
			NEG_FLAG	=> ALU_NEG_FLAG,
			OVF_FLAG	=> ALU_OVF_FLAG,
			ZER_FLAG	=> ALU_ZER_FLAG,
			CAR_FLAG	=> ALU_CAR_FLAG
        );
		  
	mux_mem_object: MUX_MEM PORT MAP (
			CLK 		=> MUX_MEM_CLK,
			OPCODE 		=> MUX_MEM_OPCODE,
			OPERAND_A	=> MUX_MEM_OPERAND_A,
			OPERAND_B	=> MUX_MEM_OPERAND_B,
			 
			OPERAND_OUT	=> MUX_MEM_OPERAND_OUT
	);
		  
	lc_mem_object: LC_MEM PORT MAP(
			OPCODE	=> LC_MEM_OPCODE,
			
			RW		=> LC_MEM_RW
	);
	
	data_memory_object: DataMemory PORT MAP (
			ADDR	=> DataMemory_ADDR,
			DATA	=> DataMemory_DATA,
			RW 		=> DataMemory_RW,
			RST 	=> DataMemory_RST,
			CLK 	=> DataMemory_CLK,
			 
			OUTPUT	=> DataMemory_OUTPUT
	);
		  
	
	 
	------------------------------------------
	------			Processing			------
	------------------------------------------
	-- Synchronize all the RST's
	DataMemory_RST	<= GLOBAL_RST;
	-- Synchronize all CLK's
	Pipeline_LI_DI_CLK		<= GLOBAL_CLK;
	Pipeline_DI_EX_CLK		<= GLOBAL_CLK;
	Pipeline_EX_MEM_CLK		<= GLOBAL_CLK;
	Pipeline_MEM_RE_CLK		<= GLOBAL_CLK;
	InstructionMemory_CLK	<= GLOBAL_CLK;
	RegisterFile_CLK		<= GLOBAL_CLK;
	MUX_DI_CLK				<= GLOBAL_CLK;
	DataMemory_CLK			<= GLOBAL_CLK;
	
	
	
	-- FIXME : Need to implement a Decoder from the instruction memory to the first pipeline
	
	--Decoder_INPUT	<= InstructionMemory_OUTPUT;
	
	--Pipeline_LI_DI_OPERAND_A_IN	<= Decoder_OPERAND_A;
	--Pipeline_LI_DI_OPCODE_IN		<= Decoder_OPCODE;
	--Pipeline_LI_DI_OPERAND_B_IN	<= Decoder_OPERAND_B;
	--Pipeline_LI_DI_OPERAND_C_IN	<= Decoder_OPERAND_C;	
	
	MUX_DI_OPCODE_IN			<= Pipeline_LI_DI_OPCODE_OUT;
	MUX_DI_OPERAND_B_DIRECT_IN	<= Pipeline_LI_DI_OPERAND_B_OUT;
	MUX_DI_OPERAND_B_REG_IN 	<= RegisterFile_QA;
	
	
	RegisterFile_READ_REG_ADDR_A	<= Pipeline_LI_DI_OPERAND_B_OUT(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
	RegisterFile_READ_REG_ADDR_B	<= Pipeline_LI_DI_OPERAND_C_OUT(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
	--RegisterFile_WRITE_REQ			<= LC_RE_WRITE_REQ;
	RegisterFile_WRITE_REG_ADDR		<= Pipeline_MEM_RE_OPERAND_A_OUT(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
	RegisterFile_DATA				<= Pipeline_MEM_RE_OPERAND_B_OUT;
	
	
	Pipeline_DI_EX_OPERAND_A_IN	<= Pipeline_LI_DI_OPERAND_A_OUT;
	Pipeline_DI_EX_OPCODE_IN	<= Pipeline_LI_DI_OPCODE_OUT;
	Pipeline_DI_EX_OPERAND_B_IN	<= MUX_DI_OPERAND_B_OUT;
	Pipeline_DI_EX_OPERAND_C_IN	<= RegisterFile_QB;
	
	
	--LC_EX_OPCODE	<= Pipeline_DI_EX_OPCODE_OUT;
	
	
	ALU_OPERAND_1	<= Pipeline_DI_EX_OPERAND_B_OUT;
	ALU_OPERAND_2	<= Pipeline_DI_EX_OPERAND_C_OUT;
	--ALU_ALU_CTRL	<= LC_EX_ALU_CTRL;
	
	--MUX_EX_OPCODE_IN				<= Pipeline_DI_EX_OPCODE_OUT;
	--MUX_EX_OPERAND_B_DIRECT_IN	<= Pipeline_DI_EX_OPERAND_B_OUT;
	--MUX_EX_OPERAND_B_ALU_IN		<= ALU_RESULT;
	
	
	Pipeline_EX_MEM_OPERAND_A_IN	<= Pipeline_DI_EX_OPERAND_A_OUT;
	Pipeline_EX_MEM_OPCODE_IN		<= Pipeline_DI_EX_OPCODE_OUT;
	--Pipeline_EX_MEM_OPERAND_B_IN	<= MUX_EX_OPERAND_B_OUT;
	

	MUX_MEM_OPERAND_A	<= Pipeline_EX_MEM_OPERAND_A_OUT;
	
	LC_MEM_OPCODE	<= Pipeline_EX_MEM_OPCODE_OUT;
	
	DataMemory_ADDR	<= MUX_MEM_OPERAND_OUT;
	DataMemory_DATA	<= Pipeline_EX_MEM_OPERAND_B_OUT;
	DataMemory_RW	<= LC_MEM_RW;
	
	--MUX_RE_OPCODE_IN				<= Pipeline_EX_MEM_OPCODE_OUT;
	--MUX_RE_OPERAND_B_DIRECT_IN	<= Pipeline_EX_MEM_OPERAND_B_OUT;
	--MUX_RE_OPERAND_B_MEM_IN		<= DataMemory_OUTPUT;
	
	Pipeline_MEM_RE_OPERAND_A_IN	<= Pipeline_EX_MEM_OPERAND_A_OUT;
	Pipeline_MEM_RE_OPCODE_IN		<= Pipeline_EX_MEM_OPCODE_OUT;
	--Pipeline_MEM_RE_OPERAND_B_IN	<= MUX_RE_OPERAND_B_OUT;
	
	--LC_RE_OPCODE	<= Pipeline_MEM_RE_OPCODE_OUT;
	
	
	-- If we don't process anything the compiler throws an error, so
	-- leave that here for the moment
	MainProcessor_OUTPUT <= '0' when MainProcessor_CLK = '0' else
							'1';

end Behavioral;

