LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Fetcher is
	port(
		PC : in std_logic_vector(9 downto 0);
		Instruction : out std_logic_vector(15 downto 0)
	);
end Fetcher;

architecture NoHazards of Fetcher is
type mem is array (1023 downto 0) of std_logic_vector(15 downto 0);
signal memory: mem;
begin

Instruction <= memory(to_integer(unsigned(PC)));

end architecture; -- NoHazards