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
	-- instructions, respectively
	-- store the data from register1 to memory at the location 1 with base 0
	-- load the data from memory at the location 1 with base 0 to the register1
	-- add the data from the register1 and register1 to the register2
	constant memory_data: memory_type := (
		-- sd instruction
		-- imm   | src	  | base  | func3 | imm	 | opcode
		-- 31:25 | 24:20 | 19:15 | 14:12 | 11:7 | 6:0
		"00000000000100000000000000100011",
		-- ld instruction
		-- imm	| base  | width | dest | opcode
		-- 31:20 | 19:15 | 14:12 | 11:7 | 6:0
		"00000000000100000000000010000011",
		-- R type add
		-- funct7 | rs2   | rs1   | funct3 | rd   | opcode |
		-- 31:25  | 24:20 | 19:15 | 14:12  | 11:7 | 6:0
		"00000000000100001000000100110011",
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
		-- instruction output should be the value of memory_data array on the given index while PC is in bounds
		instruction 	<= memory_data(TO_INTEGER(UNSIGNED(memory_address)));
end Behavioral;
