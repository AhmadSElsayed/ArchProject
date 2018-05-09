LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.constants.all;

entity execution is
	port(
		rst : IN std_logic;
		a, b, c : IN std_logic_vector(15 DOWNTO 0);
		op : IN std_logic_vector(4 DOWNTO 0);
		x ,y, z : OUT std_logic_vector(15 DOWNTO 0)
	);
end entity execution;

architecture execute of execution is 
signal temp : std_logic_vector(31 downto 0);
signal carry, negative, zero : std_logic := '0';
begin
	process(a, b, op, rst)
	begin
		case op is
			when OPCODE_NOP		=> x <= a; y <= b; z <= c;
			when OPCODE_MOV		=> x <= a; y <= b; z <= c;
			when OPCODE_ADD		=> temp <= ('0' & a) + ('0' & b); x <= temp (15 downto 0); carry <= temp(16);
			when OPCODE_MUL		=> ;
			when OPCODE_SUB		=> ;
			when OPCODE_AND		=> ;
			when OPCODE_OR		=> ;
			when OPCODE_RLC		=> ;
			when OPCODE_RRC		=> ;
			when OPCODE_SHL		=> ;
			when OPCODE_SHR		=> ;
			when OPCODE_SETC	=> ;
			when OPCODE_CLRC	=> ;
			when OPCODE_PUSH	=> x <= a; y <= b z <= c;
			when OPCODE_POP		=> x <= a; y <= b z <= c;
			when OPCODE_OUT		=> x <= a; y <= b z <= c;
			when OPCODE_IN		=> x <= a; y <= b z <= c;
			when OPCODE_NOT		=> ;
			when OPCODE_NEG		=> ;
			when OPCODE_INC		=> ;
			when OPCODE_DEC		=> ;
			when OPCODE_JZ		=> ;
			when OPCODE_JN		=> ;
			when OPCODE_JC		=> ;
			when OPCODE_JMP		=> x <= a; y <= b z <= c;
			when OPCODE_CALL	=> x <= a; y <= b z <= c;
			when OPCODE_RET		=> x <= a; y <= b z <= c;
			when OPCODE_RTI		=> x <= a; y <= b z <= c;
			when OPCODE_LDM		=> x <= a; y <= b z <= c;
			when OPCODE_LDD		=> x <= a; y <= b z <= c;
			when OPCODE_STD		=> x <= a; y <= b z <= c;
			when OPCODE_ERRO	=> x <= a; y <= b z <= c;
		end case;
	end process;
end execute;