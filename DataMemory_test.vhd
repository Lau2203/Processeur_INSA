LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DataMemory_test IS
END DataMemory_test;
 
ARCHITECTURE behavior OF DataMemory_test IS 
 
	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT DataMemory
	PORT(
			ADDR : IN  std_logic_vector(7 downto 0);
			DATA : IN  std_logic_vector(7 downto 0);
			RW : IN  std_logic;
			RST : IN  std_logic;
			CLK : IN  std_logic;
			OUTPUT : OUT  std_logic_vector(7 downto 0)
		);
	END COMPONENT;
    

	--Inputs
	signal ADDR : std_logic_vector(7 downto 0) := (others => '0');
	signal DATA : std_logic_vector(7 downto 0) := (others => '0');
	signal RW : std_logic := '0';
	signal RST : std_logic := '0';
	signal CLK : std_logic := '0';

	--Outputs
	signal OUTPUT : std_logic_vector(7 downto 0);

	-- Clock period definitions
	constant CLK_period : time := 10 ns;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: DataMemory PORT MAP (
			ADDR => ADDR,
			DATA => DATA,
			RW => RW,
			RST => RST,
			CLK => CLK,
			OUTPUT => OUTPUT
        );

	-- Clock process definitions
	CLK_process :process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;


	tb: process
	begin	
		wait for 100 ns;
		
		RST	<= '0';
		wait for 100 ns;	
		
	  -- TEST READ MEMORY AT ADDRESS "000000001"
		RST	<= '1';
		ADDR	<= "00000001";
		RW		<=	'1';			-- READ
		wait for 100 ns;
		
		-- TEST WRITE MEMORY AT ADDRESS "000000001"
		RST	<= '1';
		ADDR	<= "00000001";
		RW		<=	'0';			-- WRITE
		DATA	<= "11110001";
		wait for 100 ns;
		
		-- TEST READ MEMORY AT ADDRESS "000000001"
		RST	<= '1';
		ADDR	<= "00000001";
		RW		<=	'1';			-- READ
		wait for 100 ns;
		
	end process;

END;
