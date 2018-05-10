LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Handler is
	port(
		clock : in std_logic; 
		operation1, operation2: in std_logic_vector(2 downto 0);
		radd1,radd2 : in std_logic_vector(2 downto 0);
		rsrc, rdst: out std_logic_vector(15 downto 0);
		radd3,radd4 : in std_logic_vector(2 downto 0);
		rsrc1, rdst1: in std_logic_vector(15 downto 0)
	);
end Handler;

architecture NoHazards of Handler is
type regs is array (5 downto 0) of std_logic_vector(15 downto 0);
signal R: regs;
begin
	process(clock)
	begin
		if falling_edge(clock) then
			case operation2 is 
				when "010" => R(to_integer(unsigned(radd3))) <= rsrc1;
				when "011" => R(to_integer(unsigned(radd3))) <= rsrc1; R(to_integer(unsigned(radd4))) <= rdst1;
				when others => null;
			end case;
		elsif rising_edge(clock) then
			case operation1 is 
				when "000" => rsrc <= R(to_integer(unsigned(radd1))); rdst <= (others => 'Z');
				when "001" => rsrc<= R(to_integer(unsigned(radd1))); rdst <= R(to_integer(unsigned(radd2)));
				when others => rsrc <= (others => 'Z'); rdst <= (others => 'Z');
			end case;
		end if;
	end process;
end architecture; -- NoHazards