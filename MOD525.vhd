library ieee;
use ieee.std_logic_1164.all;

entity MOD525 is
	port (clk, rst : in std_logic;
			go : in std_logic_vector(9 downto 0);
			count : out std_logic_vector(9 downto 0));
end entity;

architecture MOD525_ARC of MOD525 is
	component CNT10mod is 
	port (clk, rst : in std_logic;
			go : in std_logic_vector(9 downto 0);
			count : out std_logic_vector(9 downto 0));
	end component;
	
	signal rst_int : std_logic;
	signal Q : std_logic_vector(9 downto 0);
	
	begin 
	I0 : CNT10mod port map (clk, rst_int, go, Q);
	
	P1 : process (rst, Q)
		begin
		case rst is 
			when '0' => rst_int <= '0';
			when others => if Q = "1000001101" then 
									rst_int <= '0';
								else 
									rst_int <= '1';
								end if;
		end case;
	end process;
	count <= Q;
end architecture; 