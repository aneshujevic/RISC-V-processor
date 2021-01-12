library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity imm_gen is
    Port ( instr : in  STD_LOGIC_VECTOR (31 downto 0);
           sign_extended_instr : out  STD_LOGIC_VECTOR (63 downto 0));
end imm_gen;

-- sign extending unit
-- extends the instruction for the sign that is on 32nd bit
architecture Behavioral of imm_gen is
	signal tmp: STD_LOGIC_VECTOR (51 downto 0);
begin
	process (instr)
	begin
		tmp <= (others => instr(31));
	end process;
	sign_extended_instr <= tmp & instr(31 downto 20);
end Behavioral;

