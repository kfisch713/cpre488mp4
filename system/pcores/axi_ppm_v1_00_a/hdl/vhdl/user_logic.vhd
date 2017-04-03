------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Wed Jan  8 12:18:19 2014 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_NUM_REG                    -- Number of software accessible registers
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Resetn                -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_NUM_REG                      : integer              := 32;
    C_SLV_DWIDTH                   : integer              := 32
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
	PCTX_in	: in std_logic;
	PCTX_out : out std_logic;
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Resetn                  : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    Bus2IP_BE                      : in  std_logic_vector(C_SLV_DWIDTH/8-1 downto 0);
    Bus2IP_RdCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    Bus2IP_WrCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    IP2Bus_Data                    : out std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute MAX_FANOUT : string;
  attribute SIGIS : string;

  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Resetn : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg0                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg1                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg2                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg3                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg4                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg5                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg6                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg7                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg8                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg9                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg10                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg11                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg12                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg13                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg14                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg15                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg16                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg17                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg18                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg19                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg20                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg21                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg22                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg23                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg24                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg25                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg26                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg27                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg28                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg29                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg30                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg31                      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg_write_sel              : std_logic_vector(31 downto 0);
  signal slv_reg_read_sel               : std_logic_vector(31 downto 0);
  signal slv_ip2bus_data                : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_read_ack                   : std_logic;
  signal slv_write_ack                  : std_logic;



  --USER signal declarations added here, as needed for user logic
  -- Assume a 100 MHz clock for the counter
  constant GAP420 : integer  := 42000; -- 420 us  = 10 ns * 42,000
  constant C5WIDTH : integer := 96000; -- 960 us = 10 ns * 96,000
  constant C6WIDTH : integer := 150000; -- 1.5 ms  = 10 ns * 150,000
  constant PERIOD_LENGTH : integer :=  2200000; -- 22 ms = 10 ns * 2,200,000 (22 bits)
  constant IDLE_HIGH_LENGTH: integer := 300000; -- 3 ms = 10 ns * 300000

  -- Default channel widths for roll, yaw, pitch should be middle of available widths
  -- Default for throttle should be minimum.
  -- Throttle is channel 3
  constant DEFAULT_CH_WIDTH        : std_logic_vector := x"1a5e0"; -- 108000; -- 1.08 ms = 10 ns * 108000
  constant DEFAULT_THROTTLE_WIDTH  : std_logic_vector := x"101d0"; -- 66000;  -- 660  us = 10 ns * 66000

	
  type STATE_TYPE is (IDLE_low, IDLE_hi, C1_low, C1_hi,
                    C2_low, C2_hi, C3_low, C3_hi, C4_low, C4_hi,
                    C5_low, C5_hi, C6_low, C6_hi);


 type STATE_WIDTH_TYPE is (cap_IDLE_low, cap_IDLE_hi, cap_wait_for_low, cap_C1_low,
                          cap_C1_hi, cap_C2_low, cap_C2_hi, cap_C3_low,
                          cap_C3_hi, cap_C4_low, cap_C4_hi, cap_LOAD_OUT);


  signal curr_state : STATE_TYPE;  -- current state
  signal nxt_state  : STATE_TYPE; -- next state

  signal curr_width_state : STATE_WIDTH_TYPE;  -- current state
  signal nxt_width_state  : STATE_WIDTH_TYPE; -- next state


  -- register last 4 sampled PCTx_in values
  signal PCTx_in_reg    : std_logic_vector(3 downto 0);
  signal PCTx_out_tmp   : std_logic;  -- combinational output to RC controller
  signal PCTx_out_reg   : std_logic;  -- register output to RC controller
  signal high_low_event : std_logic;  -- Flag bottom of a PPM pulse
  signal low_high_event : std_logic;  -- Flag top of a PMM pulse

  signal start_capture : std_logic;  -- Start channel width state machine
  signal channel_timeout_reset : std_logic; -- Reset channel timeout
  signal period_timer_reset : std_logic; -- Reset period timer

  signal reset_width_counter : std_logic;  -- Reset width_counter
  signal ld_channel_1 : std_logic;  -- load channel 1 pulse width 
  signal ld_channel_2 : std_logic;  -- load channel 2 pulse width 
  signal ld_channel_3 : std_logic;  -- load channel 3 pulse width 
  signal ld_channel_4 : std_logic;  -- load channel 4 pulse width 

  -- Compare to c1/2/3/4_widths
  signal channel_timeout : std_logic_vector(19 downto 0); --check for end channel
  signal width_counter  : std_logic_vector(19 downto 0); --measure channel width
  signal period_timer   : std_logic_vector(21 downto 0); -- Use to measure time of total period

  signal cur_c1_width_reg  : std_logic_vector(19 downto 0);
  signal cur_c2_width_reg  : std_logic_vector(19 downto 0);
  signal cur_c3_width_reg  : std_logic_vector(19 downto 0);
  signal cur_c4_width_reg  : std_logic_vector(19 downto 0);

  signal c1_width_out_tmp  : std_logic_vector(19 downto 0); -- pass measured channel widths to PPM generater
  signal c2_width_out_tmp  : std_logic_vector(19 downto 0);
  signal c3_width_out_tmp  : std_logic_vector(19 downto 0);
  signal c4_width_out_tmp  : std_logic_vector(19 downto 0);

  signal load_cur_widths : std_logic; -- flag to load cur_width regs with values from next_width regs

  signal loadCh_out_tmp  : std_logic; -- flag to drive loading of pulse widths to send back to SW 
                                    -- and/or to forwared to PPM genrator to bypass SW.    
  -- test signal for debugging
  signal period_pass : std_logic; 




begin

  --USER logic implementation added here
  
  ------------------------------------------------------------
  ------------------------------------------------------------
  --                                                        --
  -- Process Name: UPDATE_state                             --
  -- Description: Assign next state to current state        --
  --                                                        --
  ------------------------------------------------------------
  ------------------------------------------------------------
  UPDATE_state : process(Bus2IP_Clk)
  begin
    if (Bus2IP_Clk = '1' and Bus2IP_Clk'event) then

      if (Bus2IP_Resetn = '0') then
        curr_state       <= IDLE_hi;
        curr_width_state <= cap_IDLE_hi;
      else
        curr_state        <= nxt_state;
        curr_width_state  <= nxt_width_state;
      end if;
    end if;
  end process UPDATE_state;

 
  
  
  ------------------------------------------------------------
  ------------------------------------------------------------
  --                                                        --
  -- Process Name: Generate_PPM                             --
  -- Description: Generate PPM for channels 1 - 6, filter.  --
  -- channels 7-9.  Generate a 420 us inter-channel gap.    --
  ------------------------------------------------------------
  ------------------------------------------------------------
  Generate_PPM : process(curr_state, high_low_event, channel_timeout, period_timer,
                         cur_c1_width_reg, cur_c2_width_reg, cur_c3_width_reg, cur_c4_width_reg )
  begin

    -- defaults
    nxt_state             <= curr_state;
    start_capture         <= '0';
    channel_timeout_reset <= '0';
    period_timer_reset    <= '0';
    PCTx_out_tmp          <= '1';
    load_cur_widths       <= '0';
    period_pass           <= '0';

    case curr_state is

    when IDLE_hi =>

      PCTx_out_tmp <= '1';
      -- Check that we have
      -- have had a high to low transition on the PXTc input.
      -- This should guarantee we have found the start of the first
      -- channel.
      -- Note that period_timer = PERIOD_LENGTH is okay
      -- because period_timer halts count once PERIOD_LENGTH is reached
      if ( period_timer = PERIOD_LENGTH ) then
        period_pass <= '1';
        channel_timeout_reset <= '1';
        start_capture <= '1';  -- Start channel width measure state machine 
        nxt_state <= C1_low;
      
        -- New output period is beginning, so update the channel widths
        period_timer_reset <= '1';
        load_cur_widths <= '1';
      end if;    
    
    -- channel 1 low part of pulse
     when C1_low =>
      PCTx_out_tmp <= '0';
      if(channel_timeout > GAP420) then
        channel_timeout_reset <= '1';
        nxt_state <= C1_hi;       
      end if;

    -- channel 1 high part of pulse
    when C1_hi =>
      PCTx_out_tmp <= '1';    
      if(channel_timeout > cur_c1_width_reg) then
        channel_timeout_reset <= '1';
        nxt_state <= C2_low;
      end if;

  -- channel 2 low part of pulse
  when C2_low =>
    PCTx_out_tmp <= '0';
    if(channel_timeout > GAP420) then
      channel_timeout_reset <= '1';
      nxt_state <= C2_hi;
    end if;

  -- channel 2 high part of pulse
  when C2_hi =>
    PCTx_out_tmp <= '1';    
    if(channel_timeout > cur_c2_width_reg) then
      channel_timeout_reset <= '1';
      nxt_state <= C3_low;
    end if;

  -- channel 3 low part of pulse
  when C3_low =>
    PCTx_out_tmp <= '0';
    if(channel_timeout > GAP420) then
      channel_timeout_reset <= '1';
      nxt_state <= C3_hi;
    end if;

  -- channel 3 high part of pulse
  when C3_hi =>
    PCTx_out_tmp <= '1';    
    if(channel_timeout > cur_c3_width_reg) then
      channel_timeout_reset <= '1';
      nxt_state <= C4_low;
    end if;

   -- channel 4 low part of pulse
  when C4_low =>
    PCTx_out_tmp <= '0';
    if(channel_timeout > GAP420) then
      channel_timeout_reset <= '1';
      nxt_state <= C4_hi;
    end if;

  -- channel 4 high part of pulse
  when C4_hi =>
    PCTx_out_tmp <= '1';    
    if(channel_timeout > cur_c4_width_reg) then
      channel_timeout_reset <= '1';
      nxt_state <= C5_low;
    end if;

   -- channel 5 low part of pulse
  when C5_low =>
    PCTx_out_tmp <= '0';
    if(channel_timeout > GAP420) then
      channel_timeout_reset <= '1';
      nxt_state <= C5_hi;
    end if;

  -- channel 5 high part of pulse
  when C5_hi =>
    PCTx_out_tmp <= '1';    
    if(channel_timeout > C5WIDTH) then
      -- no c5_width reset because c5_width is constant
      channel_timeout_reset <= '1';
      nxt_state <= C6_low;
    end if;

   -- channel 6 low part of pulse
  when C6_low =>
    PCTx_out_tmp <= '0';
    if(channel_timeout > GAP420) then
      channel_timeout_reset <= '1';
      nxt_state <= C6_hi;
    end if;

  -- channel 6 high part of pulse
  when C6_hi =>
    PCTx_out_tmp <= '1';    
    if(channel_timeout > C6WIDTH) then
      -- no c6_width reset because c6_width is constant
      channel_timeout_reset <= '1';
      nxt_state <= IDLE_low;
    end if;

   -- Channel IDLE low part of pulse. Filtered channels 7-9 of
   -- PXTc cable by holding PCTx_out_temp high while in
   -- IDLE_hi
  when IDLE_low =>
    PCTx_out_tmp <= '0';
    if(channel_timeout > GAP420) then
      channel_timeout_reset <= '1';
      nxt_state <= IDLE_hi;
    end if;
    
  when others =>
    nxt_state <= IDLE_hi;
    PCTx_out_tmp <= '1';
    
  end case;

              
end process Generate_PPM;


------------------------------------------------------------
------------------------------------------------------------
--                                                        --
-- Process Name: Cap_chan_width                           --
-- Description: Captures the width for channels 1-6 of    --
-- of the PXTc input.  Also filters out channels 7-9.     --
------------------------------------------------------------
------------------------------------------------------------
Cap_chan_width: process(curr_width_state, low_high_event, high_low_event,
                        width_counter)
begin

  -- defaults
  nxt_width_state     <= curr_width_state;
  reset_width_counter <= '0';
  loadCh_out_tmp      <= '0';
  ld_channel_1        <= '0';
  ld_channel_2        <= '0';
  ld_channel_3        <= '0';
  ld_channel_4        <= '0';
  

  case curr_width_state is

  when cap_IDLE_hi =>

    -- Reset width_counter if does not stay high for at least 3 ms
	 -- i.e. a normal pulse occured (less than 3ms), not an Idle pulse
    if(high_low_event = '1') then
      reset_width_counter <= '1';
	 end if;

    -- Wait for Input PPM to stay high for at least 3ms (find idle pulse)
    if(width_counter > IDLE_HIGH_LENGTH) then
      nxt_width_state <= cap_wait_for_low;
    end if;    
    
  -- Make sure that incoming PCTx channel goes low
  -- Without this state, cap_C1_low may exit to cap_C1_hi too early  
  -- because low_high_event will be 1 due to idle signal being high
  when cap_wait_for_low =>
    if(high_low_event = '1') then
      nxt_width_state <= cap_C1_low;
    end if;

		
  -- channel 1 low part of pulse
  when cap_C1_low =>
    if(low_high_event = '1') then
      reset_width_counter <= '1';
      nxt_width_state <= cap_C1_hi;
    end if;

  -- channel 1 high part of pulse. Capture pulse width
  when cap_C1_hi =>    
    if(high_low_event = '1') then
      ld_channel_1 <= '1';
      nxt_width_state <= cap_C2_low;
    end if;

  -- channel 2 low part of pulse
  when cap_C2_low =>
    if(low_high_event = '1') then
      reset_width_counter <= '1';
      nxt_width_state <= cap_C2_hi;
    end if;

  -- channel 2 high part of pulse. Capture pulse width
  when cap_C2_hi =>    
    if(high_low_event = '1') then
      ld_channel_2 <= '1';
      nxt_width_state <= cap_C3_low;
    end if;

  -- channel 3 low part of pulse
  when cap_C3_low =>
    if(low_high_event = '1') then
      reset_width_counter <= '1';
      nxt_width_state <= cap_C3_hi;
    end if;

  -- channel 3 high part of pulse. Capture pulse width
  when cap_C3_hi =>    
    if(high_low_event = '1') then
      ld_channel_3 <= '1';
      nxt_width_state <= cap_C4_low;
    end if;

   -- channel 4 low part of pulse
  when cap_C4_low =>
    if(low_high_event = '1') then
      reset_width_counter <= '1';
      nxt_width_state <= cap_C4_hi;
    end if;

  -- channel 4 high part of pulse. Capture pulse width
  when cap_C4_hi =>    
    if(high_low_event = '1') then
      ld_channel_4 <= '1';
      nxt_width_state <= cap_LOAD_OUT;
    end if;
    
  -- Set loadCh_out high for one clock
  when cap_LOAD_OUT =>
    nxt_width_state <= cap_IDLE_low;
    loadCh_out_tmp <= '1';

   -- Treat channel 5 low as if it were the low pulse of Idle,
   -- then jump to waiting for the next IDLE_high.  Effectively
   -- filter channel 7 - 9 of the PXTc cable out.
   -- Since we are not using channel 5 or 6 Generate_PPM will
   -- set their pulse widths to match the RC controller.
   -- Channel 5 -> 1.18 ms, Channel 6 -> 1.5 ms.
  when cap_IDLE_low =>
    if(low_high_event = '1') then
	   reset_width_counter <= '1';
      nxt_width_state <= cap_IDLE_hi;
    end if;
    
  when others =>
    nxt_width_state <= cap_IDLE_hi;
    
  end case;
              
end process Cap_chan_width;
 

------------------------------------------------------------
------------------------------------------------------------
--                                                        --
-- Process Name:Manage_Cnt_Reg                            --
-- Description: Manage counters and registers             --
--                                                        --
------------------------------------------------------------
------------------------------------------------------------
Manage_Cnt_Reg: process(Bus2IP_Clk)
begin
  if (Bus2IP_Clk = '1' and Bus2IP_Clk'event) then

    -- reset registers and counters
    if (Bus2IP_Resetn = '0') then
      
      channel_timeout <= (others => '0');  -- compare to c1/2/3/4_width
      width_counter   <= (others => '0');  -- measure channel width 
      period_timer    <= (others => '0');  -- see if period expired 
      PCTx_in_reg     <= (others => '0');
      PCTx_out_reg    <= '1';
      
      cur_c1_width_reg  <= DEFAULT_CH_WIDTH;
      cur_c2_width_reg  <= DEFAULT_CH_WIDTH;
      cur_c3_width_reg  <= DEFAULT_THROTTLE_WIDTH;
      cur_c4_width_reg  <= DEFAULT_CH_WIDTH;

      c1_width_out_tmp  <= DEFAULT_CH_WIDTH;
      c2_width_out_tmp  <= DEFAULT_CH_WIDTH;
	   c3_width_out_tmp  <= DEFAULT_CH_WIDTH;
		c4_width_out_tmp  <= DEFAULT_CH_WIDTH;
		
		slv_reg1 <= (others => '0'); -- frame counter reg
		slv_reg10 <= x"000" & DEFAULT_CH_WIDTH;
		slv_reg11 <= x"000" & DEFAULT_CH_WIDTH;
		slv_reg12 <= x"000" & DEFAULT_THROTTLE_WIDTH;
		slv_reg13 <= x"000" & DEFAULT_CH_WIDTH;

		
    else
      
      -- Flag indicates the input channel widths
      -- should be latched
		-- phjones test: HW pass capturered channel with directly to PPM generator
      if(loadCh_out_tmp = '1') then
			slv_reg1 <= slv_reg1 + '1';
         slv_reg10(19 downto 0) <= c1_width_out_tmp;
         slv_reg11(19 downto 0) <= c2_width_out_tmp;
         slv_reg12(19 downto 0) <= c3_width_out_tmp;
         slv_reg13(19 downto 0) <= c4_width_out_tmp;         
      end if;
      
      -- When a new period begins, start to use
      -- the newest input channel widths
      if(load_cur_widths = '1') then
         cur_c1_width_reg <= slv_reg20(19 downto 0);
         cur_c2_width_reg <= slv_reg21(19 downto 0);
         cur_c3_width_reg <= slv_reg22(19 downto 0);
         cur_c4_width_reg <= slv_reg23(19 downto 0);
      end if;

      -- Time how long to keep a channel high
      if(channel_timeout_reset = '1') then
        channel_timeout <= (others => '0');
      else
        channel_timeout <= channel_timeout + 1;
      end if;    
      
      -- Use to measure the width of each PPM channel
      if(reset_width_counter = '1') then
        width_counter <= (others => '0');
      else
        width_counter <= width_counter + 1;
      end if;
      
      -- Stop period timer once at PERIOD LENGTH
      -- to prevent rollover
      if(period_timer_reset = '1') then
         period_timer <= (others => '0' );
      elsif(period_timer < PERIOD_LENGTH) then
         period_timer <= period_timer + 1;
      end if;

      -- Load the width_reg for each channel
      -- Used to help PPM_Generator to reproduce the
      -- PTXc PPM signal with a 420 us inter-pulse gaps
      if(ld_channel_1 = '1') then
        c1_width_out_tmp <= width_counter;
      end if;

      if(ld_channel_2 = '1') then
        c2_width_out_tmp <= width_counter;
      end if;

      if(ld_channel_3 = '1') then
        c3_width_out_tmp <= width_counter;
      end if;

      if(ld_channel_4 = '1') then
        c4_width_out_tmp <= width_counter;
      end if;
  
     -- Shift register for last 4 PXTc input values
     PCTx_in_reg(0) <= PCTx_in;
     PCTx_in_reg(1) <= PCTx_in_reg(0);
     PCTx_in_reg(2) <= PCTx_in_reg(1); 
     PCTx_in_reg(3) <= PCTx_in_reg(2);

     -- register output to RC controller
     PCTx_out_reg <= PCTx_out_tmp;
      
    end if;

  end if;
end process Manage_Cnt_Reg;



  -- Goes high if PPM high for more than four clock cycles
low_high_event <= PCTx_in_reg(0) and PCTx_in_reg(1) and
                  PCTx_in_reg(2) and PCTx_in_reg(3);

  -- Goes high if PPM low for more than four clock cycles
high_low_event <= not (PCTx_in_reg(0) or PCTx_in_reg(1) or
                  PCTx_in_reg(2) or PCTx_in_reg(3));

-- Bit 0 of slv_reg0 determines hardware versus software relay
PCTx_out <= PCTx_out_reg when (slv_reg0(0) = '1') else PCTx_in;  






  ------------------------------------------
  -- Example code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(31 downto 0);
  slv_reg_read_sel  <= Bus2IP_RdCE(31 downto 0);
  slv_write_ack     <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2) or Bus2IP_WrCE(3) or Bus2IP_WrCE(4) or Bus2IP_WrCE(5) or Bus2IP_WrCE(6) or Bus2IP_WrCE(7) or Bus2IP_WrCE(8) or Bus2IP_WrCE(9) or Bus2IP_WrCE(10) or Bus2IP_WrCE(11) or Bus2IP_WrCE(12) or Bus2IP_WrCE(13) or Bus2IP_WrCE(14) or Bus2IP_WrCE(15) or Bus2IP_WrCE(16) or Bus2IP_WrCE(17) or Bus2IP_WrCE(18) or Bus2IP_WrCE(19) or Bus2IP_WrCE(20) or Bus2IP_WrCE(21) or Bus2IP_WrCE(22) or Bus2IP_WrCE(23) or Bus2IP_WrCE(24) or Bus2IP_WrCE(25) or Bus2IP_WrCE(26) or Bus2IP_WrCE(27) or Bus2IP_WrCE(28) or Bus2IP_WrCE(29) or Bus2IP_WrCE(30) or Bus2IP_WrCE(31);
  slv_read_ack      <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2) or Bus2IP_RdCE(3) or Bus2IP_RdCE(4) or Bus2IP_RdCE(5) or Bus2IP_RdCE(6) or Bus2IP_RdCE(7) or Bus2IP_RdCE(8) or Bus2IP_RdCE(9) or Bus2IP_RdCE(10) or Bus2IP_RdCE(11) or Bus2IP_RdCE(12) or Bus2IP_RdCE(13) or Bus2IP_RdCE(14) or Bus2IP_RdCE(15) or Bus2IP_RdCE(16) or Bus2IP_RdCE(17) or Bus2IP_RdCE(18) or Bus2IP_RdCE(19) or Bus2IP_RdCE(20) or Bus2IP_RdCE(21) or Bus2IP_RdCE(22) or Bus2IP_RdCE(23) or Bus2IP_RdCE(24) or Bus2IP_RdCE(25) or Bus2IP_RdCE(26) or Bus2IP_RdCE(27) or Bus2IP_RdCE(28) or Bus2IP_RdCE(29) or Bus2IP_RdCE(30) or Bus2IP_RdCE(31);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Resetn = '0' then
        slv_reg0 <= (others => '0');
--        slv_reg1 <= (others => '0');
        slv_reg2 <= (others => '0');
        slv_reg3 <= (others => '0');
        slv_reg4 <= (others => '0');
        slv_reg5 <= (others => '0');
        slv_reg6 <= (others => '0');
        slv_reg7 <= (others => '0');
        slv_reg8 <= (others => '0');
        slv_reg9 <= (others => '0');
--        slv_reg10 <= (others => '0');
--        slv_reg11 <= (others => '0');
--        slv_reg12 <= (others => '0');
--        slv_reg13 <= (others => '0');
        slv_reg14 <= (others => '0');
        slv_reg15 <= (others => '0');
        slv_reg16 <= (others => '0');
        slv_reg17 <= (others => '0');
        slv_reg18 <= (others => '0');
        slv_reg19 <= (others => '0');
		slv_reg20 <= x"000" & DEFAULT_CH_WIDTH;
		slv_reg21 <= x"000" & DEFAULT_CH_WIDTH;
		slv_reg22 <= x"000" & DEFAULT_THROTTLE_WIDTH;
		slv_reg23 <= x"000" & DEFAULT_CH_WIDTH;
        slv_reg24 <= (others => '0');
        slv_reg25 <= (others => '0');
        slv_reg26 <= (others => '0');
        slv_reg27 <= (others => '0');
        slv_reg28 <= (others => '0');
        slv_reg29 <= (others => '0');
        slv_reg30 <= (others => '0');
        slv_reg31 <= (others => '0');
      else
        case slv_reg_write_sel is
          when "10000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg0(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "01000000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
--                slv_reg1(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00100000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg2(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00010000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg3(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00001000000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg4(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000100000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg5(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000010000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg6(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000001000000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg7(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000100000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg8(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000010000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg9(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000001000000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
 --               slv_reg10(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000100000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
 --               slv_reg11(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000010000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
 --               slv_reg12(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000001000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
 --               slv_reg13(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000100000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg14(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000010000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg15(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000001000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg16(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000100000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg17(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000010000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg18(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000001000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg19(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000100000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg20(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000010000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg21(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000001000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg22(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000100000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg23(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000010000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg24(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000001000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg25(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000000100000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg26(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000000010000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg27(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000000001000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg28(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000000000100" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg29(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000000000010" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg30(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "00000000000000000000000000000001" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg31(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when others => null;
        end case;
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : process( slv_reg_read_sel, slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6, slv_reg7, slv_reg8, slv_reg9, slv_reg10, slv_reg11, slv_reg12, slv_reg13, slv_reg14, slv_reg15, slv_reg16, slv_reg17, slv_reg18, slv_reg19, slv_reg20, slv_reg21, slv_reg22, slv_reg23, slv_reg24, slv_reg25, slv_reg26, slv_reg27, slv_reg28, slv_reg29, slv_reg30, slv_reg31 ) is
  begin

    case slv_reg_read_sel is
      when "10000000000000000000000000000000" => slv_ip2bus_data <= slv_reg0;
      when "01000000000000000000000000000000" => slv_ip2bus_data <= slv_reg1;
      when "00100000000000000000000000000000" => slv_ip2bus_data <= slv_reg2;
      when "00010000000000000000000000000000" => slv_ip2bus_data <= slv_reg3;
      when "00001000000000000000000000000000" => slv_ip2bus_data <= slv_reg4;
      when "00000100000000000000000000000000" => slv_ip2bus_data <= slv_reg5;
      when "00000010000000000000000000000000" => slv_ip2bus_data <= slv_reg6;
      when "00000001000000000000000000000000" => slv_ip2bus_data <= slv_reg7;
      when "00000000100000000000000000000000" => slv_ip2bus_data <= slv_reg8;
      when "00000000010000000000000000000000" => slv_ip2bus_data <= slv_reg9;
      when "00000000001000000000000000000000" => slv_ip2bus_data <= slv_reg10;
      when "00000000000100000000000000000000" => slv_ip2bus_data <= slv_reg11;
      when "00000000000010000000000000000000" => slv_ip2bus_data <= slv_reg12;
      when "00000000000001000000000000000000" => slv_ip2bus_data <= slv_reg13;
      when "00000000000000100000000000000000" => slv_ip2bus_data <= slv_reg14;
      when "00000000000000010000000000000000" => slv_ip2bus_data <= slv_reg15;
      when "00000000000000001000000000000000" => slv_ip2bus_data <= slv_reg16;
      when "00000000000000000100000000000000" => slv_ip2bus_data <= slv_reg17;
      when "00000000000000000010000000000000" => slv_ip2bus_data <= slv_reg18;
      when "00000000000000000001000000000000" => slv_ip2bus_data <= slv_reg19;
      when "00000000000000000000100000000000" => slv_ip2bus_data <= slv_reg20;
      when "00000000000000000000010000000000" => slv_ip2bus_data <= slv_reg21;
      when "00000000000000000000001000000000" => slv_ip2bus_data <= slv_reg22;
      when "00000000000000000000000100000000" => slv_ip2bus_data <= slv_reg23;
      when "00000000000000000000000010000000" => slv_ip2bus_data <= slv_reg24;
      when "00000000000000000000000001000000" => slv_ip2bus_data <= slv_reg25;
      when "00000000000000000000000000100000" => slv_ip2bus_data <= slv_reg26;
      when "00000000000000000000000000010000" => slv_ip2bus_data <= slv_reg27;
      when "00000000000000000000000000001000" => slv_ip2bus_data <= slv_reg28;
      when "00000000000000000000000000000100" => slv_ip2bus_data <= slv_reg29;
      when "00000000000000000000000000000010" => slv_ip2bus_data <= slv_reg30;
      when "00000000000000000000000000000001" => slv_ip2bus_data <= slv_reg31;
      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data  <= slv_ip2bus_data when slv_read_ack = '1' else
                  (others => '0');

  IP2Bus_WrAck <= slv_write_ack;
  IP2Bus_RdAck <= slv_read_ack;
  IP2Bus_Error <= '0';

end IMP;
