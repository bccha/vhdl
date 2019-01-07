LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ControlUnit is
	port (	iSDI : in std_logic := '0';
        iDCLK : in std_logic := '0';
        iLE : in std_logic := '0';
        oSDO : out std_logic := '0';
        oVsync : out std_logic := '0';
        oLatch : out std_logic := '0';
        oShiftRegister : out std_logic_vector(15 downto 0) := x"0000");
end ControlUnit;

architecture rtl of ControlUnit is
    signal shiftRegister : std_logic_vector(15 downto 0) := x"0000";
    signal leCounter : integer range 0 to 16 := 0;
    signal commandCounter : integer range 0 to 4 := 0;
begin      

    -- SDI, SDO 처리 process
    process (iDCLK, iSDI)
    begin
        if iDCLK = '1' then            
            shiftRegister <= shiftRegister(14 downto 0) & iSDI;
            oSDO <= shiftRegister(15);
        end if;
    end process;

    -- LE command 확인 및 처리 process
    process (iDCLK, iLE)
    begin
        if iLE = '0' then
            -- check LE Command by LE Counter
            case leCounter is
                when 1 =>   -- Data Latch
                    oShiftRegister <= shiftRegister;
                    oLatch <= '1';
                    commandCounter <= 1;
                when 2 =>   -- VSync
                    oVsync <= '1';
                    commandCounter <= 1;
                when others =>
                    null;
            end case;
            leCounter <= 0;            
        end if;

        if rising_edge(iDCLK) and iLE = '1' then
            leCounter <= leCounter + 1;
        end if;

        if rising_edge(iDCLK) and iLE = '0' and commandCounter > 0 then
            commandCounter <= commandCounter + 1;
            if commandCounter > 1 then     
                oVsync <= '0';
                oLatch <= '0';
                commandCounter <= 0;      
            end if;
        end if;
    end process;
end rtl;


-- TEST BENCH

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ControlUnit_TB is
end ControlUnit_TB;

architecture TB_ARCHITECTURE of ControlUnit_TB is
-- Component declaration of the tested unit
component ControlUnit
port ( iSDI : in std_logic;
    iDCLK : in std_logic;
    iLE : in std_logic;
    oSDO : out std_logic;
    oVsync : out std_logic;
    oLatch : out std_logic;
    oShiftRegister : out std_logic_vector(15 downto 0));
end component;

-- Stimulus signals - signals mapped to the input and inout ports of   tested entity
signal sdi : std_logic := '0';
signal dclk : std_logic := '0';
signal le : std_logic := '0';
signal sdo : std_logic := '0';
signal vsync : std_logic := '0';
signal latch : std_logic := '0';
signal shiftRegister : std_logic_vector(15 downto 0) := x"0000";

constant clk_period:time :=10 ns;
-- Observed signals - signals mapped to the output ports of tested entity

begin
-- Unit Under Test port map
UUT : ControlUnit
    port map (sdi, dclk, le, sdo, vsync, latch, shiftRegister);

clk_process :process
begin
    dclk <= '0';
    wait for clk_period / 2;
    dclk <= '1';
    wait for clk_period / 2;
end process;


  -- Stimulus process
stim_proc: process
begin     
    sdi <= '1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='0';
    wait for 10 ns; 
    sdi <='0';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='1';
    wait for 10 ns; 
    sdi <='0';
    le <= '1';
    wait for 10 ns; 
    sdi <='1';
    le <= '0';
    wait for 20 ns; 
    le <= '1';
    wait for 20 ns;
    le <= '0';
    
end process;

END TB_ARCHITECTURE;