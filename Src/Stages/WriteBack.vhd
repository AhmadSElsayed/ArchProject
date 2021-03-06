LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.constants.all;

entity WriteBack is
	port(
		op : in std_logic_vector(4 downto 0);
		a, b: in std_logic_vector(15 downto 0);
		operation: out std_logic_vector(2 downto 0); -- 000 read 1 -- 001 read 2 -- 010 -write 1 -- 011 write 2
		RegisterValue1, RegisterValue2 : out std_logic_vector(15 downto 0)
	);
end WriteBack;

architecture NoHazards of WriteBack is
begin
	process(a,b,op)
	begin
		case op is 
			when OPCODE_MOV => RegisterValue1 <= a; operation <= "010";
			when OPCODE_ADD => RegisterValue1 <= a; operation <= "010";
			when OPCODE_MUL => RegisterValue1 <= a; RegisterValue2 <= b; operation <= "011";
			when OPCODE_SUB => RegisterValue1 <= a; operation <= "010";
			when OPCODE_AND => RegisterValue1 <= a; operation <= "010";
			when OPCODE_OR => RegisterValue1 <= a; operation <= "010";
			when OPCODE_RLC => RegisterValue1 <= a; operation <= "010";
			when OPCODE_RRC => RegisterValue1 <= a; operation <= "010";
			when OPCODE_SHL => RegisterValue1 <= a; operation <= "010";
			when OPCODE_SHR => RegisterValue1 <= a; operation <= "010";
			when OPCODE_POP => RegisterValue1 <= a; operation <= "010";
			when OPCODE_IN => RegisterValue1 <= a; operation <= "010";
			when OPCODE_NOT => RegisterValue1 <= a; operation <= "010";
			when OPCODE_NEG => RegisterValue1 <= a; operation <= "010";
			when OPCODE_INC => RegisterValue1 <= a; operation <= "010";
			when OPCODE_DEC => RegisterValue1 <= a; operation <= "010";
			when OPCODE_LDM => RegisterValue1 <= a; operation <= "010";
			when OPCODE_LDD => RegisterValue1 <= a; operation <= "010";
			when others => operation <= "100";
		end case;
		
	end process;
end architecture; -- NoHazards