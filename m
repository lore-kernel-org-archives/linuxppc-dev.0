Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9EB6DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:29:52 +1100 (EST)
Subject: Re: Please pull from 'for-2.6.28' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 10:29:45 +1100
Message-Id: <1224545385.7654.192.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-20 at 13:04 -0500, Kumar Gala wrote:
> Please pull from 'for-2.6.28' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.28

It would be nice if you didn't create new branches all the time so I
don't have to change my git remotes config :-)

Anyway, I'll add that one for now.

Cheers,
Ben.

> to receive the following updates:
> 
>  Documentation/powerpc/booting-without-of.txt     |    2 ++
>  Documentation/powerpc/dts-bindings/fsl/board.txt |    4 ++--
>  arch/powerpc/Kconfig                             |    3 ---
>  arch/powerpc/boot/dts/mpc832x_mds.dts            |    2 +-
>  arch/powerpc/boot/dts/mpc834x_mds.dts            |    2 +-
>  arch/powerpc/boot/dts/mpc836x_mds.dts            |    2 +-
>  arch/powerpc/boot/dts/mpc8536ds.dts              |   12 ++++++------
>  arch/powerpc/boot/dts/mpc8568mds.dts             |    2 +-
>  arch/powerpc/include/asm/page.h                  |    5 ++++-
>  arch/powerpc/kernel/prom_init_check.sh           |    2 +-
>  drivers/i2c/busses/i2c-cpm.c                     |    1 -
>  drivers/of/of_spi.c                              |    2 ++
>  12 files changed, 21 insertions(+), 18 deletions(-)
> 
> Anton Vorontsov (1):
>       powerpc: remove device_type = "board-control"
> 
> Ed Swarthout (1):
>       powerpc/85xx: Fix mpc8536ds dma interrupt numbers
> 
> Jason Jin (1):
>       powerpc/85xx: Enable enhanced functions for 8536 TSEC
> 
> Kumar Gala (2):
>       powerpc: Fix build issue with CONFIG_RELOCATABLE=y
>       powerpc: Remove Kconfig support for PPC_MERGE
> 
> Wolfgang Ocker (1):
>       OF: SPI: specify chip select active high
> 
> Wolfram Sang (1):
>       i2c-cpm: Suppress autoprobing for devices
