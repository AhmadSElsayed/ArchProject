LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.constants.all;

entity Decoder is
	port(
		Instruction :in std_logic_vector(15 downto 0);
		OpCode: out std_logic_vector(4 downto 0);
		RegisterSourceAddress, RegisterDestAddress: out std_logic_vector(02 downto 0);
		RegisterDestValue, extras: out std_logic_vector(15 downto 0)

	);
end Decoder;

architecture NoHazards of Decoder is
begin
	OpCode <= 
			OPCODE_LDM when Instruction(15 downto 13) = "000" -- LDM
	else	OPCODE_LDD when Instruction(15 downto 13) = "001" -- LDD
	else	OPCODE_STD when Instruction(15 downto 13) = "010" -- STD
	else	OPCODE_OUT when Instruction(15 downto 13) = "011" -- OUT
	else	OPCODE_PUSH when Instruction(15 downto 12) = "1000" -- Push
	else	OPCODE_POP when Instruction(15 downto 12) = "1001" -- POP
	else	OPCODE_MOV when Instruction(15 downto 12) = "1010" -- MOV
	else	OPCODE_IN when Instruction(15 downto 12) = "1011" -- IN
	else	OPCODE_SHL when Instruction(15 downto 10) = "110000" -- SHL
	else	OPCODE_SHR when Instruction(15 downto 10) = "110001" -- SHR
	else	OPCODE_ADD when Instruction(15 downto 10) = "110010" -- ADD
	else	OPCODE_SUB when Instruction(15 downto 10) = "110011" -- SUB
	else	OPCODE_MUL when Instruction(15 downto 10) = "110100" -- MUL
	else	OPCODE_AND when Instruction(15 downto 10) = "110101" -- AND
	else	OPCODE_OR when Instruction(15 downto 10) = "110110" -- OR
	else	OPCODE_RLC when Instruction(15 downto 10) = "110111" -- RLC
	else	OPCODE_RRC when Instruction(15 downto 10) = "111000" -- RRC
	else	OPCODE_NEG when Instruction(15 downto 10) = "111001" -- NEG
	else	OPCODE_INC when Instruction(15 downto 10) = "111010" -- INC
	else	OPCODE_DEC when Instruction(15 downto 10) = "111011" -- DEC
	else	OPCODE_NOT when Instruction(15 downto 10) = "111100" -- NOT
	else	OPCODE_SETC when Instruction(15 downto 10) = "111101" -- SETC
	else	OPCODE_CLRC when Instruction(15 downto 10) = "111110" -- CLRC
	else	OPCODE_JZ when Instruction(15 downto 07) = "111111000" -- JZ
	else	OPCODE_JN when Instruction(15 downto 07) = "111111001" -- JN
	else	OPCODE_JC when Instruction(15 downto 07) = "111111010" -- JC
	else	OPCODE_JMP when Instruction(15 downto 07) = "111111011" -- JMP
	else	OPCODE_CALL when Instruction(15 downto 07) = "111111100" -- CALL
	else	OPCODE_RET when Instruction(15 downto 07) = "111111101" -- RET
	else	OPCODE_RTI when Instruction(15 downto 07) = "111111110" -- RTI
	else	OPCODE_NOP when Instruction(15 downto 07) = "111111111" -- NOP
	else	OPCODE_ERROR;

	RegisterDestAddress <= 
			Instruction(12 downto 10) when Instruction(15 downto 13) = "000" -- LDM
	else	Instruction(12 downto 10) when Instruction(15 downto 13) = "001" -- LDD
	else	Instruction(12 downto 10) when Instruction(15 downto 13) = "010" -- STD
	else	Instruction(12 downto 10) when Instruction(15 downto 13) = "011" -- OUT
	else	Instruction(12 downto 10) when Instruction(15 downto 12) = "1000" -- Push
	else	Instruction(12 downto 10) when Instruction(15 downto 12) = "1001" -- POP
	else	Instruction(12 downto 10) when Instruction(15 downto 12) = "1010" -- MOV
	else	Instruction(12 downto 10) when Instruction(15 downto 12) = "1011" -- IN
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110000" -- SHL
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110001" -- SHR
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110010" -- ADD
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110011" -- SUB
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110100" -- MUL
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110101" -- AND
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110110" -- OR
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "110111" -- RLC
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "111000" -- RRC
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "111001" -- NEG
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "111010" -- INC
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "111011" -- DEC
	else	Instruction(09 downto 07) when Instruction(15 downto 10) = "111100" -- NOT
	else	Instruction(06 downto 04) when Instruction(15 downto 07) = "111111000" -- JZ
	else	Instruction(06 downto 04) when Instruction(15 downto 07) = "111111001" -- JN
	else	Instruction(06 downto 04) when Instruction(15 downto 07) = "111111010" -- JC
	else	Instruction(06 downto 04) when Instruction(15 downto 07) = "111111011" -- JMP
	else	Instruction(06 downto 04) when Instruction(15 downto 07) = "111111100" -- CALL
	else	"XXX";
	
	RegisterSourceAddress <= 
			Instruction(09 downto 07) when Instruction(15 downto 12) = "1010" -- MOV
	else	Instruction(02 downto 00) when Instruction(15 downto 10) = "110000" -- SHL
	else	Instruction(02 downto 00) when Instruction(15 downto 10) = "110001" -- SHR
	else	Instruction(06 downto 04) when Instruction(15 downto 10) = "110010" -- ADD
	else	Instruction(06 downto 04) when Instruction(15 downto 10) = "110011" -- SUB
	else	Instruction(06 downto 04) when Instruction(15 downto 10) = "110100" -- MUL
	else	Instruction(06 downto 04) when Instruction(15 downto 10) = "110101" -- AND
	else	Instruction(06 downto 04) when Instruction(15 downto 10) = "110110" -- OR
	else	Instruction(06 downto 04) when Instruction(15 downto 10) = "110111" -- RLC
	else	Instruction(06 downto 04) when Instruction(15 downto 10) = "111000" -- RRC
	else	"XXX";

	extras <=
			-- when Instruction(15 downto 13) = "000" -- LDM
			Instruction(9 downto 0) when Instruction(15 downto 13) = "001" -- LDD
	else	Instruction(9 downto 0) when Instruction(15 downto 13) = "010" -- STD
	else	Instruction(6 downto 3) when Instruction(15 downto 10) = "110000" -- SHL
	else	Instruction(6 downto 3) when Instruction(15 downto 10) = "110001" -- SHR
	else	"0000000000000001" when Instruction(15 downto 07) = "111111000" -- JZ
	else	"0000000000000001" when Instruction(15 downto 07) = "111111001" -- JN
	else	"0000000000000001" when Instruction(15 downto 07) = "111111010" -- JC
	else (others => 'X');
end architecture; -- NoHazards