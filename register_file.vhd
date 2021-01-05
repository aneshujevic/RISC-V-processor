library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           reg_write_en : in  STD_LOGIC;
           reg_write_addr : in  STD_LOGIC_VECTOR (4 downto 0);
           reg_write_data : in  STD_LOGIC_VECTOR (63 downto 0);
           reg_read_addr_1 : in  STD_LOGIC_VECTOR (4 downto 0);
           reg_read_data_1 : out  STD_LOGIC_VECTOR (63 downto 0);
           reg_read_addr_2 : in  STD_LOGIC_VECTOR (4 downto 0);
           reg_read_data_2 : out  STD_LOGIC_VECTOR (63 downto 0));
end register_file;

architecture Behavioral of register_file is
	-- register type
	type reg_type is array (0 to 31) of STD_LOGIC_VECTOR (63 downto 0);
	signal reg_array: reg_type;
begin
	-- clock and reset sensitive process
	-- when reseting set them to arbitrary data
	process(CLK, RST)
	begin
	if (RST = '1') then
		reg_array(0) <= x"0000000000000001";
		reg_array(1) <= x"0000000000000002";
		reg_array(2) <= x"0000000000000003";
		reg_array(3) <= x"0000000000000004";
		reg_array(4) <= x"0000000000000005";
		reg_array(5) <= x"0000000000000006";
		reg_array(6) <= x"0000000000000007";
		reg_array(7) <= x"0000000000000008";
		reg_array(8) <= x"0000000000000009";
		reg_array(9) <= x"000000000000000a";
		reg_array(10) <= x"000000000000000b";
		reg_array(11) <= x"000000000000000c";
		reg_array(12) <= x"000000000000000d";
		reg_array(13) <= x"000000000000000e";
		reg_array(14) <= x"000000000000000f";
		reg_array(15) <= x"0000000000000010";
		reg_array(16) <= x"0000000000000011";
		reg_array(17) <= x"0000000000000012";
		reg_array(18) <= x"0000000000000013";
		reg_array(19) <= x"0000000000000014";
		reg_array(20) <= x"0000000000000015";
		reg_array(21) <= x"0000000000000016";
		reg_array(22) <= x"0000000000000017";
		reg_array(23) <= x"0000000000000018";
		reg_array(24) <= x"0000000000000019";
		reg_array(25) <= x"000000000000001a";
		reg_array(26) <= x"000000000000001b";
		reg_array(27) <= x"000000000000001c";
		reg_array(28) <= x"000000000000001d";
		reg_array(29) <= x"000000000000001e";
		reg_array(30) <= x"000000000000001f";
		reg_array(31) <= x"0000000000000020";
		-- if we're on rising edge and we should write to the register
		-- write the reg_write_data to the register in address given by reg_write_addr
	elsif (RISING_EDGE(CLK)) then
		if (reg_write_en = '1') then
			reg_array(TO_INTEGER(UNSIGNED(reg_write_addr))) <= reg_write_data;
		end if;
	end if;
	end process;
	-- if the address of the registers to read from is 00000 return all zeroes, otherwise return the data from the address specified
	reg_read_data_1 <= x"0000000000000000" when reg_read_addr_1 = "00000" else reg_array(TO_INTEGER(UNSIGNED(reg_read_addr_1)));
	reg_read_data_2 <= x"0000000000000000" when reg_read_addr_2 = "00000" else reg_array(TO_INTEGER(UNSIGNED(reg_read_addr_2)));
end Behavioral;

