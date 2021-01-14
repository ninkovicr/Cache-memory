library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity memory is
	Port ( readOrWrite : in STD_LOGIC;
		   validSignal : in STD_LOGIC;
		   clk : in STD_LOGIC;
		   address : in STD_LOGIC_VECTOR (31 downto 0);
		   ctmData : in STD_LOGIC_VECTOR (127 downto 0);
		   mtcData : out STD_LOGIC_VECTOR (127 downto 0);
		   memoryReady : out STD_LOGIC);
end memory;

architecture Behavioral of memory is

	type MEM is array (0 to 15) of STD_LOGIC_VECTOR (127 downto 0);

	signal memory_array : MEM := (others => (others => '1'));
	signal currentBlock : INTEGER;

begin

-- Updating current address
	process (address)
	begin
		currentBlock <= to_integer(unsigned(address (31 downto 3))) mod 16;
	end process;

-- reading/writing to/from the memory.
	process (readOrWrite, validSignal)
	begin
		if validSignal = '1' then
			if readOrWrite = '1' then
				mtcData <= memory_array(currentBlock);
				memoryReady <= '1';
			else
				memory_array(currentBlock) <= ctmData;
				memoryReady <= '1';
			end if;
		else
			memoryReady <= '0';
		end if;
	end process;

end Behavioral;