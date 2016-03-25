library IEEE;
use IEEE.std_logic_1164.all;

entity buzzers is--entity buzzers
  port( alarm: out std_logic;   -- data output
      --3 set of in and out buzzer for Boggis, Bunce and Bean
        IN_BUZZER: in std_logic_vector(2 downto 0); -- state of 3 IN_BUZZER
        OUT_BUZZER: in std_logic_vector(2 downto 0) -- state of 3 OUT_BUZZER
      );
end entity;

architecture buzzers of buzzers is
begin
	process(IN_BUZZER, OUT_BUZZER) is --processing in and out buzzers
	begin
    --If in and out buzzers of same stage is ON; then alarm is ON
    --Condition (2, 3, 4) are satisfied thru checking of all the pairs
		if(IN_BUZZER(2) = '1' and OUT_BUZZER(2) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(1) = '1' and OUT_BUZZER(1) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(0) = '1' and OUT_BUZZER(0) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(0) = '1' and OUT_BUZZER(1) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(0) = '1' and OUT_BUZZER(2) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(1) = '1' and OUT_BUZZER(0) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(1) = '1' and OUT_BUZZER(2) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(2) = '1' and OUT_BUZZER(0) = '1')  then alarm <= '1';
    elsif(IN_BUZZER(2) = '1' and OUT_BUZZER(1) = '1')  then alarm <= '1';
		else alarm <= '0';
		end if;
	end process;
end architecture;
