library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity GameProject is

	port
	(		
		Horloge50MHz			:in std_logic;
		v3KEY					:in std_logic_vector(2 downto 0);	
		v10SW					:in std_logic_vector(9 downto 0);	
		
		v8LEDG				    :out std_logic_vector(7 downto 0);
		
		R						:out std_logic;
		G						:out std_logic;
		B						:out std_logic;
		VGA_SynchroLine		    :out std_logic;
		VGA_SynchroFrame		:out std_logic
	);
end GameProject;

use work.CustomPackage.all;
Architecture GameProject_arch of GameProject is
	
	signal EnVGA_int		: std_logic;
	signal Pause_int		: std_logic;
	
	signal EndLine_int	    : std_logic;	
	signal EndImage_int	    : std_logic;
	signal InitS_int 		: std_logic;
	signal Fire_int		    : std_logic;
	
	signal Plus_int		    : std_logic;
	signal iAngle_int		: integer range 1 to 13;
	
	signal iX_int			: integer range 0 to iXABCD;
	signal iY_int			: integer range 0 to iYABCD;
	
	signal iXShell_int		: integer range 0 to iXABCD;
	signal iYShell_int		: integer range 0 to iYABCD;
	
	signal iXTarget1_int		: integer range 0 to iXABCD;
	signal iYTarget1_int		: integer range 0 to iYABCD;
	signal iXTarget2_int	: integer range 0 to iXABCD;
	signal iYTarget2_int	: integer range 0 to iYABCD;
begin
    Fire_int 	<= v10SW(0); 
	InitS_int <= v10SW(1); 
	Pause_int <= v10SW(2); 
	EnVGA_int <= not v10SW(3); 
	Plus_int	<= v3KEY(2); 
	v8LEDG(4) <= EnVGA_int;  
	v8LEDG(3)	<= (not InitS_int) and (not Pause_int); 
	 
	
	XcalcEx1 : Xcalc
		port map
		(	Clk			=>	Horloge50MHz,
			iX				=>	iX_int,
			EnVGA			=>	EnVGA_int,
			SynchroLine 	=> 	VGA_SynchroLine,
			EndLine		=>	EndLine_int
		);
	
	YcalcEx1 : Ycalc
		port map
		(	Clk			=>	Horloge50MHz,
			EnC			=>	EndLine_int,
			iY				=>	iY_int,
			SynchroFrame 	=> 	VGA_SynchroFrame,
			EndImage	 	=> 	EndImage_int			
		);
		
	RgbDisplayEx1 : RgbDisplay 	
		port map
		(	iX			=>	iX_int,
			iY			=>	iY_int,
			iXShell		=>	iXShell_int,
			iYShell		=>	iYShell_int,
			iXTarget		=>	iXTarget1_int,
			iYTarget		=>	iYTarget_cte,
			iXTarget2		=>	iXTarget2_int,
			iYTarget2		=>	iYTarget2_cte,
			iAngle		=>	iAngle_int,
	        Fire	=>	Fire_int,
			R			=>	R,
			G			=>	G,
			B			=>	B
		);

	CalcPosShellEx1 : StateMachine 
		port map
		(	Clk		=>	Horloge50MHz,
			InitS		=>	InitS_int, 
			EndImage 	=>	EndImage_int,
			Pause		=>	Pause_int,     		Fire	=>	Fire_int,
			iAngle		=>	iAngle_int,
			iXShell		=>	iXShell_int,
			iYShell		=>	iYShell_int
		);
		
	PosOfTargetEx1 : PosOfTarget
		port map
		(	Clk		=>	Horloge50MHz,
			Random		=>	InitS_int,
			iXTarget		=>	iXTarget1_int
		);
    PosOfTargetTwoEx2 : PosOfTargetTwo
		port map
		(	Clk		=>	Horloge50MHz,
			Random		=>	InitS_int,
			iXTarget		=>	iXTarget2_int
		);
	BallThrowCalcEx1 : BallThrowCalc
		port map
		(	
			Plus		=>	Plus_int,
			iAngle		=>	iAngle_int
		);
	
	
end GameProject_arch;





