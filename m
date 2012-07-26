Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0690E2C011B
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 04:54:44 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: introduce support for the Freescale / iVeia
 P1022RDK
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343085149-29048-1-git-send-email-timur@freescale.com>
Date: Thu, 26 Jul 2012 13:54:43 -0500
Message-Id: <66238D05-3FB3-4F88-9F1D-F981604FCB91@kernel.crashing.org>
References: <1343085149-29048-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2012, at 6:12 PM, Timur Tabi wrote:

> The Freescale / iVeia P1022RDK reference board is a small-factor board
> with a Freescale P1022 SOC.  It includes:
>=20
> 1) 512 MB 64-bit DDR3-800 (max) memory
> 2) 8MB SPI serial flash memory for boot loader
> 3) Bootable 4-bit SD/MMC port
> 4) Two 10/100/1000 Ethernet connectors
> 5) One SATA port
> 6) Two USB ports
> 7) One PCIe x4 slot
> 8) DVI video connector
> 9) Audio input and output jacks, powered by a Wolfson WM8960 codec.
>=20
> Unlike the P1022DS, the P1022RDK does not have any localbus devices,
> presumably because of the localbus / DIU multiplexing restriction of
> the P1022 SOC.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022rdk.dts         |  188 =
+++++++++++++++++++++++++++
> arch/powerpc/configs/mpc85xx_defconfig     |    1 +
> arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
> arch/powerpc/platforms/85xx/Kconfig        |    7 +
> arch/powerpc/platforms/85xx/Makefile       |    1 +
> arch/powerpc/platforms/85xx/p1022_rdk.c    |  195 =
++++++++++++++++++++++++++++
> 6 files changed, 393 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1022rdk.dts
> create mode 100644 arch/powerpc/platforms/85xx/p1022_rdk.c

applied to next

- k=
