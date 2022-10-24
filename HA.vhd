-- Diseño de un half adder -- 
-- J. Emilio Soriano Campos --
-- TE.2002B 					--

-- Definicion de librerias--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Descripcion de la entidad --

entity HA is 
	port ( A, B : in std_logic;
			s, Co : out std_logic );
	end HA;
	
-- Descripcion de la arquitectura --

architecture HA_ARC of HA is

begin

	S <= A xor B;
	Co <= A and B;

end HA_ARC;