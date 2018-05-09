LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Handler is
	
	port(
		clock : in std_logic;
		opcodeIn : in std_logic_vector(4 downto 0);
        operation , RegisterSrcAddress, RegisterDestAddress: in std_logic_vector (2 downto 0);
        RegisterSrcValue,  RegisterDestValue : inout std_logic_vector(15 downto 0);
        opcodeOut : out std_logic_vector(4 downto 0)
	);
end Handler;
architecture NoHazards of Handler is
type regs is array (5 downto 0) of std_logic_vector(15 downto 0);
signal R: regs;
begin
	process(clock)
	begin
		if rising_edge(clock) then
	     	case operation is 
            when "010" => R(to_integer(unsigned(RegisterDestAddress))) <= RegisterDestValue ; RegisterSrcValue <= (others => 'Z');
			when "011" =>  R(to_integer(unsigned(RegisterDestAddress))) <= RegisterDestValue ;  R(to_integer(unsigned(RegisterSrcAddress))) <= RegisterSrcValue;
			when others => RegisterDestValue <= (others => 'Z'); RegisterSrcValue <= (others => 'Z');

            end case;
        elsif falling_edge(clock) then  
            case operation is 
            when "000" => RegisterDestValue <= R(to_integer(unsigned(RegisterDestAddress))); RegisterSrcValue <= (others => 'Z');
			when "001" => RegisterDestValue<= R(to_integer(unsigned(RegisterDestAddress))); RegisterSrcValue<= R(to_integer(unsigned(RegisterSrcAddress)));
			when others => RegisterDestValue <= (others => 'Z'); RegisterSrcValue <= (others => 'Z');
            end case;
	end if;
opcodeOut <= opcodeIn;
	end process;
	
end architecture; -- NoHazards