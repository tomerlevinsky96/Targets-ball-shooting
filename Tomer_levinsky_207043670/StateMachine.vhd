library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CustomPackage.all;

entity StateMachine is  
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
end StateMachine;


architecture StateMachine_arch of StateMachine is
	type T_State is ( INIT, MOUNT, DESCEND, endd);
	signal State			: T_State; 
	signal iCtXShell		: integer range 0 to iXABCD; 
	signal iCtYShell		: integer range 0 to iYABCD; 
	signal iDepX		    : integer range 0 to iXABCD; 
	signal iDepY		    : integer range 0 to iYABCD; 
	signal iCtImage		    : integer range 0 to 9;

begin	
	process (Clk)
	begin
		if (Clk'event and Clk = '1') then
			if (InitS='1') then 
					State	<= INIT; 
					iCtXShell	<= iXAB-1+(iLShell/2);   
					iCtYShell	<= iYABC-(iHShell/2);    
			elsif (EndImage='1' and Pause='0') then	  
				case State is
					when INIT => 
						iCtImage	<= 5; 
						iCtXShell	<= iXAB-1+(iLShell/2); 
						iCtYShell	<= iYABC-(iHShell/2);   
						iDepX		<= iTab10DepX(iAngle)/10;    
						iDepY		<= iTab10DepY(iAngle)/10;    
						if (Fire='1') then  
							State	<= MOUNT; 
						end if;
					when MOUNT =>  
						if (iCtImage >=  9) then
							iCtImage	<= 0;
							iDepY		<= iDepY - 1;
						else
							iCtImage	<= iCtImage + 1;
						end if;
						iCtXShell	<= iCtXShell + iDepX;
						iCtYShell	<= iCtYShell - iDepY;
						if (	(iDepY <= 0) or ((iCtYShell-iHShell/2) <= iYAB) or ((iCtXShell+iLShell/2) >= iXABC)	) then
							State <= DESCEND;
						end if;
						
					when DESCEND => 
						if (iCtImage >=  9) then
							iCtImage	<= 0;
							iDepY		<= iDepY + 1;
						else
							iCtImage	<= iCtImage + 1;
						end if;
						if ( ((iCtXShell+iLShell/2) >= iXABC) or ((iCtYShell+iHShell/2) >= iYABC)	) then
							State <=endd;
						else
							iCtXShell	<= iCtXShell + iDepX;
							iCtYShell	<= iCtYShell + iDepY;
						end if;
							
					when endd => 
						iCtXShell	<= iCtXShell;
						iCtYShell	<= iCtYShell;
						
				end case;
			end if;
		end if;
	end process;
	
	iXShell	<= iCtXShell;
	iYShell	<= iCtYShell;
	
end StateMachine_arch;