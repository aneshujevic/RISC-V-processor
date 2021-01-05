library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity ALU_control is
    Port ( ALUOp : in  STD_LOGIC_VECTOR (1 downto 0);
           funct7 : in  STD_LOGIC_VECTOR (6 downto 0);
           funct3 : in  STD_LOGIC_VECTOR (2 downto 0);
           ALU_control_out : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU_control;

architecture Behavioral of ALU_control is
begin
	process(ALUOp, funct7, funct3)
	begin
		case ALUOp is
		-- ALUOp is 00 for ld and sd and we don't care about funct7 or funct3
		when "00" =>
			ALU_control_out <= "0010";
		-- ALUOp is 10 for R type instructions
		when "10" =>
			-- if funct7 is all zeroes and funct3 is all zeroes then ALU should do add operation
			-- other operations are not supported at the moment
			if (funct7 = "0000000" and funct3 = "000") then
				ALU_control_out <= "0010";
			end if;
		when others => ALU_control_out <= "0000";
		end case;
	end process;
end Behavioral;
