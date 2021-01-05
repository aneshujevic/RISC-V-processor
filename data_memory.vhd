library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_memory is
    Port ( CLK : in  STD_LOGIC;
           mem_write_en : in  STD_LOGIC;
           mem_read_en : in  STD_LOGIC;
           mem_write_data : in  STD_LOGIC_VECTOR (63 downto 0);
           mem_access_addr : in  STD_LOGIC_VECTOR (63 downto 0);
           mem_read_data : out  STD_LOGIC_VECTOR (63 downto 0));
end data_memory;

architecture Behavioral of data_memory is
	-- 8 mega of memory addressed with 16 bits :)
	signal ram_addr : STD_LOGIC_VECTOR(15 downto 0);
	-- RAM memory type
	type memory_type is array (0 to 65535) of STD_LOGIC_VECTOR (63 downto 0);
	-- initialise it all to zeroes
	signal RAM: memory_type := ((others => (others => '0')));
begin
	-- last four bits are needed for addressing inside of one row of memory which is 64 bits length
	ram_addr <= mem_access_addr(19 downto 4);
	process (CLK)
	begin
		if (rising_edge(CLK)) then
			-- if we should write to the memory we write the mem_write_data to the location in RAM provided by ram_addr
			if (mem_write_en = '1') then
				RAM(TO_INTEGER(UNSIGNED(ram_addr))) <= mem_write_data;
			end if;
		end if;
	end process;
	-- if we should read the data then we're forwarding the data from RAM in address provided by ram_addr to mem_read_data which is output
	mem_read_data <= RAM(TO_INTEGER(UNSIGNED(ram_addr))) when (mem_read_en = '1') else x"0000000000000000";
end Behavioral;
