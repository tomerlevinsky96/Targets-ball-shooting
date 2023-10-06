library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CustomPackage.all;

entity Ycalc is 
	port 
	(	signal Clk			: in 	STD_LOGIC;
  		signal EnC			: in 	STD_LOGIC;
		signal iY			: out integer range 0 to iYABCD;
		signal SynchroFrame	: out std_logic;
		signal EndImage		: out std_logic
	);
end Ycalc;

architecture Ycalc_arch of Ycalc is
	signal iCtY	: integer range 0 to iYABCD;
begin
	process (Clk)
	begin
		if (Clk'event and Clk = '1') then
			if(EnC='1') then
				if(iCtY >= iYABCD-1)then
					iCtY <= 0;
				else
					iCtY <= iCtY + 1;
				end if;
			end if;
		end if;
	end process;
	
	iY <= iCtY;
		
	SynchroFrame <=	'0' when(iCtY < iYA)
		else			'1';

	EndImage 		<=	'1' when( (EnC='1')and(iCtY=iYABCD-1) )
		else			'0';		
end Ycalc_arch;
