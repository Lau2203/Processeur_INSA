library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
<<<<<<< HEAD
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity Pipeline is
    Port (
				CLK					: in 	STD_LOGIC;
				RST					: in	STD_LOGIC;
				
				OPERAND_A_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				OPCODE_IN			: in	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);
				
				OPERAND_B_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				OPERAND_C_IN		: in	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				
				
				OPERAND_A_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				
				OPCODE_OUT			: out	STD_LOGIC_VECTOR (CONSTANT_OPCODE_SIZE - 1 downto 0);
				
				OPERAND_B_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0);
				OPERAND_C_OUT		: out	STD_LOGIC_VECTOR (CONSTANT_OPERAND_SIZE - 1 downto 0)
			);
end Pipeline;

architecture Behavioral of Pipeline is

begin

	process (clk)
		begin
			if rising_edge(clk) then
			
				if RST = '0' then
					OPERAND_A_OUT 	<= (others => '0');
					OPCODE_OUT 		<= (others => '0');
					OPERAND_B_OUT 	<= (others => '0');
					OPERAND_C_OUT 	<= (others => '0');
					
				else
					OPERAND_A_OUT	<= OPERAND_A_IN;
					OPCODE_OUT		<= OPCODE_IN;
					OPERAND_B_OUT	<= OPERAND_B_IN;
					OPERAND_C_OUT	<= OPERAND_C_IN;
					
				end if;
			end if;
		end process;

end Behavioral;

=======

//A chaque tic d'horloge, le rôle du pipeline est de propager les entrées
entity Pipeline is

    Port 
			  OPin : in  std_logic_vector(7 downto 0);
           Ain : in  std_logic_vector(7 downto 0);
           Bin : in  std_logic_vector(7 downto 0);
           Cin : in  std_logic_vector(7 downto 0);
           OPout : out  std_logic_vector(7 downto 0);
           Aout : out  std_logic_vector(7 downto 0);
           Bout : out  std_logic_vector(7 downto 0);
           Cout : out  std_logic_vector(7 downto 0)
	);
end Pipeline;

architecture Behavioral of Pipeline is
begin
	process (clk)
	begin
		if clk'event and clk = '1' then
			OPout <= OPin;
			Aout <= Ain;
			Bout <= Bin;
			Cout <= Cin;
	end process;
end Behavioral;
>>>>>>> 1ce0e57cea54c23407654ddef37a50a3b15c9c3d
