library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;


Package CustomPackage is
	
	constant iXA		:integer	:=160;     
	constant iXAB		:integer	:=270;		
	constant iXABC		:integer	:=1270;		
	constant iXABCD		:integer	:=1320;     
	
	constant iYA		:integer	:=4;      
	constant iYAB		:integer	:=27;		
	constant iYABC		:integer	:=627;		
	constant iYABCD		:integer	:=628;     
	
	constant iDep		:integer	:=10; 
	
	constant iXSPOT	    :integer	:=(iXAB+iXABC)/2;  
	constant iYSPOT	    :integer	:=(iYAB+iYABC)/2;   
	
	constant iLShell	:integer	:=50;  
	constant iHShell	:integer	:=40;   
	

	constant iYTarget_cte	:integer	:=(iYABC-(iYAB*3)); 
    constant iYTarget2_cte	:integer	:=(iYABC-(iYAB*3));
    
	type T_Tab13Int is Array(1 to 13) of integer;	
	constant iTab10DepX	: T_Tab13Int := (99, 98, 95, 91, 87, 81, 74, 67, 59, 50, 41, 31, 21); 
	constant iTab10DepY	: T_Tab13Int := (10, 21, 31, 41, 50, 59, 67, 74, 81, 87, 91, 95, 98); 
	
	type T_Tab7Int is Array (0 to 6) of integer ;
	constant iTabRandom : T_Tab7Int:=
	(iXSPOT, 100, 400, 600, 300, 50, 400); 
	

	component StateMachine 
	port 
		(	signal Clk		    : in std_logic;
			signal InitS		: in std_logic; 
			signal EndImage 	: in std_logic;
			signal Pause		: in std_logic; 
			signal Fire		    : in std_logic; 
			signal iAngle		: in integer range 1 to 13;
			signal iXShell		: out integer range 0 to iXABCD;
			signal iYShell		: out integer range 0 to iYABCD
		);
	end component;
	
	component PosOfTarget 
	port
		(	signal Clk		    : in std_logic;
			signal Random 		: in std_logic;
			signal iXTarget 	: out integer range 0 to iXABCD
			);
	end component;	
		
    component PosOfTargetTwo 
	port
		(	signal Clk		    : in std_logic;
			signal Random 		: in std_logic;
			signal iXTarget 	: out integer range 0 to iXABCD
			);
	end component;	
			
	component BallThrowCalc 
	port
		(	signal Plus	    : in	std_logic;
			signal iAngle	: out	integer range 1 to 13
		);
	end component;
	
	component RgbDisplay  
		port 
		(	signal iX		: in integer range 0 to iXABCD;
			signal iY		: in integer range 0 to iYABCD;
			signal iXShell	: in integer range 0 to iXABCD;
			signal iYShell	: in integer range 0 to iYABCD;
			signal iXTarget	: in integer range 0 to iXABCD;
			signal iYTarget	: in integer range 0 to iYABCD;
			signal iXTarget2	: in integer range 0 to iXABCD;  
	    	signal iYTarget2	: in integer range 0 to iYABCD; 
			signal iAngle	: in integer range 1 to 13;
			signal Fire	    : in std_logic;
			signal R		: out std_logic;
			signal G		: out std_logic;
			signal B		: out std_logic
		);
	end component;	
	
	component Ycalc is  
		port 
		(	signal Clk			: in 	STD_LOGIC;
			signal EnC			: in 	STD_LOGIC;
			signal iY			: buffer integer range 0 to iYABCD;
			signal SynchroFrame	: out std_logic;
			signal EndImage		: out std_logic
		);
	end component;
	
	component Xcalc  
		port 
		(	signal Clk			: in 	STD_LOGIC;
			signal iX			: buffer integer range 0 to iXABCD;
			signal EnVGA		: in	STD_LOGIC;
			signal SynchroLine	: out std_logic;
			signal EndLine		: out std_logic
		);
	end component;	
	

	component GameProject
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
	end component;
	
end CustomPackage;

