LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Processor is
	port(
		clock, interrupt: in std_logic;
		databus: inout std_logic_vector(15 downto 0)
	);
end Processor;

architecture NoHazards of Processor is
signal PC :std_logic_vector(9 downto 0);
signal Instruction, Instruction1, extras, extras1 :std_logic_vector(15 downto 0);
signal x, x1, y, y1, z, z1 :std_logic_vector(15 downto 0);
signal x2, y2, z2 :std_logic_vector(15 downto 0);
signal opcode, opcode1,opcode2: std_logic_vector(4 downto 0);
signal RegisterSourceAddress, RegisterDestAddress, RegisterSourceAddress1, RegisterDestAddress1 :std_logic_vector(2 downto 0);
signal RegisterSourceValue, RegisterDestValue, RegisterSourceValue1, RegisterDestValue1 :std_logic_vector(15 downto 0);
signal bufferde :std_logic_vector(58 downto 0);
signal bufferem :std_logic_vector(58 downto 0);
signal buffermw :std_logic_vector(58 downto 0);
signal operation, operation1 : std_logic_vector(2 downto 0);
begin
-- Components
PC: entity PC port map(clock, '0', PC, (others => 'Z'));
RegisterFile: entity RegisterFile port map(clock, operation,RegisterSourceAddress, RegisterDestAddress,RegisterSourceValue, RegisterDestValue);
Fetcher: entity Fetcher port map(PC, Instruction);
BufferF_D: entity Buffer port map(clock, Instruction, Instruction1) generic map(16);
Decoder: entity Decoder port map(Instruction1, opcode, RegisterSourceAddress, RegisterDestAddress, extras);
Handler_D : entity Handler port map (clock, opcode,operation,RegisterSourceValue, RegisterDestValue ,opcode1);
BufferD_E: entity Buffer port map(clock, opcode & RegisterSourceAddress & RegisterSourceValue & RegisterDestAddress & RegisterDestValue & extras, bufferde) generic map(59);
Execution: entity Execution port map(bufferde(58 downto 54), bufferde(50 downto 35), bufferde(31 downto 16), bufferde(15 downto 0), x, y, z);
BufferE_M: entity Buffer port map(clock, bufferde(58 downto 54) & bufferde(53 downto 51) & x & bufferde(34 downto 32) & y & z, bufferem) generic map(58);
Memory: entity Memory port map(bufferem(58 downto 54), bufferem(50 downto 35), bufferem(31 downto 16), bufferem(15 downto 0), x1, y1, z1);
BufferM_W: entity Buffer port map(clock, bufferem(58 downto 54) & bufferem(53 downto 51) & x1 & bufferem(34 downto 32) & y1 & z1, buffermw) generic map(58);
Handler_MW : entity Handler port map (clock,opcode1,bufferem(53 downto 51),buffermw(50 downto 35),buffermw(31 downto 16),opcode2);
WriteBack: entity WriteBack port map(buffermw(58 downto 54), buffermw(50 downto 35), buffermw(31 downto 16), buffermw(15 downto 0),bufferem(53 downto 51),RegisterSourceValue,RegisterDestValue );


end architecture;
