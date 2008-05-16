Return-Path: <kernelppc@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 5EBA2DE179
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 00:55:07 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so387915nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 07:55:05 -0700 (PDT)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: OCM instruction memory
Date: Fri, 16 May 2008 16:56:33 +0200
Message-ID: <009401c8b765$08d02de0$1a7089a0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,
I have a problem with OCM instruction memory.
When I create a simple hardware design without OCM instruction memory, I can
easily run Linux on it.
But, when I add an OCM instruction cache with the size 128K, the system
freezes at this point:

loaded at:     00400000 004CE1A0
board data at: 004CC120 004CC19C
relocated to:  00404050 004040CC
zimage at:     00404E88 004CBE3E
avail ram:     004CF000 10000000

Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2
Uncompressing Linux...done.
Now booting the kernel


I already test the memory and it's ok. I asked my pervious question about
system ACE because of this problem. Actually I thought that the linux image
might be copied to the OCM instruction memory. If the linux image is copied
to the address zero which my DDR is mapped there, there should be no
difference between the platform with OCM and without? 

Can you please help me on this issue?

Best regards,
Mojtaba


# 
#
############################################################################
##
# 
# Created by Base System Builder Wizard for Xilinx EDK 9.1.02 Build
EDK_J_SP2.4
# 
# Fri May 16 15:06:06 2008
# 
# Target Board:  Xilinx Virtex-4 ML410 Evaluation Platform Rev B
# Family:	 virtex4
# Device:	 XC4VFX60
# Package:	 ff1152
# Speed Grade:	 -11
# 
# Processor: PPC 405
# Processor clock frequency: 300.000000 MHz
# Bus clock frequency: 100.000000 MHz
# Debug interface: FPGA JTAG
# On Chip Memory : 256 KB
# Total Off Chip Memory : 256 MB
#   - DDR2_SDRAM_32Mx64 = 256 MB
# 
#
############################################################################
##


 PARAMETER VERSION = 2.1.0


 PORT fpga_0_RS232_Uart_1_ctsN_pin = fpga_0_RS232_Uart_1_ctsN, DIR = I
 PORT fpga_0_RS232_Uart_1_rtsN_pin = fpga_0_RS232_Uart_1_rtsN, DIR = O
 PORT fpga_0_RS232_Uart_1_sin_pin = fpga_0_RS232_Uart_1_sin, DIR = I
 PORT fpga_0_RS232_Uart_1_sout_pin = fpga_0_RS232_Uart_1_sout, DIR = O
 PORT fpga_0_SysACE_CompactFlash_SysACE_CLK_pin =
fpga_0_SysACE_CompactFlash_SysACE_CLK, DIR = I
 PORT fpga_0_SysACE_CompactFlash_clk_enable_n_pin = net_vcc, DIR = O
 PORT fpga_0_SysACE_CompactFlash_SysACE_MPA_pin =
fpga_0_SysACE_CompactFlash_SysACE_MPA, DIR = O, VEC = [6:0]
 PORT fpga_0_SysACE_CompactFlash_SysACE_MPD_pin =
fpga_0_SysACE_CompactFlash_SysACE_MPD, DIR = IO, VEC = [15:0]
 PORT fpga_0_SysACE_CompactFlash_SysACE_CEN_pin =
fpga_0_SysACE_CompactFlash_SysACE_CEN, DIR = O
 PORT fpga_0_SysACE_CompactFlash_SysACE_OEN_pin =
fpga_0_SysACE_CompactFlash_SysACE_OEN, DIR = O
 PORT fpga_0_SysACE_CompactFlash_SysACE_WEN_pin =
fpga_0_SysACE_CompactFlash_SysACE_WEN, DIR = O
 PORT fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin =
fpga_0_SysACE_CompactFlash_SysACE_MPIRQ, DIR = I
 PORT fpga_0_ORGate_1_Res_pin = fpga_0_ORGate_1_Res, DIR = O
 PORT fpga_0_ORGate_1_Res_1_pin = fpga_0_ORGate_1_Res, DIR = O
 PORT fpga_0_ORGate_1_Res_2_pin = fpga_0_ORGate_1_Res, DIR = O
 PORT fpga_0_Ethernet_MAC_reset_sgmii_n_pin = net_gnd, DIR = O
 PORT fpga_0_Ethernet_MAC_PHY_tx_clk_pin = fpga_0_Ethernet_MAC_PHY_tx_clk,
DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_rx_clk_pin = fpga_0_Ethernet_MAC_PHY_rx_clk,
DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_dv_pin = fpga_0_Ethernet_MAC_PHY_dv, DIR = I
 PORT fpga_0_Ethernet_MAC_PHY_rx_data_pin = fpga_0_Ethernet_MAC_PHY_rx_data,
DIR = I, VEC = [3:0]
 PORT fpga_0_Ethernet_MAC_PHY_rx_er_pin = fpga_0_Ethernet_MAC_PHY_rx_er, DIR
= I
 PORT fpga_0_Ethernet_MAC_PHY_tx_er_pin = fpga_0_Ethernet_MAC_PHY_tx_er, DIR
= O
 PORT fpga_0_Ethernet_MAC_PHY_tx_en_pin = fpga_0_Ethernet_MAC_PHY_tx_en, DIR
= O
 PORT fpga_0_Ethernet_MAC_PHY_tx_data_pin = fpga_0_Ethernet_MAC_PHY_tx_data,
DIR = O, VEC = [3:0]
 PORT fpga_0_Ethernet_MAC_PHY_Mii_clk_pin = fpga_0_Ethernet_MAC_PHY_Mii_clk,
DIR = IO
 PORT fpga_0_Ethernet_MAC_PHY_Mii_data_pin =
fpga_0_Ethernet_MAC_PHY_Mii_data, DIR = IO
 PORT fpga_0_Ethernet_MAC_PHY_rst_n_pin = fpga_0_Ethernet_MAC_PHY_rst_n, DIR
= O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_ODT_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_ODT, DIR = O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_Addr_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_Addr, DIR = O, VEC = [0:12]
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_BankAddr_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_BankAddr, DIR = O, VEC = [0:1]
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_CASn_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_CASn, DIR = O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_CKE_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_CKE, DIR = O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_CSn_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_CSn, DIR = O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_RASn_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_RASn, DIR = O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_WEn_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_WEn, DIR = O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_DM_pin = fpga_0_DDR2_SDRAM_32Mx64_DDR_DM,
DIR = O, VEC = [0:7]
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_DQS_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_DQS, DIR = IO, VEC = [0:7]
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_DQSn_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_DQSn, DIR = IO, VEC = [0:7]
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_DQ_pin = fpga_0_DDR2_SDRAM_32Mx64_DDR_DQ,
DIR = IO, VEC = [0:63]
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_Clk_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_Clk, DIR = O
 PORT fpga_0_DDR2_SDRAM_32Mx64_DDR_Clkn_pin =
fpga_0_DDR2_SDRAM_32Mx64_DDR_Clkn, DIR = O
 PORT sys_clk_pin = dcm_clk_s, DIR = I, SIGIS = CLK, CLK_FREQ = 100000000
 PORT sys_rst_pin = sys_rst_s, DIR = I, RST_POLARITY = 0, SIGIS = RST


BEGIN ppc405_virtex4
 PARAMETER INSTANCE = ppc405_0
 PARAMETER HW_VER = 1.01.a
 BUS_INTERFACE JTAGPPC = jtagppc_0_0
 BUS_INTERFACE ISOCM = iocm
 BUS_INTERFACE IPLB = plb
 BUS_INTERFACE DPLB = plb
 PORT PLBCLK = sys_clk_s
 PORT C405RSTCHIPRESETREQ = C405RSTCHIPRESETREQ
 PORT C405RSTCORERESETREQ = C405RSTCORERESETREQ
 PORT C405RSTSYSRESETREQ = C405RSTSYSRESETREQ
 PORT RSTC405RESETCHIP = RSTC405RESETCHIP
 PORT RSTC405RESETCORE = RSTC405RESETCORE
 PORT RSTC405RESETSYS = RSTC405RESETSYS
 PORT BRAMISOCMCLK = sys_clk_s
 PORT EICC405EXTINPUTIRQ = EICC405EXTINPUTIRQ
 PORT CPMC405CLOCK = proc_clk_s
END

BEGIN ppc405_virtex4
 PARAMETER INSTANCE = ppc405_1
 PARAMETER HW_VER = 1.01.a
 BUS_INTERFACE JTAGPPC = jtagppc_0_1
END

BEGIN jtagppc_cntlr
 PARAMETER INSTANCE = jtagppc_0
 PARAMETER HW_VER = 2.00.a
 BUS_INTERFACE JTAGPPC0 = jtagppc_0_0
 BUS_INTERFACE JTAGPPC1 = jtagppc_0_1
END

BEGIN proc_sys_reset
 PARAMETER INSTANCE = reset_block
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_EXT_RESET_HIGH = 0
 PORT Ext_Reset_In = sys_rst_s
 PORT Slowest_sync_clk = sys_clk_s
 PORT Chip_Reset_Req = C405RSTCHIPRESETREQ
 PORT Core_Reset_Req = C405RSTCORERESETREQ
 PORT System_Reset_Req = C405RSTSYSRESETREQ
 PORT Rstc405resetchip = RSTC405RESETCHIP
 PORT Rstc405resetcore = RSTC405RESETCORE
 PORT Rstc405resetsys = RSTC405RESETSYS
 PORT Bus_Struct_Reset = sys_bus_reset
 PORT Dcm_locked = dcm_1_lock
END

BEGIN isocm_v10
 PARAMETER INSTANCE = iocm
 PARAMETER HW_VER = 2.00.b
 PARAMETER C_ISCNTLVALUE = 0xa5
 PORT ISOCM_Clk = sys_clk_s
 PORT sys_rst = sys_bus_reset
END

BEGIN isbram_if_cntlr
 PARAMETER INSTANCE = iocm_cntlr
 PARAMETER HW_VER = 3.00.b
 PARAMETER C_BASEADDR = 0xc0a00000
 PARAMETER C_HIGHADDR = 0xc0a1ffff
 BUS_INTERFACE ISOCM = iocm
 BUS_INTERFACE DCR_WRITE_PORT = isocm_porta
 BUS_INTERFACE INSTRN_READ_PORT = isocm_portb
END

BEGIN bram_block
 PARAMETER INSTANCE = isocm_bram
 PARAMETER HW_VER = 1.00.a
 BUS_INTERFACE PORTA = isocm_porta
 BUS_INTERFACE PORTB = isocm_portb
END

BEGIN plb_v34
 PARAMETER INSTANCE = plb
 PARAMETER HW_VER = 1.02.a
 PARAMETER C_DCR_INTFCE = 0
 PARAMETER C_NUM_OPBCLK_PLB2OPB_REARB = 100
 PARAMETER C_EXT_RESET_HIGH = 1
 PORT SYS_Rst = sys_bus_reset
 PORT PLB_Clk = sys_clk_s
END

BEGIN opb_v20
 PARAMETER INSTANCE = opb
 PARAMETER HW_VER = 1.10.c
 PARAMETER C_EXT_RESET_HIGH = 1
 PORT SYS_Rst = sys_bus_reset
 PORT OPB_Clk = sys_clk_s
END

BEGIN plb2opb_bridge
 PARAMETER INSTANCE = plb2opb
 PARAMETER HW_VER = 1.01.a
 PARAMETER C_DCR_INTFCE = 0
 PARAMETER C_NUM_ADDR_RNG = 1
 PARAMETER C_RNG0_BASEADDR = 0x40000000
 PARAMETER C_RNG0_HIGHADDR = 0x7fffffff
 BUS_INTERFACE SPLB = plb
 BUS_INTERFACE MOPB = opb
END

BEGIN opb_uart16550
 PARAMETER INSTANCE = RS232_Uart_1
 PARAMETER HW_VER = 1.00.d
 PARAMETER C_IS_A_16550 = 1
 PARAMETER C_BASEADDR = 0x40400000
 PARAMETER C_HIGHADDR = 0x4040ffff
 BUS_INTERFACE SOPB = opb
 PORT IP2INTC_Irpt = RS232_Uart_1_IP2INTC_Irpt
 PORT ctsN = fpga_0_RS232_Uart_1_ctsN
 PORT rtsN = fpga_0_RS232_Uart_1_rtsN
 PORT sin = fpga_0_RS232_Uart_1_sin
 PORT sout = fpga_0_RS232_Uart_1_sout
END

BEGIN opb_sysace
 PARAMETER INSTANCE = SysACE_CompactFlash
 PARAMETER HW_VER = 1.00.c
 PARAMETER C_MEM_WIDTH = 16
 PARAMETER C_BASEADDR = 0x41800000
 PARAMETER C_HIGHADDR = 0x4180ffff
 BUS_INTERFACE SOPB = opb
 PORT SysACE_IRQ = SysACE_CompactFlash_SysACE_IRQ
 PORT SysACE_CLK = fpga_0_SysACE_CompactFlash_SysACE_CLK
 PORT SysACE_MPA = fpga_0_SysACE_CompactFlash_SysACE_MPA
 PORT SysACE_MPD = fpga_0_SysACE_CompactFlash_SysACE_MPD
 PORT SysACE_CEN = fpga_0_SysACE_CompactFlash_SysACE_CEN
 PORT SysACE_OEN = fpga_0_SysACE_CompactFlash_SysACE_OEN
 PORT SysACE_WEN = fpga_0_SysACE_CompactFlash_SysACE_WEN
 PORT SysACE_MPIRQ = fpga_0_SysACE_CompactFlash_SysACE_MPIRQ
END

BEGIN plb_ethernet
 PARAMETER INSTANCE = Ethernet_MAC
 PARAMETER HW_VER = 1.01.a
 PARAMETER C_DMA_PRESENT = 1
 PARAMETER C_IPIF_FIFO_DEPTH = 32768
 PARAMETER C_PLB_CLK_PERIOD_PS = 10000
 PARAMETER C_BASEADDR = 0x80400000
 PARAMETER C_HIGHADDR = 0x8040ffff
 BUS_INTERFACE SPLB = plb
 PORT IP2INTC_Irpt = Ethernet_MAC_IP2INTC_Irpt
 PORT PHY_tx_clk = fpga_0_Ethernet_MAC_PHY_tx_clk
 PORT PHY_rx_clk = fpga_0_Ethernet_MAC_PHY_rx_clk
 PORT PHY_dv = fpga_0_Ethernet_MAC_PHY_dv
 PORT PHY_rx_data = fpga_0_Ethernet_MAC_PHY_rx_data
 PORT PHY_rx_er = fpga_0_Ethernet_MAC_PHY_rx_er
 PORT PHY_tx_en = fpga_0_Ethernet_MAC_PHY_tx_en
 PORT PHY_tx_er = fpga_0_Ethernet_MAC_PHY_tx_er
 PORT PHY_tx_data = fpga_0_Ethernet_MAC_PHY_tx_data
 PORT PHY_Mii_clk = fpga_0_Ethernet_MAC_PHY_Mii_clk
 PORT PHY_Mii_data = fpga_0_Ethernet_MAC_PHY_Mii_data
 PORT PHY_rst_n = fpga_0_Ethernet_MAC_PHY_rst_n
END

BEGIN plb_ddr2
 PARAMETER INSTANCE = DDR2_SDRAM_32Mx64
 PARAMETER HW_VER = 1.02.b
 PARAMETER C_REG_DIMM = 1
 PARAMETER C_NUM_BANKS_MEM = 1
 PARAMETER C_NUM_CLK_PAIRS = 1
 PARAMETER C_NUM_IDELAYCTRL = 4
 PARAMETER C_IDELAYCTRL_LOC =
IDELAYCTRL_X0Y5-IDELAYCTRL_X0Y4-IDELAYCTRL_X0Y3-IDELAYCTRL_X0Y2
 PARAMETER C_DDR_CAS_LAT = 3
 PARAMETER C_DDR_ENABLE_DIFF_DQS = 1
 PARAMETER C_DDR_ASYNC_SUPPORT = 1
 PARAMETER C_DDR_DWIDTH = 64
 PARAMETER C_DDR_AWIDTH = 13
 PARAMETER C_DDR_COL_AWIDTH = 10
 PARAMETER C_DDR_BANK_AWIDTH = 2
 PARAMETER C_DDR_TRAS = 90000
 PARAMETER C_DDR_TRCD = 25000
 PARAMETER C_DDR_TMRD = 25000
 PARAMETER C_DDR_TWR = 15000
 PARAMETER C_DDR_TWTR = 1
 PARAMETER C_DDR_TRC = 65000
 PARAMETER C_DDR_TRFC = 115000
 PARAMETER C_DDR_TRRD = 15000
 PARAMETER C_DDR_TREFI = 7800000
 PARAMETER C_DDR_TRP = 20000
 PARAMETER C_DDR_TFAW = 50000
 PARAMETER C_ECC_BASEADDR = 0x81400000
 PARAMETER C_ECC_HIGHADDR = 0x8140ffff
 PARAMETER C_MEM0_BASEADDR = 0x00000000
 PARAMETER C_MEM0_HIGHADDR = 0x0fffffff
 BUS_INTERFACE SPLB = plb
 PORT DDR_ODT = fpga_0_DDR2_SDRAM_32Mx64_DDR_ODT
 PORT DDR_Addr = fpga_0_DDR2_SDRAM_32Mx64_DDR_Addr
 PORT DDR_BankAddr = fpga_0_DDR2_SDRAM_32Mx64_DDR_BankAddr
 PORT DDR_CASn = fpga_0_DDR2_SDRAM_32Mx64_DDR_CASn
 PORT DDR_CKE = fpga_0_DDR2_SDRAM_32Mx64_DDR_CKE
 PORT DDR_CSn = fpga_0_DDR2_SDRAM_32Mx64_DDR_CSn
 PORT DDR_RASn = fpga_0_DDR2_SDRAM_32Mx64_DDR_RASn
 PORT DDR_WEn = fpga_0_DDR2_SDRAM_32Mx64_DDR_WEn
 PORT DDR_DM = fpga_0_DDR2_SDRAM_32Mx64_DDR_DM
 PORT DDR_DQS = fpga_0_DDR2_SDRAM_32Mx64_DDR_DQS
 PORT DDR_DQSn = fpga_0_DDR2_SDRAM_32Mx64_DDR_DQSn
 PORT DDR_DQ = fpga_0_DDR2_SDRAM_32Mx64_DDR_DQ
 PORT DDR_Clk = fpga_0_DDR2_SDRAM_32Mx64_DDR_Clk
 PORT DDR_Clkn = fpga_0_DDR2_SDRAM_32Mx64_DDR_Clkn
 PORT Device_Clk90_in = ddr2_dev_clk_90_s
 PORT Device_Clk90_in_n = ddr2_dev_clk_90_s_n
 PORT Device_Clk = clk_200mhz_s
 PORT Device_Clk_n = ddr2_dev_clk_s_n
 PORT Clk_200 = clk_200mhz_s
 PORT Cal_Clk = ddr2_cal_clk
END

BEGIN plb_bram_if_cntlr
 PARAMETER INSTANCE = plb_bram_if_cntlr_1
 PARAMETER HW_VER = 1.00.b
 PARAMETER c_plb_clk_period_ps = 10000
 PARAMETER c_baseaddr = 0xfffe0000
 PARAMETER c_highaddr = 0xffffffff
 BUS_INTERFACE SPLB = plb
 BUS_INTERFACE PORTA = plb_bram_if_cntlr_1_port
END

BEGIN bram_block
 PARAMETER INSTANCE = plb_bram_if_cntlr_1_bram
 PARAMETER HW_VER = 1.00.a
 BUS_INTERFACE PORTA = plb_bram_if_cntlr_1_port
END

BEGIN opb_intc
 PARAMETER INSTANCE = opb_intc_0
 PARAMETER HW_VER = 1.00.c
 PARAMETER C_BASEADDR = 0x41200000
 PARAMETER C_HIGHADDR = 0x4120ffff
 BUS_INTERFACE SOPB = opb
 PORT Irq = EICC405EXTINPUTIRQ
 PORT Intr = RS232_Uart_1_IP2INTC_Irpt & SysACE_CompactFlash_SysACE_IRQ &
Ethernet_MAC_IP2INTC_Irpt
END

BEGIN util_reduced_logic
 PARAMETER INSTANCE = ORGate_1
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_OPERATION = or
 PARAMETER C_SIZE = 2
 PORT Op1 = sys_rst_s & 0b0
 PORT Res = fpga_0_ORGate_1_Res
END

BEGIN util_vector_logic
 PARAMETER INSTANCE = ddr2_devclk_inv
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_SIZE = 1
 PARAMETER C_OPERATION = not
 PORT Op1 = clk_200mhz_s
 PORT Res = ddr2_dev_clk_s_n
END

BEGIN util_vector_logic
 PARAMETER INSTANCE = ddr2_devclk90_inv
 PARAMETER HW_VER = 1.00.a
 PARAMETER C_SIZE = 1
 PARAMETER C_OPERATION = not
 PORT Op1 = ddr2_dev_clk_90_s
 PORT Res = ddr2_dev_clk_90_s_n
END

BEGIN dcm_module
 PARAMETER INSTANCE = dcm_0
 PARAMETER HW_VER = 1.00.c
 PARAMETER C_CLK0_BUF = TRUE
 PARAMETER C_CLK2X_BUF = TRUE
 PARAMETER C_CLKDV_BUF = TRUE
 PARAMETER C_CLKDV_DIVIDE = 2.000000
 PARAMETER C_CLKFX_BUF = TRUE
 PARAMETER C_CLKFX_DIVIDE = 1
 PARAMETER C_CLKFX_MULTIPLY = 3
 PARAMETER C_CLKIN_PERIOD = 10.000000
 PARAMETER C_CLK_FEEDBACK = 1X
 PARAMETER C_DFS_FREQUENCY_MODE = HIGH
 PARAMETER C_DLL_FREQUENCY_MODE = LOW
 PARAMETER C_EXT_RESET_HIGH = 1
 PORT CLKIN = dcm_clk_s
 PORT CLK0 = sys_clk_s
 PORT CLKDV = ddr2_cal_clk
 PORT CLKFX = proc_clk_s
 PORT CLKFB = sys_clk_s
 PORT CLK2X = dcm_0CLK2X
 PORT RST = net_gnd
 PORT LOCKED = dcm_0_lock
END

BEGIN dcm_module
 PARAMETER INSTANCE = dcm_1
 PARAMETER HW_VER = 1.00.c
 PARAMETER C_CLK0_BUF = TRUE
 PARAMETER C_CLK90_BUF = TRUE
 PARAMETER C_CLKIN_PERIOD = 5.000000
 PARAMETER C_CLK_FEEDBACK = 1X
 PARAMETER C_DLL_FREQUENCY_MODE = HIGH
 PARAMETER C_EXT_RESET_HIGH = 0
 PORT CLKIN = dcm_0CLK2X
 PORT CLK0 = clk_200mhz_s
 PORT CLK90 = ddr2_dev_clk_90_s
 PORT CLKFB = clk_200mhz_s
 PORT RST = dcm_0_lock
 PORT LOCKED = dcm_1_lock
END
