--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:44:09 05/07/2020
-- Design Name:   
-- Module Name:   /home/aurelien/INSA/CompilationAndProcessor/Processor_INSA/MainProcessor_test.vhd
-- Project Name:  Processor_INSA_Xilinx
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MainProcessor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.constants.ALL;
 
ENTITY MainProcessor_test IS
END MainProcessor_test;
 
ARCHITECTURE behavior OF MainProcessor_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MainProcessor
    PORT(
         MainProcessor_CLK		: IN  std_logic;
		 MainProcessor_RST		: IN  std_logic;
		 
		 MainProcessor_P1		: OUT	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		 MainProcessor_P2		: OUT	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		 MainProcessor_P3		: OUT	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		 MainProcessor_P4		: OUT	std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0);
		 
         MainProcessor_OUTPUT	: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal MainProcessor_CLK : std_logic := '0';
   signal MainProcessor_RST : std_logic := '0';

 	--Outputs
	signal MainProcessor_P1		: std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0) := (others => '0');
	signal MainProcessor_P2		: std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0) := (others => '0');
	signal MainProcessor_P3		: std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0) := (others => '0');
	signal MainProcessor_P4		: std_logic_vector(CONSTANT_INSTRUCTION_SIZE - 1 downto 0) := (others => '0');
	signal MainProcessor_OUTPUT : std_logic;

   -- Clock period definitions
   constant MainProcessor_CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: MainProcessor PORT MAP (
			MainProcessor_CLK		=> MainProcessor_CLK,
			MainProcessor_RST		=> MainProcessor_RST,

			MainProcessor_P1		=> MainProcessor_P1,
			MainProcessor_P2		=> MainProcessor_P2,
			MainProcessor_P3		=> MainProcessor_P3,
			MainProcessor_P4		=> MainProcessor_P4,

			MainProcessor_OUTPUT	=> MainProcessor_OUTPUT
		);

   -- Clock process definitions
   MainProcessor_CLK_process :process
   begin
		MainProcessor_CLK <= '0';
		wait for MainProcessor_CLK_period/2;
		MainProcessor_CLK <= '1';
		wait for MainProcessor_CLK_period/2;
   end process;

	tb: process
	begin
		
		MainProcessor_RST <= '0';
		wait for 110 ns;
		
		
		MainProcessor_RST <= '1';
		wait;
	end process;
	


END;
