LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity SRAM is
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

end SRAM;