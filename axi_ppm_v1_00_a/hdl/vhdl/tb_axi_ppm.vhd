
  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

library axi_ppm_v1_00_a;
use axi_ppm_v1_00_a.all;



  ENTITY tb_axi_ppm IS
  END tb_axi_ppm;

  ARCHITECTURE behavior OF tb_axi_ppm IS 

  -- Component Declaration
          COMPONENT axi_ppm
				generic(C_S_AXI_DATA_WIDTH             : integer;
						  C_S_AXI_ADDR_WIDTH             : integer;
						  C_S_AXI_MIN_SIZE               : std_logic_vector;
						  C_USE_WSTRB                    : integer;
						  C_DPHASE_TIMEOUT               : integer;
						  C_BASEADDR                     : std_logic_vector;
						  C_HIGHADDR                     : std_logic_vector;
						  C_FAMILY                       : string;
						  C_NUM_REG                      : integer;
						  C_NUM_MEM                      : integer;
						  C_SLV_AWIDTH                   : integer;
						  C_SLV_DWIDTH                   : integer);
          PORT(PCTX_in    							: in std_logic;
					PCTX_out 								: out std_logic;
					S_AXI_ACLK                     : in  std_logic;
					S_AXI_ARESETN                  : in  std_logic;
					S_AXI_AWADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
					S_AXI_AWVALID                  : in  std_logic;
					S_AXI_WDATA                    : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
					S_AXI_WSTRB                    : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
					S_AXI_WVALID                   : in  std_logic;
					S_AXI_BREADY                   : in  std_logic;
					S_AXI_ARADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
					S_AXI_ARVALID                  : in  std_logic;
					S_AXI_RREADY                   : in  std_logic;
					S_AXI_ARREADY                  : out std_logic;
					S_AXI_RDATA                    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
					S_AXI_RRESP                    : out std_logic_vector(1 downto 0);
					S_AXI_RVALID                   : out std_logic;
					S_AXI_WREADY                   : out std_logic;
					S_AXI_BRESP                    : out std_logic_vector(1 downto 0);
					S_AXI_BVALID                   : out std_logic;
					S_AXI_AWREADY                  : out std_logic);
          END COMPONENT;

  SIGNAL sPCTX_in, sPCTX_out, clk, rstn :  std_logic;

  --USER signal declarations added here, as needed for user logic
  -- Assume a 100 MHz clock for the counter
  constant GAP420 : time := 420 us; -- 420 us  = 10 ns * 42,000
  constant C5WIDTH : time := 960 us; -- 960 = 10 ns * 96,000
  constant C6WIDTH : time := 1.5 ms; -- 1.5 ms  = 10 ns * 150,000
  constant PERIOD_LENGTH : time := 22 ms; -- 22 ms = 10 ns * 2,200,000 (22 bits)
  constant IDLE_HIGH_LENGTH: time := 3 ms; -- 3 ms = 10 ns * 300000

  -- Default channel widths for roll, yaw, pitch should be middle of available widths
  -- Default for throttle should be minimum.
  -- Throttle is channel 3
  constant DEFAULT_CH_WIDTH        : time := 1.08 ms;
  constant DEFAULT_THROTTLE_WIDTH  : time := 660 us;

        
  BEGIN

		tb_pctxin : process
		begin

			-- Assume missed first PPM frame
			sPCTX_in <= '1';wait for 4 ms;
			
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C6WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for 4 ms;
			
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_CH_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_CH_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C6WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for 4 ms;


			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_CH_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_THROTTLE_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for DEFAULT_CH_WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C6WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for 4 ms;


			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C5WIDTH;
			sPCTX_in <= '0';wait for GAP420;
			sPCTX_in <= '1';wait for C6WIDTH;
			sPCTX_in <= '0';wait for GAP420;


			
		end process;


  -- Component Instantiation
          uut: axi_ppm 
	   		generic map(C_S_AXI_DATA_WIDTH  => 32,
						  C_S_AXI_ADDR_WIDTH      => 32,
						  C_S_AXI_MIN_SIZE        => X"000001FF",
						  C_USE_WSTRB             => 0,
						  C_DPHASE_TIMEOUT        => 8,
						  C_BASEADDR              => X"FFFFFFFF",
						  C_HIGHADDR              => X"00000000",
						  C_FAMILY                => "virtex6",
						  C_NUM_REG               => 1,
						  C_NUM_MEM               => 1,
						  C_SLV_AWIDTH            => 32,
						  C_SLV_DWIDTH            => 32)
	 			 
			 PORT MAP(
					PCTX_in    		=> sPCTX_in,
					PCTX_out 	   => sPCTX_out,
					S_AXI_ACLK     => clk,
					S_AXI_ARESETN  => rstn,
					S_AXI_AWADDR   => (others=> '0'),
					S_AXI_AWVALID  => '0',
					S_AXI_WDATA    => (others=> '0'),
					S_AXI_WSTRB    => (others=> '0'),
					S_AXI_WVALID   => '0',
					S_AXI_BREADY   => '0',
					S_AXI_ARADDR   => (others=> '0'),
					S_AXI_ARVALID  => '0',
					S_AXI_RREADY   => '0',
					S_AXI_ARREADY  => open,
					S_AXI_RDATA    => open,
					S_AXI_RRESP    => open,
					S_AXI_RVALID   => open,
					S_AXI_WREADY   => open,
					S_AXI_BRESP    => open,
					S_AXI_BVALID   => open,
					S_AXI_AWREADY  => open);


     tb_clk : PROCESS
     BEGIN
		  clk <= '0'; wait for 5 ns;
		  clk <= '1'; wait for 5 ns;
     END PROCESS;

     tb_rstn : process
	  begin
			rstn <= '0'; wait for 500 ns;
			rstn <= '1'; wait;
	  end process;

  END;
