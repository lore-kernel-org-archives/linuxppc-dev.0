Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4CF6BB6EF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 02:55:50 +1100 (EST)
Subject: Re: [PATCH 1/2 v2] powerpc/dts: Add dts for p1025rdb board
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328003481-31821-1-git-send-email-B32736@freescale.com>
Date: Tue, 31 Jan 2012 09:55:54 -0600
Message-Id: <DDC3CACD-1B1C-4826-A839-65D42395ACEA@kernel.crashing.org>
References: <1328003481-31821-1-git-send-email-B32736@freescale.com>
To: Zhicheng Fan <B32736@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 31, 2012, at 3:51 AM, Zhicheng Fan wrote:

> From: Zhicheng Fan <b32736@freeescale.com>
>=20
> P1025RDB Overview
> ------------------
> 1Gbyte DDR3 SDRAM
> 32 Mbyte NAND flash
> 16Mbyte NOR flash
> 16 Mbyte SPI flash
> SD connector to interface with the SD memory card
> Real-time clock on I2C bus
>=20
> PCIe:
> - x1 PCIe slot
> - x1 mini-PCIe slot
>=20
> 10/100/1000 BaseT Ethernet ports:
> - eTSEC1, RGMII: one 10/100/1000 port using AtherosTM AR8021
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
> Signed-off-by: Zhicheng Fan <b32736@freeescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p1025si-post.dtsi |  228 =
+++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi  |   70 +++++++
> arch/powerpc/boot/dts/p1025rdb.dts          |  137 +++++++++++++
> arch/powerpc/boot/dts/p1025rdb.dtsi         |  286 =
+++++++++++++++++++++++++++
> arch/powerpc/boot/dts/p1025rdb_36b.dts      |   88 ++++++++
> 5 files changed, 809 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi
> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dts
> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dtsi
> create mode 100644 arch/powerpc/boot/dts/p1025rdb_36b.dts

For the p1024 & p1025 I do NOT want to add new dts/fsl/p1025si*.dtsi =
files.  We should use the p1020 and p1021 as they are identical.

- k=
