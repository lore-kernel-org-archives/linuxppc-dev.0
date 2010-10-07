Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D14A71007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 17:01:19 +1100 (EST)
Subject: Re: [PATCH][v3] mpc8308_p1m: support for MPC8308 P1M board
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1283990116-29441-1-git-send-email-yanok@emcraft.com>
Date: Thu, 7 Oct 2010 01:00:56 -0500
Message-Id: <4ABD3C18-BA1E-484F-B552-8D1A0E2D6990@kernel.crashing.org>
References: <20100908170203.7cfa76a1@schlenkerla.am.freescale.net>
	<1283990116-29441-1-git-send-email-yanok@emcraft.com>
To: Ilya Yanok <yanok@emcraft.com>
Cc: scottwood@freescale.com, vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org,
	wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 8, 2010, at 6:55 PM, Ilya Yanok wrote:

> This patch adds support for MPC8308 P1M board.
> Supported devices:
> DUART
> Dual Ethernet
> NOR flash
> Both I2C controllers
> USB in peripheral mode
> PCI Express
>=20
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>=20
> Changed 'compatible' entry for 'cpld' node to "denx,mpc8308_p1m-cpld"
>=20
> arch/powerpc/boot/dts/mpc8308_p1m.dts     |  332 =
+++++++++++++++++++++++++++++
> arch/powerpc/platforms/83xx/Kconfig       |    4 +-
> arch/powerpc/platforms/83xx/mpc830x_rdb.c |    3 +-
> 3 files changed, 336 insertions(+), 3 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc8308_p1m.dts

applied to next

- k=
