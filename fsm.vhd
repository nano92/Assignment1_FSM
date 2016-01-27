library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Do not modify the port map of this structure
entity comments_fsm is
port (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
end comments_fsm;

architecture behavioral of comments_fsm is

-- The ASCII value for the '/', '*' and end-of-line characters
constant SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
constant STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
constant NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

type STATE_TYPE is (s1, s2, s3, s4, s5);
signal state: STATE_TYPE := s1;

begin

-- Insert your processes here
process (clk, reset, input)
--variable past_input : std_logic_vector(7 downto 0); --To store the previous input value
begin
--output <= '0';
	if (reset = '1') then
		state <= s1;
	elsif (rising_edge(clk) AND reset = '0') then
	
	case state is
		when s1=>
		--past_input := input; 
		if (input = SLASH_CHARACTER) then
		output <= '0';
		state <= s2;
		else
		output <= '0';
		--state <= s1;
		end if;
		
		when s2 =>
		if(input = SLASH_CHARACTER) then
		output <= '0';
		state <= s3;
		elsif (input = STAR_CHARACTER)then
		output <= '0';
		state <= s4;
		else
		output <= '0';
		state <= s1;
		end if;

		when s3 =>
		if(input = NEW_LINE_CHARACTER) then
		output <= '1';
		state <= s1;
		else
		output <= '1';
		end if;

		when s4 =>
		if(input = STAR_CHARACTER)then
		output <= '1';
		state <= s5;
		else
		output <= '1';
		end if;
		
		when s5 =>
		if(input = SLASH_CHARACTER) then
		output <= '1';
		state <= s1;
		else
		state <= s4;
		end if;
end case;
end if;
end process;



end behavioral;