library ieee;
use ieee.std_logic_1164.all;

entity CNT10 is 
	port (clk, rst : in std_logic;
			count : out std_logic_vector(9 downto 0));
end entity;

architecture CNT10_ARC of CNT10 is
	component MasUno10 is 
	port (A : in std_logic_vector(9 downto 0);
			Z : out std_logic_vector(9 downto 0));
	end component;
	
	signal D, Q : std_logic_vector(9 downto 0);
	
	begin 
	I0 : MasUno10 port map (Q, D);
	count <= Q;
	
	P1 : process(clk, rst)
		begin
		if rst = '0' then
			Q <= "0000000000";
		elsif clk'event and clk = '1' then
			Q <= D;
		end if;
	end process;
end architecture;