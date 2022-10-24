 library ieee;
use ieee.std_logic_1164.all;

entity v_sync is 
	port (clk, rst : in std_logic;
			cnt : in std_logic_vector(9 downto 0);
			v_signal : out std_logic);
end entity;

architecture v_sync_ARC of v_sync is 
	
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
			
			when PS => if cnt = "0000000010" then
								edof <= BP;
							else
								edof <= PS;
							end if;
							
			when BP => if cnt = "0000100011" then 
								edof <= ZV;
							else
								edof <= BP;
							end if;
							
			when ZV => if cnt = "1000000011" then
								edof <= FP;
							else
								edof <= ZV;
							end if;
							
			when FP => if cnt = "1000001100" then
								edof <= PS;
							else
								edof <= FP;
							end if;
							
			when others => null;
		end case;
	end process;
	
	p3 : process (edo)
		begin
		case edo is
			when S0 => v_signal <= '0';
			
			when PS => v_signal <= '0';
			
			when BP => v_signal <= '1';
							
			when ZV => v_signal <= '1';
			
			when FP => v_signal <= '1';

			when others => null;
		end case;
	end process;
end architecture;			
	