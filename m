Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE163B70A7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:23:14 +1000 (EST)
Subject: Re: [PATCH] [v2] powerpc: introduce basic support for the Freescale
	P1022DS reference board
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1278109503-7604-1-git-send-email-timur@freescale.com>
Date: Wed, 4 Aug 2010 14:23:05 -0500
Message-Id: <8E3549C3-CBFC-4069-9FA1-8A892FF40E8F@kernel.crashing.org>
References: <1278109503-7604-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 2, 2010, at 5:25 PM, Timur Tabi wrote:

> Introduce basic support for the Freescale P1022DS reference board, =
based on the
> Freescale BSP for this board.  This patch excludes the DIU, SSI, and =
MMC/SD
> drivers.  Only a 36-bit DTS is provided.
>=20
> Update mpc86xx_smp_defconfig and mpc85xx_defconfig to support the =
P1022DS.
> This means enabling 64-bit physical address support, increasing the =
maximum
> zone order to 12 (to allow the DIU driver to allocate large chunks), =
and
> clean up the audio options to disable the deprecated OSS support.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This patch is for 2.6.36.
>=20
> arch/powerpc/boot/dts/p1022ds.dts          |  633 =
++++++++++++++++++++++++++++
> arch/powerpc/configs/mpc85xx_defconfig     |   34 +-
> arch/powerpc/configs/mpc85xx_smp_defconfig |   34 +-
> arch/powerpc/platforms/85xx/Kconfig        |    8 +
> arch/powerpc/platforms/85xx/Makefile       |    1 +
> arch/powerpc/platforms/85xx/p1022_ds.c     |  148 +++++++
> 6 files changed, 814 insertions(+), 44 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1022ds.dts
> create mode 100644 arch/powerpc/platforms/85xx/p1022_ds.c

applied to next

- k=
