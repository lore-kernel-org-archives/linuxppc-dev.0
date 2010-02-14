Return-Path: <monstr@monstr.eu>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 6932CB7CC2
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2010 01:08:43 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so266993fgg.3
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 06:08:41 -0800 (PST)
Message-ID: <4B780350.2080400@monstr.eu>
Date: Sun, 14 Feb 2010 15:06:08 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/9] Random OF cleanups and merges
References: <20100213154838.4767.83881.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, davem@davemloft.net
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Here's another batch of cleanup patches from my test-devicetree branch.
> A number of cleanups, corrections and minor merges of common code.
> Also a patch from Jeremy to make the flat tree work on architectures
> without LMB (arm).
> 
> Once I've collected acks on these, I'll move them over to my
> next-devicetree branch on git://git.secretlab.ca/git/linux-2.6

All changes look ok. Please add them to linux-next which I am testing. I 
don't expect any problem with it but anywya if any problems arise, I 
will let you know.

I don't want to reply every email as Ben that's why one my big ACK
for that 9 patches.

Acked-by: Michal Simek <monstr@monstr.eu>

> 
> Cheers,
> g.
> 
> ---
> 
> Grant Likely (6):
>       of: remove undefined request_OF_resource & release_OF_resource
>       of/sparc: Remove sparc-local declaration of allnodes and devtree_lock
>       of: move definition of of_chosen into common code.
>       of: remove unused extern reference to devtree_lock
>       of: put default string compare and #a/s-cell values into common header
>       of: Remove old and misplaced function declarations
> 
> Jeremy Kerr (3):
>       of/flattree: Don't assume HAVE_LMB
>       of: protect linux/of.h with CONFIG_OF
>       proc_devtree: fix THIS_MODULE without module.h
> 
> 
>  arch/microblaze/include/asm/prom.h |   15 ---------------
>  arch/microblaze/kernel/prom.c      |    8 +++++---
>  arch/powerpc/include/asm/prom.h    |   14 --------------
>  arch/powerpc/kernel/prom.c         |   10 +++++-----
>  arch/sparc/kernel/prom.h           |    3 ---
>  drivers/of/base.c                  |    1 +
>  drivers/of/fdt.c                   |    9 ++++++---
>  fs/proc/proc_devtree.c             |    1 +
>  include/linux/of.h                 |   27 +++++++++++++++++++++++++++
>  include/linux/of_fdt.h             |   11 +----------
>  10 files changed, 46 insertions(+), 53 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
