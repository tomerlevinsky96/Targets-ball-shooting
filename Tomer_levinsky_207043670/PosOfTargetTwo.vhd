library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.CustomPackage.all;

entity PosOfTargetTwo is 
    port 
    (   signal Clk            : in std_logic;
        signal Random         : in std_logic; 
        signal iXTarget       : out integer range 0 to iXABCD 
    );
end PosOfTargetTwo;

architecture PosOfTargetTwo_arch of PosOfTargetTwo is
    signal iNothing         : integer range 0 to 2312; 
    signal iCtXTarget       : integer range 0 to iXABC;
    signal iCtSelect        : integer range 0 to iXABC;
begin    
    process (Clk)
    begin
        if (Clk'event and Clk = '1') then 
            
            if (iCtSelect >= iXABC) then        
                iCtSelect <= (iXAB+400); 

            else 
                iCtSelect <= iCtSelect + 100;
            end if;
            
            if(Random = '1') then 
                if(iNothing = 2312) then
                    iNothing <= 0;
                else
                    iNothing <= iNothing + 1;
                end if;    
            end if;
            if (Random = '1' and iNothing >= 2312) then 
                iCtXTarget <= iCtSelect;
            end if;
            
        end if;
    end process;
    iXTarget  <= iCtXTarget;
end PosOfTargetTwo_arch;