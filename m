Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C045BB70E4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 03:04:26 +1100 (EST)
Subject: Re: [PATCH 2/2 v5] powerpc/dts: Add dts for p1020rdb-pc board
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328856496-2873-2-git-send-email-B32736@freescale.com>
Date: Fri, 16 Mar 2012 11:04:20 -0500
Message-Id: <DBC2BB4B-A6DD-4B0A-88EB-FC3CC8CC46E2@kernel.crashing.org>
References: <1328856496-2873-1-git-send-email-B32736@freescale.com>
 <1328856496-2873-2-git-send-email-B32736@freescale.com>
To: Zhicheng Fan <B32736@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 10, 2012, at 12:48 AM, Zhicheng Fan wrote:

> From: Zhicheng Fan <b32736@freescale.com>
>=20
> P1020RDB-PC Overview
> ------------------
> 1Gbyte DDR3 SDRAM
> 32 Mbyte NAND flash
> 10 16Mbyte NOR flash
> 16 Mbyte SPI flash
> SD connector to interface with the SD memory card
> Real-time clock on I2C bus
>=20
> PCIe:
> - x1 PCIe slot
> - x1 mini-PCIe slot
>=20
> 10/100/1000 BaseT Ethernet ports:
> - eTSEC1, RGMII: one 10/100/1000 port using VitesseTM VSC7385 L2 =
switch
> - eTSEC2, SGMII: one 10/100/1000 port using VitesseTM VSC8221
> - eTSEC3, RGMII: one 10/100/1000 port using AtherosTM AR8021
>=20
> USB 2.0 port:
> - Two USB2.0 Type A receptacles
> - One USB2.0 signal to Mini PCIe slot
>=20
> Dual RJ45 UART ports:
> - DUART interface: supports two UARTs up to 115200 bps for console =
display
>=20
> Signed-off-by: Zhicheng Fan <b32736@freescale.com>
> ---
> arch/powerpc/boot/dts/p1020rdb-pc.dtsi           |  247 =
++++++++++++++++++++++
> arch/powerpc/boot/dts/p1020rdb-pc_32b.dts        |   90 ++++++++
> arch/powerpc/boot/dts/p1020rdb-pc_36b.dts        |   90 ++++++++
> arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts |   64 ++++++
> arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts |  142 +++++++++++++
> 5 files changed, 633 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc.dtsi
> create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_32b.dts
> create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
> create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts
> create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts

applied

- k=
