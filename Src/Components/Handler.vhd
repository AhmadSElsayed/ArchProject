LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Handler is
	port(
		operation1, operation2: in std_logic_vector(2 downto 0);
		radd1,radd2 : in std_logic_vector(2 downto 0);
		rsrc, rdst: out std_logic_vector(15 downto 0);
		radd3,radd4 : in std_logic_vector(2 downto 0);
		rsrc1, rdst1: in std_logic_vector(15 downto 0)
	);
end Handler;

architecture NoHazards of Handler is

begin
--RegisterFile: entity RegisterFile port map();
rdst <= rdst1;


end architecture; -- NoHazards