
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	Port(
		OPERAND1	: in 	STD_LOGIC_VECTOR (7 downto 0);	--< The first operand in the arithmetic operation
		OPERAND2	: in 	STD_LOGIC_VECTOR (7 downto 0);	--< The second operand in the arithmetic operation

		ALU_CTRL	: in 	STD_LOGIC_VECTOR (2 downto 0);	--< The arithmetic operation to perform

		RESULT	: out STD_LOGIC_VECTOR (7 downto 0);	--> The final result of the arithmetic operation

		NEG_FLAG	: out STD_LOGIC;			--> Negative FLAG : 1 when the result is negative, 0 otherwise
		OVF_FLAG	: out STD_LOGIC;			--> Overflow FLAG : 1 when the result overflows the RESULT capacity, 0 otherwise
		ZER_FLAG	: out STD_LOGIC;			--> Zero FLAG : 1 when the result equals 0, 0 otherwise
		CAR_FLAG	: out STD_LOGIC			--> Carry FLAG : 1 when the arithmetic operation produced a carry, 0 otherwise
	);
end ALU;

architecture Behavioral of ALU is 

	signal RESULT_TMP : STD_LOGIC_VECTOR (15 downto 0);

	-- ALU_CTRL's possible values
	constant ALU_ADD : STD_LOGIC_VECTOR(2 downto 0) := "000";
	constant ALU_SUB : STD_LOGIC_VECTOR(2 downto 0) := "001";
	constant ALU_MUL : STD_LOGIC_VECTOR(2 downto 0) := "010";

begin 

	RESULT_TMP <=	(X"00" & OPERAND1) + (X"00" & OPERAND2) when ALU_CTRL = ALU_ADD else
						(X"00" & OPERAND1) - (X"00" & OPERAND2) when ALU_CTRL = ALU_SUB else
						std_logic_vector(to_unsigned(to_integer(unsigned(OPERAND1)) * to_integer(unsigned(OPERAND2)), 16)) when ALU_CTRL = ALU_MUL else
						(others => '0');

	RESULT <= RESULT_TMP(7 downto 0);

	NEG_FLAG <= RESULT_TMP(7);

	OVF_FLAG <= '1' when ALU_CTRL = ALU_ADD and (OPERAND1(7) = OPERAND2(7) and RESULT_TMP(7) /= OPERAND1(7)) else
					'1' when ALU_CTRL = ALU_SUB and (OPERAND1(7) /= OPERAND2(7) and RESULT_TMP(7) /= OPERAND1(7)) else
					'1' when ALU_CTRL = ALU_MUL and (
									(OPERAND1(7) = OPERAND2(7) and RESULT_TMP(7) = '1')
									or
									(OPERAND1(7) /= OPERAND2(7) and RESULT_TMP(7) = '0')
																) else
					'0';


	ZER_FLAG <= '1' when RESULT_TMP = "0000000000000000" else
					'0';

	CAR_FLAG <= RESULT_TMP(8);

end Behavioral;

