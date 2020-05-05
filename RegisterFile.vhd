library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity RegisterFile is

    Port (
			RST 			: in  	STD_LOGIC;												--< All the registers are set to '0' when RST is active on '0'
			CLK 			: in  	STD_LOGIC;												--< CLK
			  
			READ_REG_ADDR0 	: in  	STD_LOGIC_VECTOR (CONSTANT_REG_ADDR_SIZE - 1 downto 0);	--< The address of the first register to be read
			READ_REG_ADDR1 	: in  	STD_LOGIC_VECTOR (CONSTANT_REG_ADDR_SIZE - 1 downto 0);	--< The address of the second register to be read
			  
			Q0 				: out  	STD_LOGIC_VECTOR (CONSTANT_DATA_SIZE - 1 downto 0);		--> The data of the first register to be read
			Q1 				: out  	STD_LOGIC_VECTOR (CONSTANT_DATA_SIZE - 1 downto 0);		--> The data of the second register to be read
			  
			WRITE_REQ 		: in  	STD_LOGIC;												--< Flag to be set to '1' when DATA must overwrite a register
			WRITE_REG_ADDR 	: in  	STD_LOGIC_VECTOR (CONSTANT_REG_ADDR_SIZE - 1 downto 0);	--< The address of the register to be overwritten with DATA
			DATA 			: in  	STD_LOGIC_VECTOR (CONSTANT_DATA_SIZE - 1 downto 0)		--< The data to be written in the register at address WRITE_REG_ADDR
	);
end RegisterFile;

architecture Behavioral of RegisterFile is

	type reg_mem_type is array (0 to CONSTANT_REG_NB - 1) of STD_LOGIC_VECTOR (CONSTANT_REG_SIZE - 1 downto 0);

	signal REGISTERS : reg_mem_type;

begin
	
	-- Asynchronous reading
	-- If one register is to be both read and overwritten, then we output the new data (Q0 <= DATA)
	-- Otherwise it is a mild reading operation for the output Q0 and Q1
	Q0 <= DATA when ((WRITE_REQ='1') and (READ_REG_ADDR0 = WRITE_REG_ADDR)) else
		   REGISTERS(to_integer(unsigned(READ_REG_ADDR0)));
			
	Q1 <= DATA when ((WRITE_REQ='1') and (READ_REG_ADDR1 = WRITE_REG_ADDR)) else
	      REGISTERS(to_integer(unsigned(READ_REG_ADDR1)));

	-- Synchronized writing
	process (clk) 
	begin
		if clk'event and clk = '1' then
			-- When RST is active on '0', the register file is reset to 0x00 values
			if RST = '0' then
				REGISTERS <= (others => (others => '0'));
				
			else -- Mild writing operation
				if WRITE_REQ = '1' then
					REGISTERS(to_integer(unsigned(WRITE_REG_ADDR))) <= DATA;
				end if;
			end if;
		end if;	
	end process;
	

end Behavioral;

