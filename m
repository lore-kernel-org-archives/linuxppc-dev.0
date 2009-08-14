Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E353DB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 06:21:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D83CDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 06:21:13 +1000 (EST)
Message-Id: <A1CBED2C-9CC3-4796-A8D8-12FC5C926CE8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
In-Reply-To: <1249659316-22927-1-git-send-email-poonam.aggrwal@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [v3][PATCH][powerpc/85xx] P2020RDB Platform Support Added
Date: Fri, 14 Aug 2009 15:21:08 -0500
References: <1249659316-22927-1-git-send-email-poonam.aggrwal@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 7, 2009, at 10:35 AM, Poonam Aggrwal wrote:

> Adds P2020RDB basic support in linux.
> Overview of P2020RDB platform
> 	- DDR
> 	  DDR2 1G
> 	- NOR Flash
> 	  16MByte
> 	- NAND Flash
> 	  32MByte
> 	- 3 Ethernet interfaces
> 	  1) etSEC1
> 		- RGMII
> 		- connected to a 5 port Vitesse Switch(VSC7385)
> 		- Switch is memory mapped through eLBC interface(CS#2)
> 		- IRQ1
> 	  2) etSEC2
> 		- SGMII
> 		- connected to VSC8221
> 		- IRQ2
> 	  3) etSEC3
> 		- RGMII
> 		- connected to VSC8641
> 		- IRQ3
> 	- 2 1X PCIe interfaces
> 	- SD/MMC ,USB
> 	- SPI EEPROM
> 	- Serial I2C EEPROM
>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
> based on http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> Incorporated more feedback from Felix
> arch/powerpc/boot/dts/p2020rdb.dts        |  586 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/configs/mpc85xx_defconfig    |    1 +
> arch/powerpc/platforms/85xx/Kconfig       |    9 +
> arch/powerpc/platforms/85xx/Makefile      |    3 +-
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  141 +++++++
> 5 files changed, 739 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p2020rdb.dts
> create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_rdb.c

applied to next

- k
