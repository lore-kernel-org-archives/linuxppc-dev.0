Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2558E2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 22:43:17 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add dts files for P1021RDB-PC board
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
Date: Wed, 11 Jul 2012 07:43:11 -0500
Message-Id: <167969CF-0EE8-48EB-8828-BB897B831A4F@kernel.crashing.org>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
To: Xu Jiucheng <Jiucheng.Xu@freescale.com>
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 3:39 AM, Xu Jiucheng wrote:

> P1021RDB-PC Overview
> -----------------
> 1Gbyte DDR3 (on board DDR)
> 16Mbyte NOR flash
> 32Mbyte eSLC NAND Flash
> 256 Kbit M24256 I2C EEPROM
> 128 Mbit SPI Flash memory
> Real-time clock on I2C bus
> SD/MMC connector to interface with the SD memory card
> PCIex
> 	- x1 PCIe slot or x1 PCIe to dual SATA controller
> 	- x1 mini-PCIe slot
> USB 2.0
> 	- ULPI PHY interface: SMSC USB3300 USB PHY and Genesys Logic=92s =
GL850A
> 	- Two USB2.0 Type A receptacles
> 	- One USB2.0 signal to Mini PCIe slot
> eTSEC1: Connected to RGMII PHY VSC7385
> eTSEC2: Connected to SGMII PHY VSC8221
> eTSEC3: Connected to SGMII PHY AR8021
> DUART interface: supports two UARTs up to 115200 bps for console =
display
>=20
> Signed-off-by: Xu Jiucheng <Jiucheng.Xu@freescale.com>
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/boot/dts/p1021rdb-pc.dtsi    |  236 =
+++++++++++++++++++++++++++++
> arch/powerpc/boot/dts/p1021rdb-pc_32b.dts |   96 ++++++++++++
> arch/powerpc/boot/dts/p1021rdb-pc_36b.dts |   96 ++++++++++++
> arch/powerpc/boot/dts/p1021rdb.dts        |   96 ------------
> arch/powerpc/boot/dts/p1021rdb.dtsi       |  236 =
-----------------------------
> arch/powerpc/boot/dts/p1021rdb_36b.dts    |   96 ------------
> 6 files changed, 428 insertions(+), 428 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc_32b.dts
> create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc_36b.dts
> delete mode 100644 arch/powerpc/boot/dts/p1021rdb.dts
> delete mode 100644 arch/powerpc/boot/dts/p1021rdb.dtsi
> delete mode 100644 arch/powerpc/boot/dts/p1021rdb_36b.dts

applied to next.  Rewrote commit message to just say we are renaming the =
device trees.

- k=
