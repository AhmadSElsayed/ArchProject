LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
	port(
		clock, mode: in std_logic;
		PC: out std_logic_vector(9 downto 0);
		data : inout std_logic_vector(9 downto 0)
	);
end PC;

architecture NoHazards of PC is
signal address : std_logic_vector(9 downto 0);
begin
	process(clock)
	begin
		if rising_edge(clock) and mode = '0' then 
			address <= address + 1;
		elsif rising_edge(clock) and mode = '1' then
			address <= data;
		end if;
	end process;
	pc <= address;
end architecture; -- NoHazards