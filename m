Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B99FDDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:45:58 +1100 (EST)
Date: Fri, 25 Jan 2008 15:20:58 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/5] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
In-Reply-To: <20080124154007.GD23246@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0801251520430.20972@blarg.am.freescale.net>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154007.GD23246@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Anton Vorontsov wrote:

> Also:
> - rename "fsl_spi" to "fsl,spi";
> - add and use cell-index property, if found;
> - split probing code out of fsl_spi_init, thus we can call
>   it for legacy device_type probing and new "compatible" probing.
>
> Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    8 +-
>  arch/powerpc/boot/dts/mpc8313erdb.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc832x_mds.dts        |    8 +-
>  arch/powerpc/boot/dts/mpc832x_rdb.dts        |    8 +-
>  arch/powerpc/boot/dts/mpc8349emitx.dts       |    4 +-
>  arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4 +-
>  arch/powerpc/boot/dts/mpc834x_mds.dts        |    4 +-
>  arch/powerpc/boot/dts/mpc836x_mds.dts        |    8 +-
>  arch/powerpc/boot/dts/mpc836x_rdk.dts        |    6 +-
>  arch/powerpc/boot/dts/mpc8568mds.dts         |    8 +-
>  arch/powerpc/sysdev/fsl_soc.c                |   94 ++++++++++++++++----------
>  11 files changed, 88 insertions(+), 68 deletions(-)
>

applied.  (sans _rdk)

- k
