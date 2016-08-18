		--verandert de achtergrond 
    bg_red   <= conv_std_logic_vector((-intvcnt - inthcnt - cntDyn/2**20),8)(7 downto 4);	 
     bg_green <= conv_std_logic_vector((-intvcnt - inthcnt - cntDyn/2**20),8)(7 downto 4);
     bg_blue  <= conv_std_logic_vector((-intvcnt - inthcnt - cntDyn/2**20),8)(7 downto 4);
	 -- verandert de snelhied 
	   cntdyn <= cntdyn + 200;-- speed adjust 