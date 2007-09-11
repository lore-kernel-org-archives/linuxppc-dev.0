Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 54210DDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:19:07 +1000 (EST)
Date: Tue, 11 Sep 2007 12:20:00 -0500
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575
	on FSL boards
Message-ID: <20070911172000.GC10743@lixom.net>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 17, 2007 at 12:03:48AM -0500, Kumar Gala wrote:
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/boot/dts/mpc8544ds.dts        |   88 ++++------
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  114 +++----------
>  arch/powerpc/platforms/85xx/Kconfig        |    1 +
>  arch/powerpc/platforms/85xx/mpc8544_ds.c   |  214 ++----------------------
>  arch/powerpc/platforms/86xx/Kconfig        |    1 +
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  224 ++-----------------------
>  arch/powerpc/platforms/Kconfig             |    8 +
>  arch/powerpc/platforms/Makefile            |    3 +
>  arch/powerpc/platforms/fsl_uli1575.c       |  255 ++++++++++++++++++++++++++++
>  9 files changed, 363 insertions(+), 545 deletions(-)
>  create mode 100644 arch/powerpc/platforms/fsl_uli1575.c
> 

Since when do we add code directly under powerpc/platforms? Isn't that
what we have sysdev for?

I know this is already picked up, but I just noticed it when looking at
Kumar's 8572 patch. :-(


-Olof
