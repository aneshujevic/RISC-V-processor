library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity processor is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC_OUT : out  STD_LOGIC_VECTOR (63 downto 0);
           ALU_RESULT : out  STD_LOGIC_VECTOR (63 downto 0));
end processor;

architecture Behavioral of processor is
	signal pc_current: STD_LOGIC_VECTOR (63 downto 0);
	signal pc_no_branch, pc_branch: STD_LOGIC_VECTOR (63 downto 0);
	signal jump_shift_left_1: STD_LOGIC_VECTOR (63 downto 0);
	signal pc_next: STD_LOGIC_VECTOR (63 downto 0);
	signal instruction: STD_LOGIC_VECTOR (31 downto 0);
	-- control output
	signal branch, mem_read, mem_to_reg, mem_write, ALUSrc, reg_write: STD_LOGIC;
	signal ALUOp: STD_LOGIC_VECTOR (1 downto 0);
	signal ALU_zero_and_branch: STD_LOGIC;
	signal read_data1, read_data2: STD_LOGIC_VECTOR (63 downto 0);
	signal mux_out_register_file: STD_LOGIC_VECTOR (63 downto 0);
	signal sign_extended_instruction: STD_LOGIC_VECTOR (63 downto 0);
	signal ALU_control_out: STD_LOGIC_VECTOR (3 downto 0);
	signal ALU_zero: STD_LOGIC;
	signal ALU_result_internal: STD_LOGIC_VECTOR (63 downto 0);
	signal read_data_data_memory: STD_LOGIC_VECTOR (63 downto 0);
	signal mux_out_data_memory: STD_LOGIC_VECTOR (63 downto 0);
begin
	process (CLK, RST)
	begin
		if (RST = '1') then
			pc_current <= x"0000000000000000";
		elsif (RISING_EDGE(CLK)) then
			pc_current <= pc_next;
		end if;
	end process;
	
	pc_no_branch <= STD_LOGIC_VECTOR(UNSIGNED(pc_current) + x"0000000000000004");
	jump_shift_left_1 <= sign_extended_instruction(62 downto 0) & '0';
	pc_branch <= STD_LOGIC_VECTOR(UNSIGNED(pc_current) + UNSIGNED(jump_shift_left_1));
	ALU_zero_and_branch <= branch AND ALU_zero;
	pc_next <= pc_no_branch when (ALU_zero_and_branch = '0') else pc_branch;
	
	-- instruction memory
	Instruction_memory: entity Instruction_memory
		port map (
			PC => pc_current,
			instruction => instruction
		);
		
	-- control unit
	control: entity control
	port map (
		instr7 => instruction (6 downto 0),
		ALUSrc => ALUSrc,
      MemtoReg => mem_to_reg,
      RegWrite => reg_write,
      MemRead => mem_read,
      MemWrite => mem_write,
      Branch => branch,
		ALUOp => ALUOp
	);
	
	mux_out_data_memory <= read_data_data_memory when (mem_to_reg = '1') else ALU_result_internal;
	-- registers file
	register_file: entity register_file
	port map (
		CLK => CLK,
		RST => RST,
		reg_write_en => reg_write,
		reg_write_addr => instruction (11 downto 7),
		reg_write_data => mux_out_data_memory,
		reg_read_addr_1 => instruction (19 downto 15),
		reg_read_data_1 => read_data1,
		reg_read_addr_2 => instruction (24 downto 20),
		reg_read_data_2 => read_data2
	);
	
	-- sign extension unit (imm_gen)
	imm_gen: entity imm_gen
	port map (
		instr => instruction,
		sign_extended_instr => sign_extended_instruction
	);
	
	-- alu control unit
	alu_control: entity ALU_control
	port map (
		ALUOp => ALUOp,
      funct7 => instruction (31 downto 25),
      funct3 => instruction (14 downto 12),
      ALU_control_out => ALU_control_out
	);
	
	mux_out_register_file <= read_data2 when (ALUSrc = '0') else sign_extended_instruction;
	-- alu unit
	alu: entity ALU
	port map (
		A => read_data1,
      B => mux_out_register_file,
      alu_control => ALU_control_out,
      alu_result => ALU_result_internal,
      zero => ALU_zero
	);
	
	-- data memory
	data_memory: entity data_memory
	port map (
		CLK => CLK,
      mem_write_en => mem_write,
      mem_read_en => mem_read,
      mem_write_data => read_data2,
      mem_access_addr => ALU_result_internal,
      mem_read_data => read_data_data_memory
	);

	-- out
	PC_OUT <= pc_current;
	ALU_RESULT <= alu_result_internal;
end Behavioral;

