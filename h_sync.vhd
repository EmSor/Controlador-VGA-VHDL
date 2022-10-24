library ieee;
use ieee.std_logic_1164.all;

entity h_sync is 
	port (clk, rst : in std_logic;
			cnt : in std_logic_vector(9 downto 0);
			cnt2 : in std_logic_vector(9 downto 0);
			h_signal : out std_logic;
			r_signal : out std_logic_vector(3 downto 0);
			g_signal : out std_logic_vector(3 downto 0);
			b_signal : out std_logic_vector(3 downto 0));
end entity;

architecture h_sync_ARC of h_sync is 
	
	type ESTADOS is (S0, PS, BP, ZV, FP);
	signal edo, edof : ESTADOS;
	
	begin
	p1 : process (clk, rst) 
		begin
		if rst = '0' then
			edo <= S0;
		elsif clk'event and clk = '1' then
			edo <= edof;
		end if;
	end process;
	
	
	p2 : process (edo, cnt)
		begin 
		case edo is
			when S0 => if cnt = "0000000000" then 
								edof <= PS;
							else
								edof <= S0;
							end if;
			
			when PS => if cnt = "0001100000" then
								edof <= BP;
							else
								edof <= PS;
							end if;
							
			when BP => if cnt = "0010010000" then 
								edof <= ZV;
							else
								edof <= BP;
							end if;
							
			when ZV => if cnt = "1100010000" then
								edof <= FP;
							else
								edof <= ZV;
							end if;
							
			when FP => if cnt = "1100011111" then
								edof <= PS;
							else
								edof <= FP;
							end if;
							
			when others => null;
		end case;
	end process;
	
	p3 : process (edo, cnt)
		begin
		case edo is
			when S0 => h_signal <= '0';
						  r_signal <= "0000";
						  g_signal <= "0000";
						  b_signal <= "0000";
			
			when PS => h_signal <= '0';
						  r_signal <= "0000";
						  g_signal <= "0000";
						  b_signal <= "0000";
			
			when BP => h_signal <= '1';
						  r_signal <= "0000";
						  g_signal <= "0000";
						  b_signal <= "0000";
							
			when ZV => h_signal <= '1';
						  if cnt > "0110111100" and cnt < "0111100100" then
							  r_signal <= "0000";
							  g_signal <= "0000";
							  b_signal <= "1111";
							elsif cnt2 > "0011111111" and cnt2 < "0100100111" then
							  r_signal <= "0000";
							  g_signal <= "0000";
							  b_signal <= "1111";
							else 
							  r_signal <= "1111";
							  g_signal <= "1111";
							  b_signal <= "0000";
							end if;
			
			when FP => h_signal <= '1';
						  r_signal <= "0000";
						  g_signal <= "0000";
						  b_signal <= "0000";

			when others => null;
		end case;
	end process;
end architecture;			
	