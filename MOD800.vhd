library ieee;
use ieee.std_logic_1164.all;

entity MOD800 is
	port (clk, rst : in std_logic;
			go : out std_logic_vector(9 downto 0);
			count : out std_logic_vector(9 downto 0));
end entity;

architecture MOD800_ARC of MOD800 is
	component CNT10 is 
	port (clk, rst : in std_logic;
			count : out std_logic_vector(9 downto 0));
	end component;
	
	signal rst_int : std_logic;
	signal Q : std_logic_vector(9 downto 0);
	
	begin 
	I0 : CNT10 port map (clk, rst_int, Q);
	
	P1 : process (rst, Q)
		begin
		case rst is 
			when '0' => rst_int <= '0';
			when others => if Q = "1100100000" then 
									rst_int <= '0';
								else 
									rst_int <= '1';
								end if;
		end case;
	end process;
	count <= Q;
	go <= Q;
end architecture; 