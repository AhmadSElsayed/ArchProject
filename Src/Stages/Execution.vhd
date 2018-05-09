LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.Constants.all;

entity execution is
	port(
		op : IN std_logic_vector(4 DOWNTO 0);
		a, b, c : IN std_logic_vector(15 DOWNTO 0);
		x ,y, z : OUT std_logic_vector(15 DOWNTO 0)
	);
end entity execution;

architecture execute of execution is 
signal carry, negative, zero : std_logic := '0';
begin
	process(a, b,c, op)
	variable temp : std_logic_vector(31 downto 0);
	begin
		case op is
			when OPCODE_NOP		=> x <= a; y <= b; z <= c;
			when OPCODE_MOV		=> x <= a; y <= b; z <= c;
			when OPCODE_ADD		=> temp := "000000000000000"&(('0' & a) + ('0' & b)); x <= temp (15 downto 0); carry <= temp(16);negative <= temp(15); 
			when OPCODE_MUL		=> temp :=  std_logic_vector(unsigned(a) * unsigned(b)); x <= temp(31 downto 16); y <= temp (15 downto 0); negative <= temp(31);
			when OPCODE_SUB		=> temp := "000000000000000"&('0' & a) - ('0' & b);  x <= temp (15 downto 0); carry <= temp(16);carry <= temp(16); negative <= temp(15);
			when OPCODE_AND		=> temp := "0000000000000000"&((a AND b)); x<=temp(15 downto 0);  negative <= temp(15);
			when OPCODE_OR		=> temp := "0000000000000000"&((a OR b));  x<=temp(15 downto 0); negative <= temp(15);
			when OPCODE_RLC		=> temp := "000000000000000"&a(0)& carry&a(15 downto 1); x <= temp(15 downto 0); carry <= temp(16); negative <= temp(15);
			when OPCODE_RRC		=> temp := "000000000000000"&a(14 downto 0)&carry& a(15); x <= temp(16 downto 1); carry <= temp(0); negative <= temp(15);
			when OPCODE_SHL		=> temp := "0000000000000000"&std_logic_vector( shift_left(unsigned(a),to_integer(unsigned(c)))) ; x <= temp(15 downto 0);negative <= temp(15);
			when OPCODE_SHR		=> temp := "0000000000000000"&std_logic_vector( shift_right(unsigned(a),to_integer(unsigned(c)))) ; x <= temp(15 downto 0);negative <= temp(15);
			when OPCODE_SETC	=> carry<='1';
			when OPCODE_CLRC	=> carry<='0';
			when OPCODE_PUSH	=> x <= a; y <= b; z <= c;
			when OPCODE_POP		=> x <= a; y <= b; z <= c;
			when OPCODE_OUT		=> x <= a; y <= b; z <= c;
			when OPCODE_IN		=> x <= a; y <= b; z <= c;
			when OPCODE_NOT		=> x <= (NOT a);
			when OPCODE_NEG		=> x <= ((NOT a)+1);
			when OPCODE_INC		=> temp := "000000000000000"&(('0'&a)+1); x <= temp(15 downto 0); carry <= temp(16); negative <= temp(15);
			when OPCODE_DEC		=> temp := "000000000000000"&(('0'&a)-1); x<= temp(15 downto 0); carry <= temp(16); negative <= temp(15);
			when OPCODE_JZ		=> z<= (others => (zero xor c(15))); 
			when OPCODE_JN		=> z<= (others => (negative xor c(15))); 
			when OPCODE_JC		=> z<= (others => (carry xor c(15)));
			when OPCODE_JMP		=> x <= a; y <= b; z <= c;
			when OPCODE_CALL	=> x <= a; y <= b;z <= c;
			when OPCODE_RET		=> x <= a; y <= b; z <= c;
			when OPCODE_RTI		=> x <= a; y <= b; z <= c;
			when OPCODE_LDM		=> x <= a; y <= b; z <= c;
			when OPCODE_LDD		=> x <= a; y <= b; z <= c;
			when OPCODE_STD		=> x <= a; y <= b; z <= c;
			when OPCODE_ERROR	=> x <= a; y <= b; z <= c;
			when others =>  x <= a; y <= b; z <= c;
                  
        		end case;
                        if temp= "00000000000000000000000000000000" then
                        zero <='1';
                        else
			zero <= '0';
        		end if;
	end process;

end execute;



