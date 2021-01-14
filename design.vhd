library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- ptc = CPU -> cache 
entity system is
	Port (  ptcReadOrWrite : in STD_LOGIC;
			validCpuRequest : in STD_LOGIC;
			address : in STD_LOGIC_VECTOR (31 downto 0);
			ptcData : in STD_LOGIC_VECTOR (31 downto 0);
			ctpData : out STD_LOGIC_VECTOR (31 downto 0);
			cacheReady : out STD_LOGIC;
			clk : in STD_LOGIC);
end system;

architecture Behavioral of system is

	signal ctmReadOrWrite, validCacheRequest, memoryReady: STD_LOGIC;
	signal ctmData, mtcData : STD_LOGIC_VECTOR (127 downto 0);
	signal ctmAddress : STD_LOGIC_VECTOR (31 downto 0); 

begin

	cache: entity work.controller(Behavioral)
	port map (ptcReadOrWrite => ptcReadOrWrite, validCpuRequest => validCpuRequest,
			  ptcAddress => address, ptcData => ptcData, ctpData => ctpData, cacheReady => cacheReady,
			  ctmReadOrWrite => ctmReadOrWrite, ctmAddress => ctmAddress, ctmData => ctmData, mtcData => mtcData,
			  validCacheRequest => validCacheRequest, memoryReady => memoryReady, clk => clk);

	memory: entity work.memory(Behavioral)
	port map (readOrWrite => ctmReadOrWrite, validSignal => validCacheRequest,
			  address => address, ctmData => ctmData, mtcData => mtcData, memoryReady => memoryReady, clk => clk);


end Behavioral;