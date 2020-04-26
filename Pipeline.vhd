library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
