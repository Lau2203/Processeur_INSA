LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.constants.ALL;
 
ENTITY RegisterFile_test IS
	GENERIC (
		test_reg_addr_0	: std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0) := "0000";
		test_reg_addr_1	: std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0) := "0001";
		test_reg_addr_2	: std_logic_vector(CONSTANT_REG_ADDR_SIZE - 1 downto 0) := "0010";
		
		data_to_be_written : std_logic_vector(CONSTANT_REG_SIZE - 1 downto 0) := "11110000"
	);
END RegisterFile_test;
 
ARCHITECTURE behavior OF RegisterFile_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         READ_REG_ADDR0 : IN  std_logic_vector(3 downto 0);
         READ_REG_ADDR1 : IN  std_logic_vector(3 downto 0);
         Q0 : OUT  std_logic_vector(7 downto 0);
         Q1 : OUT  std_logic_vector(7 downto 0);
         WRITE_REQ : IN  std_logic;
         WRITE_REG_ADDR : IN  std_logic_vector(3 downto 0);
         DATA : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal READ_REG_ADDR0 : std_logic_vector(3 downto 0) := (others => '0');
   signal READ_REG_ADDR1 : std_logic_vector(3 downto 0) := (others => '0');
   signal WRITE_REQ : std_logic := '0';
   signal WRITE_REG_ADDR : std_logic_vector(3 downto 0) := (others => '0');
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Q0 : std_logic_vector(7 downto 0);
   signal Q1 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          RST => RST,
          CLK => CLK,
          READ_REG_ADDR0 => READ_REG_ADDR0,
          READ_REG_ADDR1 => READ_REG_ADDR1,
          Q0 => Q0,
          Q1 => Q1,
          WRITE_REQ => WRITE_REQ,
          WRITE_REG_ADDR => WRITE_REG_ADDR,
          DATA => DATA
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
		-- RESET TO ALL ZEROS
		RST	<= '0';
      wait for 100 ns;
		
		RST	<= '1';
		
		
		-- TEST READ AT ADDRESSES test_reg_addr_0 and test_reg_addr_1
		READ_REG_ADDR0 <=	test_reg_addr_0;
		READ_REG_ADDR1 <=	test_reg_addr_1;
		
		WRITE_REQ <= '0';	-- We do not write
		wait for 100 ns;
		
		
		
		
		-- TEST WRITE AT ADDRESS test_reg_addr_0 AND READ AT test_reg_addr_0 AND test_reg_addr_1
		READ_REG_ADDR0 <=	test_reg_addr_0;
		READ_REG_ADDR1 <=	test_reg_addr_1;
		
		WRITE_REQ <= '1';	-- We do not write
		WRITE_REG_ADDR	<= test_reg_addr_0;
		DATA	<= data_to_be_written;
		wait for 100 ns;
		
		
		
		
		-- TEST WRITE AT ADDRESS test_reg_addr_2 AND READ AT test_reg_addr_0 AND test_reg_addr_1
		READ_REG_ADDR0 <=	test_reg_addr_0;
		READ_REG_ADDR1 <=	test_reg_addr_1;
		
		WRITE_REQ <= '1';	-- We do not write
		WRITE_REG_ADDR	<= test_reg_addr_2;
		DATA	<= data_to_be_written;
		wait for 100 ns;
		
		
		
		
		-- TEST READ AT ADDRESSES test_reg_addr_2
		READ_REG_ADDR0 <=	test_reg_addr_0;
		READ_REG_ADDR1 <=	test_reg_addr_2;
		
		WRITE_REQ <= '0';	-- We do not write
		wait for 100 ns;

   end process;

END;
