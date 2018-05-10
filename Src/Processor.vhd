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
signal opcode: std_logic_vector(4 downto 0);
signal RegisterSourceAddress, RegisterDestAddress, RegisterSourceAddress1, RegisterDestAddress1 :std_logic_vector(2 downto 0);
signal RegisterSourceValue, RegisterDestValue, RegisterSourceValue1, RegisterDestValue1 :std_logic_vector(15 downto 0);
signal bufferde, bufferde0 :std_logic_vector(58 downto 0);
signal bufferem, bufferem0 :std_logic_vector(58 downto 0);
signal buffermw, buffermw0 :std_logic_vector(58 downto 0);
signal operation, operation2: std_logic_vector(2 downto 0);

signal pcload : std_logic_vector(9 downto 0);
begin
-- Components
P: entity work.PC port map(clock, '0', PC, pcload);
Handler : entity work.Handler port map (clock, operation, operation2, RegisterSourceAddress, RegisterDestAddress, RegisterSourceValue, RegisterDestValue, RegisterSourceAddress1, RegisterDestAddress1, RegisterSourceValue1, RegisterDestValue1);
-- Stages
Fetcher: entity work.Fetcher port map(PC, Instruction);
BufferF_D: entity work.PipeBuffer generic map(16) port map(clock, Instruction, Instruction1);
Decoder: entity work.Decoder port map(Instruction1, opcode, RegisterSourceAddress, RegisterDestAddress, operation, extras);
BufferD_E: entity work.PipeBuffer generic map(59) port map(clock, bufferde0, bufferde);
Execution: entity work.Execution port map(bufferde(58 downto 54), bufferde(50 downto 35), bufferde(31 downto 16), bufferde(15 downto 0), x, y, z);
BufferE_M: entity work.PipeBuffer generic map(59) port map(clock, bufferem0, bufferem);
Memory: entity work.MemoryUnit port map(bufferem(58 downto 54), bufferem(50 downto 35), bufferem(31 downto 16), bufferem(15 downto 0), x1, y1, z1);
BufferM_W: entity work.PipeBuffer generic map(59) port map(clock, buffermw0, buffermw);
WriteBack: entity work.WriteBack port map(buffermw(58 downto 54), buffermw(50 downto 35), buffermw(31 downto 16), operation2, RegisterSourceValue1, RegisterDestValue1);

bufferde0 <= opcode & RegisterSourceAddress & RegisterSourceValue & RegisterDestAddress & RegisterDestValue & extras;
bufferem0 <= bufferde(58 downto 54) & bufferde(53 downto 51) & x & bufferde(34 downto 32) & y & z;
buffermw0 <= bufferem(58 downto 54) & bufferem(53 downto 51) & x1 & bufferem(34 downto 32) & y1 & z1;
RegisterSourceAddress1 <= buffermw(53 downto 51);
RegisterDestAddress1 <= buffermw(34 downto 32);

end architecture;