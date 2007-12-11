Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47511DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 01:41:09 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to for-2.6.25 and master branches of powerpc.git 
In-Reply-To: Your message of "Tue, 11 Dec 2007 16:29:29 +1100."
	<18270.8249.393061.840667@cargo.ozlabs.ibm.com>
References: <18270.8249.393061.840667@cargo.ozlabs.ibm.com> 
Date: Tue, 11 Dec 2007 08:41:03 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J26IB-0004sq-Pt@jdl.com>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Paul Mackerras mumbled:
> 
> Jon Loeliger (2):
>       [POWERPC] Clean out asm/of_{platform, device}.h
>       [POWERPC] Clean out asm/of_{platform, device}.h from sysdev/

Excellent, thanks!

That leaves just this following patch from my janitor series.

    http://patchwork.ozlabs.org/linuxppc/patch?id=14712

I suspect Arnd might need to pick it up or ACK it now?

Thanks,
jdl




From: Jon Loeliger <jdl@freescale.com>
Date: Mon, 12 Nov 2007 14:23:16 -0600
Subject: [PATCH] cell: Convert #include of asm/of_{platform, device}.h into linux/of_{platform, device}.h.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au> Built a ppc64_defconfig
---

This version picks up the celleb/ files too.
Stephen, notice that you tacitly ACK'ed this pickup too... :-)


 arch/powerpc/platforms/cell/cbe_cpufreq.c     |    3 ++-
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c |    3 ++-
 arch/powerpc/platforms/cell/cbe_regs.c        |    4 ++--
 arch/powerpc/platforms/cell/iommu.c           |    2 +-
 arch/powerpc/platforms/cell/setup.c           |    2 +-
 arch/powerpc/platforms/celleb/iommu.c         |    3 +--
 arch/powerpc/platforms/celleb/setup.c         |    2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)
