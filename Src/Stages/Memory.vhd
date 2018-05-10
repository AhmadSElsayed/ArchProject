LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.constants.all;

entity MemoryUnit is
	port (
		op: in std_logic_vector(4 downto 0);
		a, b, c : in std_logic_vector(15 downto 0);
		x, y, z: out std_logic_vector(15 downto 0)
	);
end MemoryUnit ;

architecture NoHazards of MemoryUnit is
------------------------------------- RAM declaration 
type mem is array (0 to 1023) of std_logic_vector(15 downto 0);
signal memory: mem;
signal StackPointer : std_logic_vector(9 downto 0) := "1111111111";
-------------------------------------- 
begin	
process(op)
	begin
		case op is
		when OPCODE_LDD => x <= memory(conv_integer(c(9 downto 0))) ; 
		when OPCODE_STD => memory(conv_integer(c(9 downto 0))) <= a ; 
		when OPCODE_PUSH=> StackPointer <= StackPointer - 1; memory(conv_integer(StackPointer))<=a ;
		when OPCODE_POP => StackPointer <= StackPointer + 1;x <= memory(conv_integer(StackPointer));
		when others => x <= a; y <= b; z <= c;
		end case;
	end process;

end NoHazards; -- NoHazards
