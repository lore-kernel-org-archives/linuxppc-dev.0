Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGL73FVzF0ps
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:54 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-11-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [10/21] powerpc: Add missing prototype for slb_miss_bad_addr
Message-Id: <401RGK6Fs4z9sVj@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:25 UTC, Mathieu Malaterre wrote:
> In commit f0f558b131db ("powerpc/mm: Preserve CFAR value on SLB miss caused
> by access to bogus address"), the function slb_miss_bad_addr was added
> without a prototype. This commit adds it.
> 
> Fix a warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/traps.o
> arch/powerpc/kernel/traps.c:1498:6: error: no previous prototype for ‘slb_miss_bad_addr’ [-Werror=missing-prototypes]
>  void slb_miss_bad_addr(struct pt_regs *regs)
>       ^~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45b4d27a3897d6094bcf84bc877439

cheers
