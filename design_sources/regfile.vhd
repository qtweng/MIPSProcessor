LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.ALL;

ENTITY RegFile IS
   PORT( 
      RA1      : IN  std_logic_vector (n_bits_of(reg_file_depth) - 1 DOWNTO 0);
      RA2 	   : IN  std_logic_vector (n_bits_of(reg_file_depth) - 1 DOWNTO 0);
      RegWrite : IN  std_logic;
      WA  	   : IN  std_logic_vector (n_bits_of(reg_file_depth) - 1 DOWNTO 0);
      WD  	   : IN  std_logic_vector (reg_file_width - 1 DOWNTO 0);
      clk      : IN  std_logic;
      rst      : IN  std_logic;
      RD1 	   : OUT std_logic_vector (reg_file_width - 1 DOWNTO 0);
      RD2 	   : OUT std_logic_vector (reg_file_width - 1 DOWNTO 0)
   );
END RegFile;

ARCHITECTURE behav OF RegFile IS

   -- Internal signal declarations
   SIGNAL reg_file  : mem_type(0 to reg_file_depth - 1);
   
   SIGNAL RA1_index : std_logic_vector (RA1'length - 1 DOWNTO 0);
   SIGNAL RA2_index : std_logic_vector (RA2'length - 1 DOWNTO 0);
   SIGNAL WA_index  : std_logic_vector (WA'length - 1 DOWNTO 0);

BEGIN

   -- **************************** --
   -- DO NOT MODIFY or CHANGE the ---
   -- code template provided above --
   -- **************************** --
   
   ----- insert your code here ------
--- insert your code here ---
   -- Address Guard --
   -- Indices should be within range of 0 to reg_file_depth - 1
   RA1_index <= RA1 WHEN (TO_INTEGER(UNSIGNED(RA1)) >= 0 AND TO_INTEGER(UNSIGNED(RA1)) < reg_file_depth)
   ELSE (OTHERS => '0');
   RA2_index <= RA2 WHEN (TO_INTEGER(UNSIGNED(RA2)) >= 0 AND TO_INTEGER(UNSIGNED(RA2)) < reg_file_depth)
   ELSE (OTHERS => '0');
   -- MUX --
   RD1 <= reg_file(TO_INTEGER(UNSIGNED(RA1_index)));
   RD2 <= reg_file(TO_INTEGER(UNSIGNED(RA2_index)));
   -- write process --
   async_reset_write : PROCESS(clk, rst) 
   -- begin procedural code, activated upon change to clk and rst
    BEGIN
        IF (rst = '1') THEN
        -- Reset Actions
         reg_file <= initial_reg_file;
         reg_file(0) <= zeros;
         reg_file(29) <= TOS;
        ELSIF (clk'EVENT AND clk = '1') THEN
        -- if clock event 
            IF ((RegWrite = '1') AND (TO_INTEGER(UNSIGNED(WA)) > 0) AND (TO_INTEGER(UNSIGNED(WA)) < reg_file_depth)) THEN
            -- write enabled and WA_index isn't 0 (location that shouldn't be written to and within bounds then write to reg_file
                reg_file(TO_INTEGER(UNSIGNED(WA))) <= WD;
            END IF;
        END IF;
   END PROCESS async_reset_write;


   ----------------------------------

END behav;
