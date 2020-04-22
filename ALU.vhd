
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	Port(
		OPERAND1	: in 	STD_LOGIC_VECTOR (7 downto 0);
		OPERAND2	: in 	STD_LOGIC_VECTOR (7 downto 0);

		ALU_CTRL	: in 	STD_LOGIC_VECTOR (2 downto 0);	-- The arithmetic operation to perform

		RESULT		: out 	STD_LOGIC_VECTOR (7 downto 0);

		NEG_FLAG	: out 	STD_LOGIC;	-- Negative FLAG : 1 when the result is negative, 0 otherwise
		OVF_FLAG	: out 	STD_LOGIC;	-- Overflow FLAG : 1 when the result overflows the RESULT capacity, 0 otherwise
		ZER_FLAG	: out 	STD_LOGIC;	-- Zero FLAG : 1 when the result equals 0, 0 otherwise
		CAR_FLAG	: out 	STD_LOGIC	-- Carry FLAG : 1 when the arithmetic operation produced a carry, 0 otherwise
	);
end ALU;

architecture Behavioral of ALU is 

signal OPERAND1_16 	: STD_LOGIC_VECTOR (15 downto 0);
signal OPERAND2_16 	: STD_LOGIC_VECTOR (15 downto 0);
signal RESULT_TMP 	: STD_LOGIC_VECTOR (15 downto 0);

OPERAND1_16 <= ("00000000" &OPERAND1);
OPERAND2_16 <= ("00000000" &OPERAND2);

RESULT_TMP <= 		OPERAND1_16 + OPERAND2_16 when ALU_CTRL = "000"
		else	OPERAND1_16 - OPERAND2_16 when ALU_CTRL = "001"
		else	OPERAND1_16 * OPERAND2_16 when ALU_CTRL = "010";

RESULT <= RESULT_TMP(7 downto 0);

NEG_FLAG <= 		1 when RESULT(7) = '1'
		else 	0;

OVF_FLAG <= 		1 when ALU_CTRL = "000" and 	(OPERAND1(7) = OPERAND2(7) and RESULT(7) /= OPERAND1(7))
		else 	1 when ALU_CTRL = "001" and 	(OPERAND1(7) /= OPERAND2(7) and RESULT(7) /= OPERAND1(7))
		else 	1 when ALU_CTRL = "010" and 	(
								(OPERAND1(7) = OPERAND2(7) and RESULT(7) = '1')
								or
								(OPERAND1(7) /= OPERAND2(7) and RESULT(7) = '0')
							)
		else 	0;


ZER_FLAG <= 		1 when RESULT = "00000000"
		else	0;

-- FIXME --
CAR_FLAG <= 		1 when ALU_CTRL = "000" and RESULT_TMP(8) = '1';
		else	1 when ALU_CTRL = "001" and RESULT_TMP(8) = '1';
		else	1 when ALU_CTRL = "010" and REULST_TMP(8) = '1';
		else	0;

end Behavioral;

