library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_memory is
Port (PC : in STD_LOGIC_VECTOR(63 downto 0);
		instruction : out	STD_LOGIC_VECTOR(31 downto 0));
end Instruction_memory;

architecture Behavioral of Instruction_memory is
	-- memory address inside of instruction memory
	signal 	memory_address: STD_LOGIC_VECTOR(4 downto 0);
	-- type representing instruction memory
	type 		memory_type	is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
	-- the content of instruction memory
	constant memory_data: memory_type := (
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000",
		"00000000000000000000000000000000"
	);
	begin
		-- last two bits needed to address 4bytes of memory i.e. to get the next address we add 4 on the current address 
		memory_address <= PC(6 downto 2);
		-- instruction output will be the value of memory_data array on the given index while PC is in bounds
		instruction 	<= memory_data(TO_INTEGER(UNSIGNED(memory_address))) when PC < x"0000000000000200" else x"00000000";
end Behavioral;