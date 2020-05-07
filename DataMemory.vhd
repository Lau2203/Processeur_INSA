library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.constants.ALL;

entity DataMemory is
	
    Port (
			ADDR 	: in  	STD_LOGIC_VECTOR (CONSTANT_DATA_MEMORY_ADDR_SIZE - 1 downto 0);	--< The address of memory which will be read or overwritten
			DATA 	: in  	STD_LOGIC_VECTOR (CONSTANT_DATA_MEMORY_SLOT_SIZE - 1 downto 0);	--< Data to be written into memory when RW = '0'
			RW 		: in  	STD_LOGIC;														--< Flag : '1' to read from memory and '0' to write data to memory
			RST 	: in  	STD_LOGIC;														--< Reset the memory to '0' when RST = '0'
			CLK 	: in  	STD_LOGIC;														--< CLK
			OUTPUT	: out  	STD_LOGIC_VECTOR (CONSTANT_DATA_MEMORY_SLOT_SIZE - 1 downto 0)	--> Data read from memory (when RW = '1')
	);	
end DataMemory;

architecture Behavioral of DataMemory is

	type mem_type is array (0 to CONSTANT_DATA_MEMORY_SIZE - 1) of STD_LOGIC_VECTOR (CONSTANT_DATA_MEMORY_SLOT_SIZE - 1 downto 0);

	signal MEMORY : mem_type;

begin

	-- Reading, writing and resetting are clock-synchronized
	process (clk)
		begin
			if falling_edge(clk) then
				-- When RST is active on '0', the memory is reset to 0x00 values
				if RST = '0' then
					MEMORY <= (others => (others => '0'));
					
				else 
					-- READ
					if RW = CONSTANT_DATA_MEMORY_READ_FLAG then
						OUTPUT <= MEMORY(to_integer(unsigned(addr)));
						
					-- WRITE (elsif RW = CONSTANT_DATA_MEMORY_WRITE_FLAG)
					else
						MEMORY(to_integer(unsigned(addr))) <= DATA;
						
					end if;
				end if;
			end if;	
		end process;


end Behavioral;

