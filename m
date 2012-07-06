Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH][v3] powerpc/85xx:Add BSC9131 RDB Support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332392055-30112-1-git-send-email-prabhakar@freescale.com>
Date: Fri, 6 Jul 2012 13:09:35 -0500
Message-Id: <A44455E7-44B7-425F-9622-CBB4DE39DEBA@kernel.crashing.org>
References: <1332392055-30112-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>,
 devicetree-discuss@lists.ozlabs.org,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Rajan Srivastava <rajan.srivastava@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Akhil Goyal <Akhil.Goyal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 21, 2012, at 11:54 PM, Prabhakar Kushwaha wrote:

> BSC9131RDB is a Freescale reference design board for BSC9131 SoC.The =
BSC9131
> is integrated SoC that targets Femto base station market. It combines =
Power
> Architecture e500v2 and DSP StarCore SC3850 core technologies with =
MAPLE-B2F
> baseband acceleration processing elements.
>=20
> The BSC9131 SoC includes the following function and features:
>    . Power Architecture subsystem including a e500 processor with =
256-Kbyte
>    shared L2 cache
>    . StarCore SC3850 DSP subsystem with a 512-Kbyte private L2 cache
>    . The Multi Accelerator Platform Engine for Femto BaseStation =
Baseband
>      Processing (MAPLE-B2F)
>    . A multi-standard baseband algorithm accelerator for Channel
>      Decoding/Encoding, Fourier Transforms, UMTS chip rate processing, =
LTE
>      UP/DL Channel processing, and CRC algorithms
>    . Consists of accelerators for Convolution, Filtering, Turbo =
Encoding,
>      Turbo Decoding, Viterbi decoding, Chiprate processing, and Matrix
>      Inversion operations
>    . DDR3/3L memory interface with 32-bit data width without ECC and =
16-bit
>      with ECC, up to 400-MHz clock/800 MHz data rate
>    . Dedicated security engine featuring trusted boot
>    . DMA controller
>    . OCNDMA with four bidirectional channels
>    . Interfaces
>    . Two triple-speed Gigabit Ethernet controllers featuring network
>      acceleration including IEEE 1588. v2 hardware support and
>      virtualization (eTSEC)
>    . eTSEC 1 supports RGMII/RMII
>    . eTSEC 2 supports RGMII
>    . High-speed USB 2.0 host and device controller with ULPI interface
>    . Enhanced secure digital (SD/MMC) host controller (eSDHC)
>    . Antenna interface controller (AIC), supporting three industry =
standard
>      JESD207/three custom ADI RF interfaces (two dual port and one =
single
>      port) and three MAXIM's MaxPHY serial interfaces
>    . ADI lanes support both full duplex FDD support and half duplex =
TDD
>      support
>    . Universal Subscriber Identity Module (USIM) interface that =
facilitates
>      communication to SIM cards or Eurochip pre-paid phone cards
>    . TDM with one TDM port
>    . Two DUART, four eSPI, and two I2C controllers
>    . Integrated Flash memory controller (IFC)
>    . TDM with 256 channels
>    . GPIO
>    . Sixteen 32-bit timers
>=20
> The DSP portion of the SoC consists of DSP core (SC3850) and various
> accelerators pertaining to DSP operations.
>=20
> BSC9131RDB Overview
> ----------------------
>    BSC9131 SoC
>    1Gbyte DDR3 (on board DDR)
>    128Mbyte 2K page size NAND Flash
>    256 Kbit M24256 I2C EEPROM
>    128 Mbit SPI Flash memory
>    USB-ULPI
>    eTSEC1: Connected to RGMII PHY
>    eTSEC2: Connected to RGMII PHY
>    DUART interface: supports one UARTs up to 115200 bps for console =
display
>=20
> Linux runs on e500v2 core and access some DSP peripherals like AIC
>=20
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Akhil Goyal <Akhil.Goyal@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Rajan Srivastava <rajan.srivastava@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---

applied to next.

(Made some minor changes to match upstream board ports like p1010, also =
sorted Makefile & Kconfig by Alphabet)

- k=
