library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CustomPackage.all;


entity BallThrowCalc is 
	port
	(	signal Plus	    : in	std_logic; 
		signal iAngle	: out	integer range 1 to 13
	);
end BallThrowCalc;

architecture BallThrowCalc_arch of BallThrowCalc is
	signal Cpt_int	: integer range 1 to 13;

begin
	process(Plus)
	begin
		if(Plus'event and Plus='1') then 
			if(Cpt_int > 13) then
				Cpt_int <= 1;
			else
				Cpt_int <= Cpt_int + 1;
			end if;
		end if;
	end process;
	
	iAngle <= Cpt_int;

end BallThrowCalc_arch;
