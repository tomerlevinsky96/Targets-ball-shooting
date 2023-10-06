library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CustomPackage.all;

entity RgbDisplay is 
	port 
	(	signal iX		: in integer range 0 to iXABCD; --1320
  		signal iY		: in integer range 0 to iYABCD; --628
  		
		signal iXShell	: in integer range 0 to iXABCD; --1320
		signal iYShell	: in integer range 0 to iYABCD;  --628
		
		signal iXTarget	: in integer range 0 to iXABCD;  --1320
		signal iYTarget	: in integer range 0 to iYABCD; --628
        
        
        signal iXTarget2	: in integer range 0 to iXABCD;  --1320
		signal iYTarget2	: in integer range 0 to iYABCD; --628
        
        
        
		signal iAngle	: in integer range 1 to 13;
		signal Fire	    : in std_logic; --sw[1]

        signal R		: out std_logic;
        signal G		: out std_logic;
        signal B		: out std_logic
	);
end RgbDisplay;

architecture RgbDisplay_arch of RgbDisplay is																																																								--Marmont
	signal Displayable	: std_logic;
	signal Shell_int	: std_logic;
	signal Rule_int	    : std_logic;
	signal Cursor_int   : std_logic;
	signal Target0_int	: std_logic;
	signal Target1_int	: std_logic;
	signal Target2_int	: std_logic;
	signal Target3_int	: std_logic;
	signal Target4_int	: std_logic;
	signal Target5_int	: std_logic;
	signal Contact_int  : std_logic;
	
	--constant iXA		    :integer	:=160;      --160
	--constant iXAB		    :integer	:=270;		--origin X   270
	--constant iXABC		:integer	:=1270;		--max X  1270
	--constant iXABCD		:integer	:=1320;     --1320
	
	--constant iYA		    :integer	:=4;        --4
	--constant iYAB		    :integer	:=27;		--origin Y   27 
	--constant iYABC		:integer	:=627;		--max Y    627
	--constant iYABCD		:integer	:=628;      --628
	
	--constant iDep		    :integer	:=10; --10
	
	--constant iXSPOT	    :integer	:=(iXAB+iXABC)/2;  -- (iXAB+iXABC)/2
	--constant iYSPOT	    :integer	:=(iYAB+iYABC)/2;   --(iYAB+iYABC)/2
	
	--constant iLShell	    :integer	:=50;  -- 50
	--constant iHShell	    :integer	:=40;   -- 40
	
begin
	--pixel display
	Displayable <=	'1' when (iX >= iXAB) and (iX < iXABC) and (iY >= iYAB) and (iY < iYABC) -- if all condition are ok, display == 1 then we can go on, other 0, and black screen
			else	'0';
	
	
	Shell_int <= '1' when ((iX - iXShell)**2 + (iY - iYShell)**2 <= (iLShell/2)**2) else '0';
    
			
	Rule_int	<=	'1' when ( -- those are conditions  for the  action and calculate the position in X AND Y
					   ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 070) and (iY <= 075))) 
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 080) and (iY <= 085)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 090) and (iY <= 095)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 100) and (iY <= 105)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 110) and (iY <= 115)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 120) and (iY <= 125)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 130) and (iY <= 135)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 140) and (iY <= 145)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 150) and (iY <= 155)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 160) and (iY <= 165)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 170) and (iY <= 175)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 180) and (iY <= 185)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 190) and (iY <= 195)))
					)
			else	'0';
			
	Cursor_int	<=	'1' when (  -- those are conditions  for the  action and calculate the position in X AND Y
					   ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 070) and (iY <= 075)) and iAngle = 13)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 080) and (iY <= 085)) and iAngle = 12)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 090) and (iY <= 095)) and iAngle = 11)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 100) and (iY <= 105)) and iAngle = 10)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 110) and (iY <= 115)) and iAngle = 09)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 120) and (iY <= 125)) and iAngle = 08)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 130) and (iY <= 135)) and iAngle = 07)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 140) and (iY <= 145)) and iAngle = 06)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 150) and (iY <= 155)) and iAngle = 05)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 160) and (iY <= 165)) and iAngle = 04)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 170) and (iY <= 175)) and iAngle = 03)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 180) and (iY <= 185)) and iAngle = 02)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 190) and (iY <= 195)) and iAngle = 01)
					)
			else	'0';
			
	-----target-----
	Target0_int	<=	'1' when (
				(((iX - iXTarget) * (iX - iXTarget)) + ((iY - iYTarget) * (iY - iYTarget))) <= 200 --white circle (inside)
				)
				else	'0';
	Target1_int	<=	'1' when (
				(((iX - iXTarget) * (iX - iXTarget)) + ((iY - iYTarget) * (iY - iYTarget))) <= 500 --white circle (inside)
				)
				else	'0';
	
	Target2_int	<=	'1' when (
				(((iX - iXTarget) * (iX - iXTarget)) + ((iY - iYTarget) * (iY - iYTarget))) <= 2000 -- blue circle (middle)
				)
				else	'0';
				
	Target3_int	<=	'1' when (
				(((iX - iXTarget2) * (iX - iXTarget2)) + ((iY - iYTarget2) * (iY - iYTarget2))) <= 200 --white circle (inside)
				)
				else	'0';
	
	Target4_int	<=	'1' when (
				(((iX - iXTarget2) * (iX - iXTarget2)) + ((iY - iYTarget2) * (iY - iYTarget2))) <= 500 -- blue circle (middle)
				)
				else	'0';
    Target5_int	<=	'1' when (
				(((iX - iXTarget2) * (iX - iXTarget2)) + ((iY - iYTarget2) * (iY - iYTarget2))) <= 2000 -- blue circle (middle)
				)
				else	'0';
						
	-----end target-----
	
	Contact_int	<=	'1' when (Shell_int='1' and (Target2_int='1' or Target1_int='1'or Target0_int='1' or Target4_int='1' or Target5_int='1'))
				else	'0';

	
	----RGB----
	R	<=		'0' when (Displayable = '0')       
		else	'1' when (Cursor_int='1' and Fire='1') -- if all the condition are match, then we can display
		else	'0' when (Cursor_int='1' and Fire='0')
		else	'1' when (Rule_int='1')
		else 	'0' when (Shell_int='1')
		else	'1'	when (Contact_int='1')
		else	'1' when (Target0_int='1')
		else	'1' when (Target1_int='1')
		else	'0' when (Target2_int='1')
		else	'1' when (Target3_int='1')
		else	'0' when (Target4_int='1')
		else	'0' when (Target5_int='1')
		else	'1';

	G <=		'0' when (Displayable = '0')
		else	'0' when (Cursor_int='1' and Fire='1') -- if all the condition are match, then we can display
		else	'0' when (Cursor_int='1' and Fire='0')
		else	'1' when (Rule_int='1')
		else 	'1' when (Shell_int='1')
		else	'0' when (Target4_int='0')
		else	'1'	when (Contact_int='1')
		else	'1' when (Target1_int='1')
		else	'1' when (Target2_int='1')
		else	'1' when (Target3_int='1')
		else	'1' when (Target4_int='1')
		else	'0' when (Target5_int='1')
		else	'1';
		
	B	<=		'0' when (Displayable = '0')
		else	'0' when (Cursor_int='1' and Fire='1') -- if all the condition are match, then we can display
		else	'1' when (Cursor_int='1' and Fire='0') 
		else	'0' when (Rule_int='1')
		else 	'0' when (Shell_int='1')
		else	'0'	when (Contact_int='1')
		else	'0' when (Target0_int='0')
		else	'1' when (Target1_int='1')
		else	'0' when (Target2_int='1')
		else	'1' when (Target3_int='1')
		else	'1' when (Target4_int='1')
		else	'1' when (Target5_int='1')
		else	'1';

end RgbDisplay_arch;