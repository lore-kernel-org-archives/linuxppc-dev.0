Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8192BB6EF7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 07:56:24 +1000 (EST)
Subject: Re: [linuxppc-release] [PATCH] powerpc: introduce basic support for
	the Freescale P1022DS reference board
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1277847274-24648-1-git-send-email-timur@freescale.com>
Date: Tue, 29 Jun 2010 16:56:17 -0500
Message-Id: <22ED4111-892C-4715-BF70-C1E62F838DDA@kernel.crashing.org>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
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


On Jun 29, 2010, at 4:34 PM, Timur Tabi wrote:

> Introduce basic support for the Freescale P1022DS reference board, =
based on the
> Freescale BSP for this board.
>=20
> Details: No DIU video or SSI audio support, no MMC/SD card support, =
36-bit and
> SWIOTLB support enabled, 36-bit DTS only, and CONFIG_NO_HZ disabled =
because it
> causes performance problems on this kernel.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This patch is for 2.6.36.
>=20
> arch/powerpc/boot/dts/p1022ds.dts            |  676 +++++++++++
> arch/powerpc/configs/85xx/p1022_ds_defconfig | 1620 =
++++++++++++++++++++++++++
> arch/powerpc/platforms/85xx/Kconfig          |    9 +
> arch/powerpc/platforms/85xx/Makefile         |    1 +
> arch/powerpc/platforms/85xx/p1022_ds.c       |  148 +++
> 5 files changed, 2454 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1022ds.dts
> create mode 100644 arch/powerpc/configs/85xx/p1022_ds_defconfig
> create mode 100644 arch/powerpc/platforms/85xx/p1022_ds.c

Drop the defconfig and update mpc85xx_{smp_}defconfig to build p1022.

- k
