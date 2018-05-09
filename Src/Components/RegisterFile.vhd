LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
	port(
		clock : in std_logic;
		operation: in std_logic_vector(2 downto 0); -- 000 read 1 -- 001 read 2 -- 010 -write 1 -- 011 write 2
		RegisterAddress1, RegisterAddress2 : in std_logic_vector(02 downto 0);
		RegisterValue1, RegisterValue2 : inout std_logic_vector(15 downto 0)
	);
end RegisterFile;

architecture NoHazards of RegisterFile is
type regs is array (5 downto 0) of std_logic_vector(15 downto 0);
signal R: regs;
begin
	process(clock)
	begin
		if rising_edge(clock) then
			case operation is 
				when "010" => R(to_integer(unsigned(RegisterAddress1))) <= RegisterValue1; RegisterValue2 <= (others => 'Z');
				when "011" => R(to_integer(unsigned(RegisterAddress1))) <= RegisterValue1; R(to_integer(unsigned(RegisterAddress2))) <= RegisterValue2;
				when others => RegisterValue1 <= (others => 'Z'); RegisterValue2 <= (others => 'Z');
			end case;
		elsif falling_edge(clock) then
			case operation is 
				when "000" => RegisterValue1 <= R(to_integer(unsigned(RegisterAddress1))); RegisterValue2 <= (others => 'Z');
				when "001" => RegisterValue2 <= R(to_integer(unsigned(RegisterAddress1))); RegisterValue2 <= R(to_integer(unsigned(RegisterAddress2)));
				when others => RegisterValue1 <= (others => 'Z'); RegisterValue2 <= (others => 'Z');
			end case;
		end if;
	end process;
end architecture; -- NoHazards