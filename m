Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A8A81DDEF2
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 12:10:21 +1000 (EST)
Date: Sat, 21 Jul 2007 19:10:19 -0700 (PDT)
Message-Id: <20070721.191019.28395100.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] constify of_platform_driver name
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070722002303.df29f666.sfr@canb.auug.org.au>
References: <20070722002303.df29f666.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 22 Jul 2007 00:23:03 +1000

> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/pcmcia/m8xx_pcmcia.c |    2 +-
>  include/linux/of_platform.h  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Built for PowerPC allmodconfig and ppc64_defconfig, and for Sparc and
> Sparc64 defconfig.

Acked-by: David S. Miller <davem@davemloft.net>
