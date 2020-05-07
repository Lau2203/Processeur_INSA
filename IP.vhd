library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity IP is
	Port(
		CLK		: in	STD_LOGIC;
		RST		: in	STD_LOGIC;
		
		ADDR	: out  	STD_LOGIC_VECTOR (CONSTANT_INST_MEMORY_ADDR_SIZE - 1 downto 0)
	);
end IP;

architecture Behavioral of IP is

signal currentADDR : STD_LOGIC_VECTOR (CONSTANT_INST_MEMORY_ADDR_SIZE - 1 downto 0) := (others => '0');

begin

	process(clk)
	begin
		if falling_edge(clk) then
			if RST = '0' then
				currentADDR <= (others => '0');
			else
				currentADDR <= currentADDR + 1;
			end if;
			ADDR <= currentADDR;
		end if;
	end process;

end Behavioral;

