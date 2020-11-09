LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.my_package.ALL;

ENTITY InstrMem IS
   PORT( 
      A     : IN  std_logic_vector (n_bits_address - 1 DOWNTO 0);
      rst   : IN  std_logic;
      Instr : OUT std_logic_vector (instr_mem_width - 1 DOWNTO 0)
   );
END InstrMem;

ARCHITECTURE behav OF InstrMem IS

   -- Internal signal declarations
   SIGNAL instr_mem  : mem_type(0 to instr_mem_depth - 1);
   SIGNAL A_index : std_logic_vector (A'length - 1 DOWNTO 0);

BEGIN

   -- **************************** --
   -- DO NOT MODIFY or CHANGE the ---
   -- code template provided above --
   -- **************************** --
   
   ----- insert your code here ------


    
    -- Asynchronous instruction read, resets when reset = 1, otherwise, reads instructions
    async_instr_read : PROCESS (rst, A)
    ---------------------------------------------------------------------------
    BEGIN
      Instr <= (others => '0'); -- Default instruction is NOP (No OPeration)
      -- Asynchronous reset
      IF (rst = '1') THEN
        -- Instruction mem is from my_program
        instr_mem <= my_program;
      -- Address guard
      ELSIF ((TO_INTEGER(UNSIGNED(A)- TO_INTEGER(UNSIGNED(text_segment_start)))/4) >= 0 AND (TO_INTEGER(UNSIGNED(A)- TO_INTEGER(UNSIGNED(text_segment_start)))/4) < instr_mem_depth) THEN
      -- with mapping
         Instr <= instr_mem((TO_INTEGER(UNSIGNED(A)- TO_INTEGER(UNSIGNED(text_segment_start)))/4));
      -- If out of bounds read 0s
      ELSE
         Instr <= zeros;
      END IF;
    END PROCESS async_instr_read;

   ----------------------------------

END behav;
