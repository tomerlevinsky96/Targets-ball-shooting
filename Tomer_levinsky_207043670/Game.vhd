library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity Game is
	port
	(	
		
		Horloge50MHz			:in std_logic; 
		v3KEY					:in std_logic_vector(2 downto 0); 
		v10SW					:in std_logic_vector(9 downto 0);	
		
		
		
		v10LEDG				:out std_logic_vector(9 downto 0); 
		v4VGA_R				:out std_logic_vector(3 downto 0); 
		v4VGA_G				:out std_logic_vector(3 downto 0);
		v4VGA_B				:out std_logic_vector(3 downto 0);
		VGA_SynchroLine		:out std_logic;
		VGA_SynchroFrame	:out std_logic
		
	);
end Game;

use work.CustomPackage.all;

Architecture Game_arch of Game is
	signal R		: std_logic;
	signal G		: std_logic;
	signal B		: std_logic;
begin
	
	Proj : GameProject
		port map
			(Horloge50MHz			=>	Horloge50MHz,
			v3KEY					=>	v3KEY,
			v10SW					=>	v10SW,	 
			v8LEDG				=>	v10LEDG(7 downto 0), 
			R						=>	R,
			G						=>	G,
			B						=>	B,
			VGA_SynchroLine		=>	VGA_SynchroLine,
			VGA_SynchroFrame		=>	VGA_SynchroFrame
		);
		
	RGB : for i in 0 to 3 generate 
		v4VGA_R(i) <=R;
		v4VGA_G(i) <= G;
		v4VGA_B(i) <= B;
	end generate RGB;

		
end Game_arch;





