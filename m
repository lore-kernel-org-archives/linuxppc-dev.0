Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0E7D7DDF9D
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 12:10:29 +1000 (EST)
Date: Sat, 21 Jul 2007 19:10:27 -0700 (PDT)
Message-Id: <20070721.191027.32096386.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] constify of_platform_driver match_table
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070722002701.77622474.sfr@canb.auug.org.au>
References: <20070722002701.77622474.sfr@canb.auug.org.au>
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
Date: Sun, 22 Jul 2007 00:27:01 +1000

> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/of_platform.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Built for PowerPC allmodconfig and ppc64_defconfig and Sparc and Sparc64
> defconfig.

Acked-by: David S. Miller <davem@davemloft.net>
