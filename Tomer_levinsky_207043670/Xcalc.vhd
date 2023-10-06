library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CustomPackage.all;

entity Xcalc is 
	port 
	(	signal Clk			: in 	STD_LOGIC;
		signal iX			: out integer range 0 to iXABCD;
		signal EnVGA		: in	STD_LOGIC;
		signal SynchroLine	: out std_logic;
		signal EndLine		: out std_logic
	);
end Xcalc;

architecture Xcalc_arch of Xcalc is
	signal iCtX	:integer range 0 to iXABCD;
begin
	process (Clk)
	begin
		if (Clk'event and Clk = '1') then
				if(iCtX >= iXABCD-1)then
					iCtX<=0;
				else
					iCtX <= iCtX + 1;
				end if;
		end if;
	end process;
	
	iX <= iCtX;
	
	EndLine	<= 	'1' when(iCtX=iXABCD-1 )
			else	'0';
		
	SynchroLine	<=	'0' when(iCtX < iXA)
				else	'0' when(EnVGA='0')
				else	'1';
	
end Xcalc_arch;
