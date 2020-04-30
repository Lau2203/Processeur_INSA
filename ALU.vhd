
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity ALU is
	generic (
		msb 					: Natural := CONSTANT_OPERAND_SIZE - 1; -- Most Significant Bit position
		double_size			: Natural := CONSTANT_OPERAND_SIZE * 2;
		zero_single_size	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0) := (others => '0');
		zero_double_size 	: STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE * 2 - 1 downto 0) := (others => '0')
	);
	Port(
		OPERAND_1	: in 	STD_LOGIC_VECTOR(CONSTANT_OPERAND_SIZE - 1 downto 0);		--< The first operand in the arithmetic operation
		OPERAND_2	: in 	STD_LOGIC_VECTOR(CONSTANT_OPERAND_SIZE - 1 downto 0);		--< The second operand in the arithmetic operation

		ALU_CTRL	: in 	STD_LOGIC_VECTOR(CONSTANT_ALU_CTRL_SIZE - 1 downto 0);	--< The arithmetic operation to perform

		RESULT	: out STD_LOGIC_VECTOR(CONSTANT_OPERAND_SIZE - 1 downto 0);		--> The final result of the arithmetic operation

		NEG_FLAG	: out STD_LOGIC;			--> Negative FLAG : 1 when the result is negative, 0 otherwise
		OVF_FLAG	: out STD_LOGIC;			--> Overflow FLAG : 1 when the result overflows the RESULT capacity, 0 otherwise
		ZER_FLAG	: out STD_LOGIC;			--> Zero FLAG : 1 when the result equals 0, 0 otherwise
		CAR_FLAG	: out STD_LOGIC			--> Carry FLAG : 1 when the arithmetic operation produced a carry, 0 otherwise
	);
end ALU;

architecture Behavioral of ALU is 

	-- We double the size of the two operands by padding with zeros
	signal OPERAND_1_DOUBLE_SIZE : STD_LOGIC_VECTOR(double_size - 1 downto 0) := zero_single_size & OPERAND_1;
	signal OPERAND_2_DOUBLE_SIZE : STD_LOGIC_VECTOR(double_size - 1 downto 0) := zero_single_size & OPERAND_2;
	-- The temporary overflow-safe result holder, needed to set flags
	signal RESULT_TMP : STD_LOGIC_VECTOR((double_size - 1) downto 0);

begin 

	RESULT_TMP <=	OPERAND_1_DOUBLE_SIZE + OPERAND_2_DOUBLE_SIZE when ALU_CTRL = CONSTANT_ALU_ADD else
						OPERAND_1_DOUBLE_SIZE - OPERAND_2_DOUBLE_SIZE when ALU_CTRL = CONSTANT_ALU_SUB else
						std_logic_vector(to_unsigned(to_integer(unsigned(OPERAND_1)) * to_integer(unsigned(OPERAND_2)), CONSTANT_OPERAND_SIZE * 2)) when ALU_CTRL = CONSTANT_ALU_MUL else
						OPERAND_1_DOUBLE_SIZE and 	OPERAND_2_DOUBLE_SIZE when ALU_CTRL = CONSTANT_ALU_AND else
						OPERAND_1_DOUBLE_SIZE xor 	OPERAND_2_DOUBLE_SIZE when ALU_CTRL = CONSTANT_ALU_XOR else
						OPERAND_1_DOUBLE_SIZE or 	OPERAND_2_DOUBLE_SIZE when ALU_CTRL = CONSTANT_ALU_OR else
						(others => '0');

	RESULT <= RESULT_TMP(msb downto 0);

	NEG_FLAG <= RESULT_TMP(msb);

	OVF_FLAG <= '1' when ALU_CTRL = CONSTANT_ALU_ADD and (OPERAND_1(msb) = OPERAND_2(msb) and RESULT_TMP(msb) /= OPERAND_1(msb)) else	-- Same sign operands give an opposite sign result
					'1' when ALU_CTRL = CONSTANT_ALU_SUB and (OPERAND_1(msb) /= OPERAND_2(msb) and RESULT_TMP(msb) /= OPERAND_1(msb)) else	-- Different sign operands give a sign which is opposite to the first operand as a result
					'1' when ALU_CTRL = CONSTANT_ALU_MUL and (	-- (+) * (+) amd (-) * (-) MUST give us a positive result, otherwise OVERFLOW
																(OPERAND_1(msb) = OPERAND_2(msb) and RESULT_TMP(msb) = '1')
																or				-- (+) * (-) and (-) * (+) MUST give us a negative result, otherwise OVERFLOW
																(OPERAND_1(msb) /= OPERAND_2(msb) and RESULT_TMP(msb) = '0')
																			) else
					'0';


	ZER_FLAG <= '1' when RESULT_TMP = zero_double_size else
					'0';

	CAR_FLAG <= RESULT_TMP(msb + 1);

end Behavioral;

