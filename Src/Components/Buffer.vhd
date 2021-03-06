LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PipeBuffer is
	generic(n : integer := 16);
	port(
		clock : in std_logic;
		DataIn: in std_logic_vector(n-1 downto 0);
		DataOut: out std_logic_vector(n-1 downto 0)
	);
end PipeBuffer;

architecture NoHazards of PipeBuffer is
signal d : std_logic_vector(n-1 downto 0) := (others => '0');
begin
	process(clock)
	begin
		if falling_edge(clock) then
			d <= DataIn;
		end if;
	end process;
	DataOut <= d;
end architecture; -- NoHazards