LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
	port(
		clock : in std_logic;
		operation: in std_logic_vector(2 downto 0);
		RegisterAddress1, RegisterAddress2 : in std_logic_vector(02 downto 0);
		RegisterValue1, RegisterValue2 : in std_logic_vector(15 downto 0);
		RegisterOut: out std_logic_vector(15 downto 0)
	);
end RegisterFile;

architecture NoHazards of RegisterFile is
signal R0: std_logic_vector(15 downto 0);
signal R1: std_logic_vector(15 downto 0);
signal R2: std_logic_vector(15 downto 0);
signal R3: std_logic_vector(15 downto 0);
signal R4: std_logic_vector(15 downto 0);
signal R5: std_logic_vector(15 downto 0);
signal R6: std_logic_vector(15 downto 0);
signal R7: std_logic_vector(15 downto 0);
begin
	process(clock)
		if(rising_edge(clock)) then
			
		elsif(falling_edge(clock)) then
			
		end if;
	end process;
end architecture; -- NoHazards