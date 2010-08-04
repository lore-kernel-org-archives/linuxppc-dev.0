Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 430A8100983
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:18:29 +1000 (EST)
Subject: Re: [PATCH 2/2] mpc8308rdb: support for MPC8308RDB board from
	Freescale
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1278619839-23998-3-git-send-email-yanok@emcraft.com>
Date: Wed, 4 Aug 2010 14:18:17 -0500
Message-Id: <81B61C8C-A5B2-4A77-92E2-B0EE75BA709E@kernel.crashing.org>
References: <1278619839-23998-1-git-send-email-yanok@emcraft.com>
	<1278619839-23998-3-git-send-email-yanok@emcraft.com>
To: Ilya Yanok <yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2010, at 3:10 PM, Ilya Yanok wrote:

> This patch adds support for MPC8308RDB development board from
> Freescale.
> Supported devices:
> DUART
> Dual Ethernet
> NOR and NAND flashes
> I2C
> USB in peripheral mode
>=20
> PCIE support is broken by the commit 3da34aa ("powerpc/fsl: Support
> unique MSI addresses per PCIe Root Complex"). Works after revert.
>=20
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> arch/powerpc/boot/dts/mpc8308rdb.dts      |  303 =
+++++++++++++++++++++++++++++
> arch/powerpc/platforms/83xx/Kconfig       |    8 +
> arch/powerpc/platforms/83xx/Makefile      |    1 +
> arch/powerpc/platforms/83xx/mpc830x_rdb.c |   94 +++++++++
> 4 files changed, 406 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc8308rdb.dts
> create mode 100644 arch/powerpc/platforms/83xx/mpc830x_rdb.c

applied to next

- k=
