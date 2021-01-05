library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control is
    Port ( instr7 : in  STD_LOGIC_VECTOR (6 downto 0);
           ALUSrc : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUOp : out  STD_LOGIC_VECTOR (1 downto 0));
end control;

architecture Behavioral of control is
begin
	process (instr7)
	begin
		case instr7 is
		when "0110011" =>
			ALUSrc <= '0';
         MemtoReg <= '0';
         RegWrite <= '1';
         MemRead <= '0';
         MemWrite <= '0';
         Branch <= '0';
         ALUOp <= "10";
		when "0000011" =>
			ALUSrc <= '1';
         MemtoReg <= '1';
         RegWrite <= '1';
         MemRead <= '1';
         MemWrite <= '0';
         Branch <= '0';
         ALUOp <= "00";
		when "0100011" =>
			ALUSrc <= '1';
         MemtoReg <= '0'; -- could be 1, doesn't matter
         RegWrite <= '0';
         MemRead <= '0';
         MemWrite <= '1';
         Branch <= '0';
         ALUOp <= "00";
		when "1100011" =>
			ALUSrc <= '0';
         MemtoReg <= '0'; -- could be 1, doesn't matter
         RegWrite <= '0';
         MemRead <= '0';
         MemWrite <= '0';
         Branch <= '1';
         ALUOp <= "01";
		when others =>
			ALUSrc <= '0';
         MemtoReg <= '0';
         RegWrite <= '1';
         MemRead <= '0';
         MemWrite <= '0';
         Branch <= '0';
         ALUOp <= "00";
		end case;
	end process;
end Behavioral;
