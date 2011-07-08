Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B872B1047F0
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 14:12:43 +1000 (EST)
Received: from mail51-va3 (localhost.localdomain [127.0.0.1])	by
	mail51-va3-R.bigfish.com (Postfix) with ESMTP id C22B91B20467	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 04:12:40 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.239])	by
	mail51-va3.bigfish.com (Postfix) with ESMTP id 9133D114804E	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 04:12:40 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: Add p2040 RDB board support
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1309247554-13580-1-git-send-email-Mingkai.hu@freescale.com>
Date: Thu, 7 Jul 2011 23:12:35 -0500
Message-ID: <9E720FB6-1A60-47AF-85FF-C10299796036@freescale.com>
References: <1309247554-13580-1-git-send-email-Mingkai.hu@freescale.com>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 28, 2011, at 2:52 AM, Mingkai Hu wrote:

> P2040RDB Specification:
> -----------------------
> 2Gbyte unbuffered DDR3 SDRAM SO-DIMM(64bit bus)
> 128 Mbyte NOR flash single-chip memory
> 256 Kbit M24256 I2C EEPROM
> 16 Mbyte SPI memory
> SD connector to interface with the SD memory card
> dTSEC1: connected to the Vitesse SGMII PHY (VSC8221)
> dTSEC2: connected to the Vitesse SGMII PHY (VSC8221)
> dTSEC3: connected to the Vitesse SGMII PHY (VSC8221)
> dTSEC4: connected to the Vitesse RGMII PHY (VSC8641)
> dTSEC5: connected to the Vitesse RGMII PHY (VSC8641)
> I2C1: Real time clock, Temperature sensor
> I2C2: Vcore Regulator, 256Kbit I2C Bus EEPROM
> SATA: Lanes C and Land D of Bank2 are connected to two SATA connectors
> UART: supports two UARTs up to 115200 bps for console
> USB 2.0: connected via a internal UTMI PHY to two TYPE-A interfaces
> PCIe:
> - Lanes E, F, G and H of Bank1 are connected to one x4 PCIe SLOT1
> - Lanes C and Land D of Bank2 are connected to one x4 PCIe SLOT2
>=20
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
> Based on =
http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>=20
> arch/powerpc/boot/dts/p2040rdb.dts           |  166 +++++++
> arch/powerpc/boot/dts/p2040si.dtsi           |  623 =
++++++++++++++++++++++++++
> arch/powerpc/configs/corenet32_smp_defconfig |    1 +
> arch/powerpc/platforms/85xx/Kconfig          |   12 +
> arch/powerpc/platforms/85xx/Makefile         |    1 +
> arch/powerpc/platforms/85xx/p2040_rdb.c      |   88 ++++
> 6 files changed, 891 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p2040rdb.dts
> create mode 100644 arch/powerpc/boot/dts/p2040si.dtsi
> create mode 100644 arch/powerpc/platforms/85xx/p2040_rdb.c

applied to next

- k
