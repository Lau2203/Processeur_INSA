
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package constants is

	constant CONSTANT_ADDRESS_SIZE		: Natural := 8;
	constant CONSTANT_DATA_SIZE		: Natural := 8;


	-- DATA MEMORY
	constant CONSTANT_DATA_MEMORY_SIZE	: Natural := 512;
	constant CONSTANT_DATA_MEMORY_SLOT_SIZE	: Natural := CONSTANT_DATA_SIZE;
	constant CONSTANT_DATA_MEMORY_ADDR_SIZE	: Natural := 8;

	constant CONSTANT_DATA_MEMORY_READ_FLAG		: std_logic := '1';
	constant CONSTANT_DATA_MEMORY_WRITE_FLAG	: std_logic := '0';


	-- ASSEMBLY INSTRUCTIONS
	constant CONSTANT_OPCODE_SIZE		: Natural := 8;
	constant CONSTANT_OPERAND_SIZE		: Natural := CONSTANT_DATA_SIZE;
	constant CONSTANT_INSTRUCTION_SIZE	: Natural := CONSTANT_OPCODE_SIZE + (CONSTANT_OPERAND_SIZE * 3);
	
	constant CONSTANT_INSTRUCTION_OPCODE_POSITION		: Natural := 0;
	constant CONSTANT_INSTRUCTION_OPERAND_A_POSITION	: Natural := CONSTANT_INSTRUCTION_OPCODE_POSITION + CONSTANT_OPCODE_SIZE;
	constant CONSTANT_INSTRUCTION_OPERAND_B_POSITION	: Natural := CONSTANT_INSTRUCTION_OPERAND_A_POSITION + CONSTANT_OPERAND_SIZE;
	constant CONSTANT_INSTRUCTION_OPERAND_C_POSITION	: Natural := CONSTANT_INSTRUCTION_OPERAND_B_POSITION + CONSTANT_OPERAND_SIZE;


	-- INSTRUCTION MEMORY
	constant CONSTANT_INST_MEMORY_SIZE	: Natural := 128;
	constant CONSTANT_INST_MEMORY_SLOT_SIZE	: Natural := CONSTANT_INSTRUCTION_SIZE;
	constant CONSTANT_INST_MEMORY_ADDR_SIZE	: Natural := 8;

	
	-- REGISTERS
	constant CONSTANT_REG_SIZE	: Natural := CONSTANT_DATA_SIZE;
	constant CONSTANT_REG_NB	: Natural := 16;
	constant CONSTANT_REG_ADDR_SIZE	: Natural := 4;

	constant CONSTANT_REG_WRITE_FLAG_ON	: std_logic := '1';
	constant CONSTANT_REG_WRITE_FLAG_OFF	: std_logic := '0';

	
	-- ALU
	constant CONSTANT_ALU_CTRL_SIZE	: Natural := 3;

	constant CONSTANT_ALU_ADD	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "000";
	constant CONSTANT_ALU_MUL	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "001";
	constant CONSTANT_ALU_SUB	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "010";
	constant CONSTANT_ALU_DIV	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "011";
	constant CONSTANT_ALU_AND	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "100";
	constant CONSTANT_ALU_XOR	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "101";
	constant CONSTANT_ALU_OR	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "110";

	constant CONSTANT_ALU_NONE	: std_logic_vector(CONSTANT_ALU_CTRL_SIZE - 1 downto 0) := "111";
	

	-- OPCODES
	constant CONSTANT_OP_NOP	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"00";

	constant CONSTANT_OP_ADD	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"01";
	constant CONSTANT_OP_MUL	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"02";
	constant CONSTANT_OP_SUB	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"03";
	constant CONSTANT_OP_DIV	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"04";

	constant CONSTANT_OP_COP	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"05";
	constant CONSTANT_OP_AFC	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"06";

	constant CONSTANT_OP_LOAD	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"07";
	constant CONSTANT_OP_STORE	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"08";

	constant CONSTANT_OP_JMP	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"09";
	constant CONSTANT_OP_JMF	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"0A";

	constant CONSTANT_OP_INF	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"0B";
	constant CONSTANT_OP_SUP	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"0C";
	constant CONSTANT_OP_EQU	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"0D";
	constant CONSTANT_OP_PRI	: std_logic_vector(CONSTANT_OPCODE_SIZE - 1 downto 0) := x"0E";


end constants;
package body constants is
-- NOTHING
end constants;

