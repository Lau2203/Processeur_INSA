library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity MainProcessor is
	port (
		MainProcessor_CLK		: in 	std_logic;
		MainProcessor_RST		: in 	std_logic;
		-- For a direct visualization of each pipeline
		MainProcessor_P1		: out	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		MainProcessor_P2		: out	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		MainProcessor_P3		: out	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		MainProcessor_P4		: out	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		MainProcessor_OUTPUT	: out	std_logic
	);
end MainProcessor;

architecture Behavioral of MainProcessor is

	signal GLOBAL_RST	: std_logic := '1';

	
	------------------------------------------
	------			Pipeline			------
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
	------				IP				------
	------------------------------------------
	COMPONENT IP
	PORT(
			CLK 	: IN	std_logic;
			RST		: IN 	std_logic;
			EN		: IN 	std_logic;

			ADDR 	: OUT	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0)
	);
	END COMPONENT;


	--Inputs
	signal IP_CLK 	: std_logic := '0';
	signal IP_RST 	: std_logic := '0';
	signal IP_EN 	: std_logic := '1';

	--Outputs
	signal IP_ADDR 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
	

	COMPONENT Decoder
	PORT(
			INSTRUCTION	: IN  std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
			OPERAND_A	: OUT  std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
			OPCODE		: OUT  std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
			OPERAND_B	: OUT  std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
			OPERAND_C	: OUT  std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0)
	);
	END COMPONENT;
    

   --Inputs
   signal Decoder_INSTRUCTION : std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0) := (others => '0');

 	--Outputs
   signal Decoder_OPERAND_A	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
   signal Decoder_OPCODE	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
   signal Decoder_OPERAND_B : std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
   signal Decoder_OPERAND_C : std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);


	------------------------------------------
	------		InstructionMemory		------
	------------------------------------------
	COMPONENT InstructionMemory
		PORT(
				CLK 	: IN	std_logic;
				EN		: IN	std_logic;
				ADDR 	: IN	std_logic_vector(CONSTANT_INST_MEMORY_ADDR_SIZE - 1 downto 0);
				
				OUTPUT 	: OUT	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0)
			  );
   END COMPONENT;
    

	-- Inputs
	signal InstructionMemory_CLK 	: std_logic := '0';
	signal InstructionMemory_EN 	: std_logic := '0';
	signal InstructionMemory_ADDR	: std_logic_vector(CONSTANT_INST_MEMORY_ADDR_SIZE - 1 downto 0) := (others => '0');

 	-- Outputs
	signal InstructionMemory_OUTPUT : std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
	
	
	------------------------------------------
	------			RegisterFile		------
	------------------------------------------
	COMPONENT RegisterFile
	PORT(
			RST 			: IN	std_logic;
			CLK 			: IN	std_logic;
			READ_REG_ADDR_A : IN	std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
			READ_REG_ADDR_B	: IN	std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
			QA 				: OUT	std_logic_vector(CONSTANT_DATA_SIZE - 1 downto 0);
			QB 				: OUT	std_logic_vector(CONSTANT_DATA_SIZE - 1 downto 0);
			WRITE_REQ 		: IN	std_logic;
			WRITE_REG_ADDR	: IN	std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
			DATA 			: IN	std_logic_vector(CONSTANT_DATA_SIZE - 1 downto 0)
		);
	END COMPONENT;
    

	--Inputs
	signal RegisterFile_RST 			: std_logic := '0';
	signal RegisterFile_CLK 			: std_logic := '0';
	signal RegisterFile_READ_REG_ADDR_A : std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0) := (others => '0');
	signal RegisterFile_READ_REG_ADDR_B : std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0) := (others => '0');
	signal RegisterFile_WRITE_REQ 		: std_logic := '0';
	signal RegisterFile_WRITE_REG_ADDR 	: std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0) := (others => '0');
	signal RegisterFile_DATA 			: std_logic_vector(CONSTANT_DATA_SIZE - 1 downto 0) := (others => '0');

	--Outputs
	signal RegisterFile_QA : std_logic_vector(CONSTANT_DATA_SIZE - 1 downto 0);
	signal RegisterFile_QB : std_logic_vector(CONSTANT_DATA_SIZE - 1 downto 0);
	
	
	------------------------------------------
	------				MUX_DI			------
	------------------------------------------
	COMPONENT MUX_DI
	PORT(
			OPCODE_IN 				: IN	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
			OPERAND_B_DIRECT_IN 	: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
			OPERAND_B_REG_IN 		: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);

			OPERAND_B_OUT 			: OUT	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0)
		);
	END COMPONENT;


	--Inputs
	signal MUX_DI_OPCODE_IN 			: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal MUX_DI_OPERAND_B_DIRECT_IN 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal MUX_DI_OPERAND_B_REG_IN 		: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

	--Outputs
	signal MUX_DI_OPERAND_B_OUT 			: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
	
	
	------------------------------------------
	------				LC_EX			------
	------------------------------------------
	COMPONENT LC_EX
		PORT(
				OPCODE		: IN	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);

				ALU_CTRL	: OUT	std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0)
		);
	END COMPONENT;


	-- Inputs
	signal LC_EX_OPCODE		: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');

	-- Outputs
	signal LC_EX_ALU_CTRL	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := CONSTANT_ALU_NONE;
	
	
	------------------------------------------
	------				ALU				------
	------------------------------------------
	COMPONENT ALU
    PORT(
         OPERAND_1	: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
         OPERAND_2 	: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
         ALU_CTRL 	: IN 	std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0);
			
         RESULT 	: OUT	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
         NEG_FLAG 	: OUT	std_logic;
         OVF_FLAG 	: OUT	std_logic;
         ZER_FLAG 	: OUT	std_logic;
         CAR_FLAG 	: OUT	std_logic
        );
    END COMPONENT;
    

	--Inputs
	signal ALU_OPERAND_1 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) 	:= (others => '0');
	signal ALU_OPERAND_2 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) 	:= (others => '0');
	signal ALU_ALU_CTRL 	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := (others => '0');

 	--Outputs
	signal ALU_RESULT	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
	signal ALU_NEG_FLAG : std_logic;
	signal ALU_OVF_FLAG : std_logic;
	signal ALU_ZER_FLAG : std_logic;
	signal ALU_CAR_FLAG : std_logic;


	------------------------------------------
	------				MUX_EX			------
	------------------------------------------
	COMPONENT MUX_EX
	PORT(
			OPCODE_IN 				: IN	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
			OPERAND_B_DIRECT_IN 	: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
			OPERAND_B_ALU_IN 		: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);

			OPERAND_B_OUT 			: OUT	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0)
		);
	END COMPONENT;


	--Inputs
	signal MUX_EX_OPCODE_IN 			: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal MUX_EX_OPERAND_B_DIRECT_IN 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal MUX_EX_OPERAND_B_ALU_IN 		: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

	--Outputs
	signal MUX_EX_OPERAND_B_OUT 		: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
	
	
	


	------------------------------------------
	------				MUX_MEM			------
	------------------------------------------
	COMPONENT MUX_MEM
	PORT(
			OPCODE 		: IN	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
			OPERAND_A 	: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
			OPERAND_B 	: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);

			OPERAND_OUT : OUT	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0)
	);
	END COMPONENT;


	--Inputs
	signal MUX_MEM_OPCODE 		: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal MUX_MEM_OPERAND_A 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal MUX_MEM_OPERAND_B 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

	--Outputs
	signal MUX_MEM_OPERAND_OUT 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);

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
			ADDR	: IN	std_logic_vector(CONSTANT_DATA_MEMORY_ADDR_SIZE - 1 downto 0);
			DATA 	: IN	std_logic_vector(CONSTANT_DATA_MEMORY_SLOT_SIZE - 1 downto 0);
			RW 		: IN	std_logic;
			RST 	: IN	std_logic;
			CLK 	: IN	std_logic;

			OUTPUT	: OUT	std_logic_vector(CONSTANT_DATA_MEMORY_SLOT_SIZE - 1 downto 0)
		);
	END COMPONENT;


	--Inputs
	signal DataMemory_ADDR 		: std_logic_vector(CONSTANT_DATA_MEMORY_ADDR_SIZE - 1 downto 0) := (others => '0');
	signal DataMemory_DATA 		: std_logic_vector(CONSTANT_DATA_MEMORY_SLOT_SIZE - 1 downto 0) := (others => '0');
	signal DataMemory_RW 		: std_logic := '0';
	signal DataMemory_RST 		: std_logic := '0';
	signal DataMemory_CLK 		: std_logic := '0';

	--Outputs
	signal DataMemory_OUTPUT 	: std_logic_vector(CONSTANT_DATA_MEMORY_SLOT_SIZE - 1 downto 0);
	
	------------------------------------------
	------				MUX_RE			------
	------------------------------------------
	COMPONENT MUX_RE
	PORT(
			OPCODE_IN 				: IN	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);
			OPERAND_B_DIRECT_IN 	: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);
			OPERAND_B_MEM_IN 		: IN	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);

			OPERAND_B_OUT 			: OUT	std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0)
		);
	END COMPONENT;


	--Inputs
	signal MUX_RE_OPCODE_IN 			: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');
	signal MUX_RE_OPERAND_B_DIRECT_IN 	: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
	signal MUX_RE_OPERAND_B_MEM_IN 		: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');

	--Outputs
	signal MUX_RE_OPERAND_B_OUT 		: std_logic_vector(CONSTANT_OPERAND_SIZE - 1 downto 0);



	------------------------------------------
	------				LC_RE			------
	------------------------------------------
	COMPONENT LC_RE
		PORT(
				OPCODE		: IN	std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0);

				WRITE_REQ	: OUT	std_logic
		);
	END COMPONENT;


	-- Inputs
	signal LC_RE_OPCODE		: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := (others => '0');

	-- Outputs
	signal LC_RE_WRITE_REQ	: std_logic := CONSTANT_REG_WRITE_FLAG_OFF;
   
   
   
	type data_hazard_table_type is array (0 to CONSTANT_REG_NB - 1) of STD_LOGIC_VECTOR (3 - 1 downto 0); -- We need to be able to put a '4' value since there are 4 in-between pipelines
	signal data_hazard_table : data_hazard_table_type := (others => (others => '0'));


begin
	------------------------------------------
	------			Creation			------
	------------------------------------------
	
	decoder_object: Decoder PORT MAP (
			INSTRUCTION	=> Decoder_INSTRUCTION,
			
			OPERAND_A	=> Decoder_OPERAND_A,
			OPCODE 		=> Decoder_OPCODE,
			OPERAND_B 	=> Decoder_OPERAND_B,
			OPERAND_C	=> Decoder_OPERAND_C
	);
	
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
	
	ip_object: IP PORT MAP(
			CLK		=> IP_CLK,
			RST		=> IP_RST,
			EN		=> IP_EN,
			
			ADDR	=> IP_ADDR
	);
	
	instruction_memory_object: InstructionMemory PORT MAP (
			CLK		=> InstructionMemory_CLK,
			EN		=> InstructionMemory_EN,
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
			OPCODE_IN 			=> MUX_DI_OPCODE_IN,
			OPERAND_B_DIRECT_IN	=> MUX_DI_OPERAND_B_DIRECT_IN,
			OPERAND_B_REG_IN	=> MUX_DI_OPERAND_B_REG_IN,
			 
			OPERAND_B_OUT		=> MUX_DI_OPERAND_B_OUT
	);
	
	lc_ex_object: LC_EX PORT MAP(
			OPCODE		=> LC_EX_OPCODE,
			
			ALU_CTRL	=> LC_EX_ALU_CTRL
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

	mux_ex_object: MUX_EX PORT MAP (
			OPCODE_IN 			=> MUX_EX_OPCODE_IN,
			OPERAND_B_DIRECT_IN	=> MUX_EX_OPERAND_B_DIRECT_IN,
			OPERAND_B_ALU_IN	=> MUX_EX_OPERAND_B_ALU_IN,
			 
			OPERAND_B_OUT		=> MUX_EX_OPERAND_B_OUT
	);
		  
	mux_mem_object: MUX_MEM PORT MAP (
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
	
	mux_re_object: MUX_RE PORT MAP (
			OPCODE_IN 			=> MUX_RE_OPCODE_IN,
			OPERAND_B_DIRECT_IN	=> MUX_RE_OPERAND_B_DIRECT_IN,
			OPERAND_B_MEM_IN	=> MUX_RE_OPERAND_B_MEM_IN,
			 
			OPERAND_B_OUT		=> MUX_RE_OPERAND_B_OUT
	);
	
	lc_re_object: LC_RE PORT MAP(
			OPCODE		=> LC_RE_OPCODE,
			
			WRITE_REQ	=> LC_RE_WRITE_REQ
	);
		  
	
	 
	------------------------------------------
	------			Processing			------
	------------------------------------------
	
	-- Synchronize all the RST's
	IP_RST					<= MainProcessor_RST;
	RegisterFile_RST		<= MainProcessor_RST;
	DataMemory_RST			<= MainProcessor_RST;
	
	Pipeline_LI_DI_RST		<= MainProcessor_RST;
	Pipeline_DI_EX_RST		<= MainProcessor_RST;
	Pipeline_EX_MEM_RST		<= MainProcessor_RST;
	Pipeline_MEM_RE_RST		<= MainProcessor_RST;
	
	-- Synchronize all CLK's
	Pipeline_LI_DI_CLK		<= MainProcessor_CLK;
	Pipeline_DI_EX_CLK		<= MainProcessor_CLK;
	Pipeline_EX_MEM_CLK		<= MainProcessor_CLK;
	Pipeline_MEM_RE_CLK		<= MainProcessor_CLK;
	
	IP_CLK					<= MainProcessor_CLK;
	InstructionMemory_CLK	<= MainProcessor_CLK;
	RegisterFile_CLK		<= MainProcessor_CLK;
	DataMemory_CLK			<= MainProcessor_CLK;
	
	
	----------- BGN LEVEL LI ----------- 
	-- Enable IP counter
	--IP_EN	<= '1';
	
	--InstructionMemory_EN	<= '1';
	InstructionMemory_ADDR	<= IP_ADDR;
	
	Decoder_INSTRUCTION	<= InstructionMemory_OUTPUT;
	
	----------- END LEVEL LI -----------
	
	
	
	Pipeline_LI_DI_OPERAND_A_IN	<= Decoder_OPERAND_A;
	Pipeline_LI_DI_OPCODE_IN	<= Decoder_OPCODE;
	Pipeline_LI_DI_OPERAND_B_IN	<= Decoder_OPERAND_B;
	Pipeline_LI_DI_OPERAND_C_IN	<= Decoder_OPERAND_C;	
	
	
	
	----------- BGN LEVEL DI -----------
	
	MUX_DI_OPCODE_IN			<= Pipeline_LI_DI_OPCODE_OUT;
	MUX_DI_OPERAND_B_DIRECT_IN	<= Pipeline_LI_DI_OPERAND_B_OUT;
	MUX_DI_OPERAND_B_REG_IN 	<= RegisterFile_QA;
	
	
	RegisterFile_READ_REG_ADDR_A	<= Pipeline_LI_DI_OPERAND_B_OUT(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
	RegisterFile_READ_REG_ADDR_B	<= Pipeline_LI_DI_OPERAND_C_OUT(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
	RegisterFile_WRITE_REQ			<= LC_RE_WRITE_REQ;
	RegisterFile_WRITE_REG_ADDR		<= Pipeline_MEM_RE_OPERAND_A_OUT(CONSTANT_REG_ADDR_SIZE - 1 downto 0);
	RegisterFile_DATA				<= Pipeline_MEM_RE_OPERAND_B_OUT;
	
	----------- END LEVEL DI ----------- 
	
	
	
	Pipeline_DI_EX_OPERAND_A_IN	<= Pipeline_LI_DI_OPERAND_A_OUT;
	--Pipeline_DI_EX_OPCODE_IN	<= Pipeline_LI_DI_OPCODE_OUT;
	Pipeline_DI_EX_OPERAND_B_IN	<= MUX_DI_OPERAND_B_OUT;
	Pipeline_DI_EX_OPERAND_C_IN	<= RegisterFile_QB;
	
	
	
	----------- BGN LEVEL EX -----------
	
	LC_EX_OPCODE	<= Pipeline_DI_EX_OPCODE_OUT;
	
	ALU_OPERAND_1	<= Pipeline_DI_EX_OPERAND_B_OUT;
	ALU_OPERAND_2	<= Pipeline_DI_EX_OPERAND_C_OUT;
	ALU_ALU_CTRL	<= LC_EX_ALU_CTRL;
	
	MUX_EX_OPCODE_IN			<= Pipeline_DI_EX_OPCODE_OUT;
	MUX_EX_OPERAND_B_DIRECT_IN	<= Pipeline_DI_EX_OPERAND_B_OUT;
	MUX_EX_OPERAND_B_ALU_IN		<= ALU_RESULT;
	
	----------- END LEVEL EX -----------
	
	
	
	Pipeline_EX_MEM_OPERAND_A_IN	<= Pipeline_DI_EX_OPERAND_A_OUT;
	Pipeline_EX_MEM_OPCODE_IN		<= Pipeline_DI_EX_OPCODE_OUT;
	Pipeline_EX_MEM_OPERAND_B_IN	<= MUX_EX_OPERAND_B_OUT;
	
	
	
	----------- BGN LEVEL MEM -----------
	
	MUX_MEM_OPCODE		<= Pipeline_EX_MEM_OPCODE_OUT;
	MUX_MEM_OPERAND_A	<= Pipeline_EX_MEM_OPERAND_A_OUT;
	MUX_MEM_OPERAND_B	<= Pipeline_EX_MEM_OPERAND_B_OUT;
	
	LC_MEM_OPCODE	<= Pipeline_EX_MEM_OPCODE_OUT;
	
	DataMemory_ADDR	<= MUX_MEM_OPERAND_OUT;
	DataMemory_DATA	<= Pipeline_EX_MEM_OPERAND_B_OUT;
	DataMemory_RW	<= LC_MEM_RW;
	
	MUX_RE_OPCODE_IN			<= Pipeline_EX_MEM_OPCODE_OUT;
	MUX_RE_OPERAND_B_DIRECT_IN	<= Pipeline_EX_MEM_OPERAND_B_OUT;
	MUX_RE_OPERAND_B_MEM_IN		<= DataMemory_OUTPUT;
	
	----------- END LEVEL MEM -----------
	
	
	
	Pipeline_MEM_RE_OPERAND_A_IN	<= Pipeline_EX_MEM_OPERAND_A_OUT;
	Pipeline_MEM_RE_OPCODE_IN		<= Pipeline_EX_MEM_OPCODE_OUT;
	Pipeline_MEM_RE_OPERAND_B_IN	<= MUX_RE_OPERAND_B_OUT;
	
	
	
	----------- BGN LEVEL RE -----------
	
	LC_RE_OPCODE	<= Pipeline_MEM_RE_OPCODE_OUT;
	
	----------- END LEVEL RE -----------
	
	
	-- If we don't process anything the compiler throws an error, so
	-- leave that here for the moment
	MainProcessor_OUTPUT <= '0' when MainProcessor_CLK = '0' else
							'1';
	
	MainProcessor_P1 <= Pipeline_LI_DI_OPCODE_OUT	& Pipeline_LI_DI_OPERAND_A_OUT	& Pipeline_LI_DI_OPERAND_B_OUT	& Pipeline_LI_DI_OPERAND_C_OUT;
	MainProcessor_P2 <= Pipeline_DI_EX_OPCODE_OUT	& Pipeline_DI_EX_OPERAND_A_OUT	& Pipeline_DI_EX_OPERAND_B_OUT	& Pipeline_DI_EX_OPERAND_C_OUT;
	MainProcessor_P3 <= Pipeline_EX_MEM_OPCODE_OUT	& Pipeline_EX_MEM_OPERAND_A_OUT & Pipeline_EX_MEM_OPERAND_B_OUT & x"00";
	MainProcessor_P4 <= Pipeline_MEM_RE_OPCODE_OUT	& Pipeline_MEM_RE_OPERAND_A_OUT & Pipeline_MEM_RE_OPERAND_B_OUT & x"00";
 
	-- Data hazards management
	process(MainProcessor_CLK)
		-- This variable will store the address (number) of the register
		-- that is modified at a particular clock tick.
		variable register_nb : integer := -1;
	begin
		if rising_edge(MainProcessor_CLK) then
			
			if MainProcessor_RST = '1' then
			
				if Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_NOP then
				
					-- Instructions that write a new value into a register
					--
					-- We need to remember that a register will be modified, and that only after
					-- 4 clock ticks, since there is 4 intermediate pipelines.
					if	Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_AFC 	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_LOAD	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_ADD	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_MUL	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_SUB
						then
						
						register_nb := to_integer(unsigned(Pipeline_LI_DI_OPERAND_A_IN));
						
						IP_EN <= '1';
						InstructionMemory_EN <= '1';
					end if;
						
					-- Instructions that read from a register
					if	Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_AFC		and
						Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_LOAD	and
						(
							data_hazard_table(to_integer(unsigned(Pipeline_LI_DI_OPERAND_B_IN))) /= "000"
							or
							(
								Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_COP		and
								Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_STORE	and
								data_hazard_table(to_integer(unsigned(Pipeline_LI_DI_OPERAND_C_IN))) /= "000"
							)
						)
						then
						
						IP_EN <= '0';
						InstructionMemory_EN <= '0';
					else
						IP_EN <= '1';
						InstructionMemory_EN <= '1';
					end if;
					
					
				else
					IP_EN <= '1';
					InstructionMemory_EN <= '1';
				end if;
				
			else
				IP_EN <= '0';
				InstructionMemory_EN <= '0';
				--Pipeline_DI_EX_OPCODE_IN <= Pipeline_LI_DI_OPCODE_OUT;
			end if;
				
			-- Update data_hazard_table
			-- Decrement all the register counters
			for REG in 0 to (CONSTANT_REG_NB - 1) loop
			
				-- If register_nb is different from (-1), that means that we
				-- must enable the countdown from 4 down to 0 for the register
				-- which have the address stored in register_nb
				if register_nb = REG then
					data_hazard_table(REG) <= "100";
					
				elsif data_hazard_table(REG) /= "000" then
					data_hazard_table(REG) <= data_hazard_table(REG) - 1;
					
				else
					data_hazard_table(REG) <= data_hazard_table(REG);
				end if;
				
			end loop;
			
			-- Reset it to -1 for the next clk's rising edge
			register_nb := -1;
				
			
		-- Since plugging Pipeline_DI_EX_OPCODE_IN in Pipeline_LI_DI_OPCODE_OUT will take one
		-- clock tick, we have to do that operation on falling edges, so that all the pipelines
		-- have the correct value when on the next rising edge.
		-- Basically the same code as above, but instead of modifying IP_EN and InstructinoMemory_EN we
		-- do
		-- 	Pipeline_DI_EX_OPCODE_IN <= Pipeline_LI_DI_OPCODE_OUT;
		-- or 
		-- 	Pipeline_DI_EX_OPCODE_IN <= CONSTANT_OP_NOP;
		elsif falling_edge(MainProcessor_CLK) then
		
			if MainProcessor_RST = '1' then
			
				if Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_NOP then
				
					-- Instructions that write a new value into a register
					if	Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_AFC 	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_LOAD	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_ADD	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_MUL	or
						Pipeline_LI_DI_OPCODE_IN = CONSTANT_OP_SUB
						then
						
						Pipeline_DI_EX_OPCODE_IN <= Pipeline_LI_DI_OPCODE_OUT;
					end if;
						
					-- Instructions that read from a register
					if	Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_AFC		and
						Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_LOAD	and
						(
							data_hazard_table(to_integer(unsigned(Pipeline_LI_DI_OPERAND_B_IN))) /= "000"
							or
							(
								Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_COP		and
								Pipeline_LI_DI_OPCODE_IN /= CONSTANT_OP_STORE	and
								data_hazard_table(to_integer(unsigned(Pipeline_LI_DI_OPERAND_C_IN))) /= "000"
							)
						)
						then
						
						Pipeline_DI_EX_OPCODE_IN <= CONSTANT_OP_NOP;
						
					else
						Pipeline_DI_EX_OPCODE_IN <= Pipeline_LI_DI_OPCODE_OUT;
					end if;
					
					
				else
					Pipeline_DI_EX_OPCODE_IN <= Pipeline_LI_DI_OPCODE_OUT;
				end if;
				
			else
				Pipeline_DI_EX_OPCODE_IN <= Pipeline_LI_DI_OPCODE_OUT;
			end if;
			
		end if;
	end process;
 
end Behavioral;

