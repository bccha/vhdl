LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MBI5153 is
	port (
        iSDI : in std_logic;
        iDCLK : in std_logic;
        iLE : in std_logic;

        oOUT0 : out std_logic_vector(15 downto 0);
        oOUT1 : out std_logic_vector(15 downto 0);
        oOUT2 : out std_logic_vector(15 downto 0);
        oOUT3 : out std_logic_vector(15 downto 0);
        oOUT4 : out std_logic_vector(15 downto 0);
        oOUT5 : out std_logic_vector(15 downto 0);
        oOUT6 : out std_logic_vector(15 downto 0);
        oOUT7 : out std_logic_vector(15 downto 0);
        oOUT8 : out std_logic_vector(15 downto 0);
        oOUT9 : out std_logic_vector(15 downto 0);
        oOUT10 : out std_logic_vector(15 downto 0);
        oOUT11 : out std_logic_vector(15 downto 0);
        oOUT12 : out std_logic_vector(15 downto 0);
        oOUT13 : out std_logic_vector(15 downto 0);
        oOUT14 : out std_logic_vector(15 downto 0);
        oOUT15 : out std_logic_vector(15 downto 0);

		oSDO : out std_logic;
		parallel : out std_logic_vector(7 downto 0));
end MBI5153;

architecture rtl of MBI5153 is
    component ControlUnit
        port ( iSDI : in std_logic;
            iDCLK : in std_logic;
            iLE : in std_logic;
            oSDO : out std_logic;
            oVsync : out std_logic;
            oLatch : out std_logic;
            oShiftRegister : out std_logic_vector(15 downto 0));
    end component;

    component SRAM
        port (	
            iCLK : in std_logic;
            iData : in std_logic_vector(15 downto 0);
            iVsync : in std_logic;
            iLatch : in std_logic;
            oOUT0 : out std_logic_vector(15 downto 0);
            oOUT1 : out std_logic_vector(15 downto 0);
            oOUT2 : out std_logic_vector(15 downto 0);
            oOUT3 : out std_logic_vector(15 downto 0);
            oOUT4 : out std_logic_vector(15 downto 0);
            oOUT5 : out std_logic_vector(15 downto 0);
            oOUT6 : out std_logic_vector(15 downto 0);
            oOUT7 : out std_logic_vector(15 downto 0);
            oOUT8 : out std_logic_vector(15 downto 0);
            oOUT9 : out std_logic_vector(15 downto 0);
            oOUT10 : out std_logic_vector(15 downto 0);
            oOUT11 : out std_logic_vector(15 downto 0);
            oOUT12 : out std_logic_vector(15 downto 0);
            oOUT13 : out std_logic_vector(15 downto 0);
            oOUT14 : out std_logic_vector(15 downto 0);
            oOUT15 : out std_logic_vector(15 downto 0));
    end component;

    signal shiftRegister : std_logic_vector(15 downto 0) := x"0000";
    signal vsync : std_logic;
    signal latch : std_logic;
begin
    ctrlUnitRtl : ControlUnit port map (
        iSDI, iDCLK, iLE, oSDO, vsync, latch, shiftRegister
    );

    sramRtl : SRAM port map(
        iDCLK, shiftRegister, vsync, latch,
        oOUT0, oOUT1, oOUT2, oOUT3,
        oOUT4, oOUT5, oOUT6, oOUT7,
        oOUT8, oOUT9, oOUT10, oOUT11,
        oOUT12, oOUT13, oOUT14, oOUT15
    );

end rtl;