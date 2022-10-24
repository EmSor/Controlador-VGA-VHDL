library ieee;
use ieee.std_logic_1164.all;

entity VGA is 
	port (clk, rst : in std_logic;
			vga_h : out std_logic;
			vga_v : out std_logic;
			vga_r : out std_logic_vector(3 downto 0);
			vga_g : out std_logic_vector(3 downto 0);
			vga_b : out std_logic_vector(3 downto 0));
end entity;

architecture VGA_ARC of VGA is 
	component MOD800 is
	port (clk, rst : in std_logic;
			go : out std_logic_vector(9 downto 0);
			count : out std_logic_vector(9 downto 0));
	end component;
	component MOD525 is
	port (clk, rst : in std_logic;
			go : in std_logic_vector(9 downto 0);
			count : out std_logic_vector(9 downto 0));
	end component;
	
	component v_sync is 
	port (clk, rst : in std_logic;
			cnt : in std_logic_vector(9 downto 0);
			v_signal : out std_logic);
	end component;
	component h_sync is 
	port (clk, rst : in std_logic;
			cnt : in std_logic_vector(9 downto 0);
			cnt2 : in std_logic_vector(9 downto 0);
			h_signal : out std_logic;
			r_signal : out std_logic_vector(3 downto 0);
			g_signal : out std_logic_vector(3 downto 0);
			b_signal : out std_logic_vector(3 downto 0));
	end component;
	
	signal half_clk : std_logic;
	signal cnt800, cnt525 : std_logic_vector(9 downto 0);
	signal pulse : std_logic_vector(9 downto 0);
	
	begin 
	
	I0 : MOD800 port map (half_clk, rst, pulse, cnt800);
	I1 : MOD525 port map (half_clk, rst, pulse, cnt525);
	I2 : v_sync port map (clk, rst, cnt525, vga_v);
	I3 : h_sync port map (clk, rst, cnt800, cnt525, vga_h, vga_r, vga_g, vga_b);
	
	P1 : process(clk)
		begin 
		if clk'event and clk = '1' then	
			half_clk <= not half_clk;
		end if;
	end process;
end architecture;