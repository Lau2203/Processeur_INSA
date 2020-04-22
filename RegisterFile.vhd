library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
	generic(register_nb : Natural := 16;
		register_size : Natural := 8);
    Port ( WRITE_REQ : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           READ_REG_ADDR0 : in  STD_LOGIC_VECTOR (3 downto 0);
           READ_REG_ADDR1 : in  STD_LOGIC_VECTOR (3 downto 0);
           WRITE_REG_ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           Q0 : out  STD_LOGIC_VECTOR (7 downto 0);
           Q1 : out  STD_LOGIC_VECTOR (7 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is
	
	signal REGISTERS : STD_LOGIC_VECTOR((register_nb * register_size - 1) downto 0);

begin
	
	-- LECTURE ASYNCHRONE
	-- Si écriture et lecture sur le même registre, alors QA ou QB <= DATA 
	-- Sinon (else) on va procéder à une lecture simple 
	Q0 <= DATA when ((WRITE_REQ='1') and (READ_REG_ADDR0 = WRITE_REG_ADDR)) else
		   REGISTERS((to_integer(unsigned(READ_REG_ADDR0)) + 1) * register_size - 1 downto to_integer(unsigned(READ_REG_ADDR0 * register_size));
	Q1 <= DATA when ((WRITE_REQ='1') and (READ_REG_ADDR1 = WRITE_REG_ADDR)) else
	      REGISTERS((to_integer(unsigned(READ_REG_ADDR0)) + 1) * register_size - 1 downto to_integer(unsigned(READ_REG_ADDR0 * register_size));

	-- ECRITURE SYNCHRONE
	process (clk) 
	begin
		if clk'event and clk = '1' then
			-- Quand le signal RST est actif à '0', le contenu du BR est initialisé à 0x00.
			if RST = '0' then
				REGISTERS <= others => '0';
			else -- Ecriture simple
				if WRITE_REQ = '1' then
					REGISTERS((to_integer(unsigned(WRITE_REG_ADDR) + 1) * register_size - 1) downto (to_integer(unsigned(WRITE_REG_ADDR)) * register_size)) <= DATA;
				end if;
			end if;
		end if;	
	end process;
	

end Behavioral;

