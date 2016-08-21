------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--The IEEE.std_logic_unsigned contains definitions that allow 
--std_logic_vector types to be used with the + operator to instantiate a 
--counter.
use IEEE.std_logic_unsigned.all;

entity GPIO_demo is
    Port ( BTN 			: in  STD_LOGIC_VECTOR (4 downto 0);--button
           CLK 			: in  STD_LOGIC;
           VGA_RED      : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_BLUE     : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_GREEN    : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_VS       : out  STD_LOGIC;
           VGA_HS       : out  STD_LOGIC;
           PS2_CLK      : inout STD_LOGIC;
           PS2_DATA     : inout STD_LOGIC
			  );
end GPIO_demo;

architecture Behavioral of GPIO_demo is




component debouncer
Generic(
        DEBNC_CLOCKS : integer;
        PORT_WIDTH : integer);
Port(
		SIGNAL_I : in std_logic_vector(4 downto 0);
		CLK_I : in std_logic;          
		SIGNAL_O : out std_logic_vector(4 downto 0)
		);
end component;

component vga_ctrl
    Port ( CLK_I : in STD_LOGIC;
           Button: in   STD_LOGIC_VECTOR (4 downto 0);--button
           VGA_HS_O : out STD_LOGIC;
           VGA_VS_O : out STD_LOGIC;
           VGA_RED_O : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_BLUE_O : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_GREEN_O : out STD_LOGIC_VECTOR (3 downto 0);
           PS2_CLK      : inout STD_LOGIC;
           
PS2_DATA     : inout STD_LOGIC
           );
end component;


constant TMR_CNTR_MAX : std_logic_vector(26 downto 0) := "101111101011110000100000000"; --100,000,000 = clk cycles per second
constant TMR_VAL_MAX : std_logic_vector(3 downto 0) := "1001"; --9

constant RESET_CNTR_MAX : std_logic_vector(17 downto 0) := "110000110101000000";-- 100,000,000 * 0.002 = 200,000 = clk cycles per 2 ms

constant MAX_STR_LEN : integer := 27;





--This is used to determine when the 7-segment display should be
--incremented
signal tmrCntr : std_logic_vector(26 downto 0) := (others => '0');

--This counter keeps track of which number is currently being displayed
--on the 7-segment.
signal tmrVal : std_logic_vector(3 downto 0) := (others => '0');



--Used to determine when a button press has occured
signal btnReg : std_logic_vector (3 downto 0) := "0000";
signal btnDetect : std_logic;



--Debounced btn signals used to prevent single button presses
--from being interpreted as multiple button presses.
signal btnDeBnc : std_logic_vector(4 downto 0);

signal clk_cntr_reg : std_logic_vector (4 downto 0) := (others=>'0'); 

signal pwm_val_reg : std_logic := '0';

--this counter counts the amount of time paused in the UART reset state
signal reset_cntr : std_logic_vector (17 downto 0) := (others=>'0');

begin


----------------------------------------------------------
------              Button Control                 -------
----------------------------------------------------------
--Buttons are debounced and their rising edges are detected
--to trigger UART messages






--Loads the sendStr and strEnd signals when a LD state is
--is reached.


----------------------------------------------------------
------              VGA Control                    -------
----------------------------------------------------------

Inst_vga_ctrl: vga_ctrl port map(
		CLK_I => CLK,
		VGA_HS_O => VGA_HS,
        VGA_VS_O => VGA_VS,
		VGA_RED_O => VGA_RED,
        VGA_BLUE_O => VGA_BLUE,
        VGA_GREEN_O => VGA_GREEN,
        PS2_CLK => PS2_CLK,
        PS2_DATA => PS2_DATA,
        Button =>  BTN 		
	);

end Behavioral;
