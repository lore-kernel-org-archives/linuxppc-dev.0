Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80K706kzDw1s
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:17 +1100 (AEDT)
In-Reply-To: <1480582800-28597-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rashmicy@gmail.com
Subject: Re: powerpc/mm: Fix page table dump build on non-Book3S
Message-Id: <3tW80K5gxDz9t1d@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-01 at 09:00:00 UTC, Michael Ellerman wrote:
> In the recent commit 1515ab932156 ("powerpc/mm: Dump hash table") we
> added code to dump the hage page table. Currently this can be selected
> to build on any platform. However it breaks the build if we're building
> for a non-Book3S platform, because none of the hash page table related
> defines and so on exist. So restrict it to building only on Book3S.
> 
> Similarly in commit 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
> we added code to dump the Linux page tables, which uses some constants
> which are only defined on Book3S - so guard those with an #ifdef.
> 
> Fixes: 1515ab932156 ("powerpc/mm: Dump hash table")
> Fixes: 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/dd5ac03e09554b7504f64990cfbcec

cheers
