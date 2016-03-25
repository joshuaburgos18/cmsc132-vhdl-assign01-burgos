library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buzzers_tb is
	constant DELAY: time := 10 ns; --constant delay of 10ns
end entity;

architecture buzzers_tb of buzzers_tb is
	signal alarm: std_logic;--variable for the alarm
	signal IN_BUZZER: std_logic_vector(2 downto 0);--variable for IN BUZZER
	signal OUT_BUZZER: std_logic_vector(2 downto 0);--variable for OUT BUZZER

--component buzzer to be tested
	component buzzers is
		port(alarm: out std_logic;
				 IN_BUZZER: in std_logic_vector(2 downto 0);
				 OUT_BUZZER: in std_logic_vector(2 downto 0));
	end component buzzers;

begin
	--instantiating Unit under test
	uut: component buzzers port map(alarm, IN_BUZZER, OUT_BUZZER);

	main: process is
		--variables needed in the process
		variable temp: unsigned(5 downto 0);
		variable expected_alarm: std_logic;
		variable error_count: integer := 0;

	begin
		report "Start Simulation.";

		for i in 0 to 63 loop --iterating 2^6 times
			temp := TO_UNSIGNED(i, 6);--6 bits input
			--assigning respective bits
			IN_BUZZER(2) <= std_logic(temp(5));
			IN_BUZZER(1) <= std_logic(temp(4));
			IN_BUZZER(0) <= std_logic(temp(3));
			OUT_BUZZER(2) <= std_logic(temp(2));
			OUT_BUZZER(1) <= std_logic(temp(1));
			OUT_BUZZER(0) <= std_logic(temp(0));

			--finding cases which alarm will not turn ON
			if(i <= 8) then expected_alarm := '0';
			elsif(i = 16) then expected_alarm := '0';
			elsif(i = 24) then expected_alarm := '0';
			elsif(i = 32) then expected_alarm := '0';
			elsif(i = 40) then expected_alarm := '0';
			elsif(i = 48) then expected_alarm := '0';
			elsif(i = 56) then expected_alarm := '0';
			else expected_alarm := '1';
			end if;

			wait for DELAY;--waiting 10 ns

			--checking if expected alarm is equal to alarm
			assert (expected_alarm = alarm)
				report "ERROR: Expected alarm " & std_logic'image(expected_alarm) & " at time " & time'image(now);

			if(expected_alarm /= alarm) then
				error_count := error_count + 1;
			end if;
		end loop;

		wait for DELAY;

		assert (error_count=0)
			report "ERROR: There were " & integer'image(error_count) & " errors!";

		if(error_count = 0) then
			report "Simulation completed with NO errors.";
		end if;

		wait;
	end process;
end architecture;
