library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (63 downto 0);
           B : in  STD_LOGIC_VECTOR (63 downto 0);
           alu_control : in  STD_LOGIC_VECTOR (3 downto 0);
           alu_result : out  STD_LOGIC_VECTOR (63 downto 0);
           zero : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	signal result: STD_LOGIC_VECTOR(63 downto 0);
begin
	process(alu_control, A, B)
	begin
		case alu_control is
		when "0000" =>
			result <= A AND B; -- AND operation
		when "0001" =>
			result <= A OR B; -- OR operation
		when "0010" =>
			result <= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B)); -- add operation
		when "0110" =>
			result <= STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B)); -- sub operation
		when others =>
			result <= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B)); -- if operation not specified, add A and B
		end case;
	end process;
	zero <= '1' when (result = x"0000000000000000") else '0';
	alu_result <= result;
end Behavioral;
