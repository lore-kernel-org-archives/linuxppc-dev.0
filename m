Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSTg30XMmzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 19:34:39 +1000 (AEST)
In-Reply-To: <1494931835-3813-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rashmicy@gmail.com
Subject: Re: powerpc/mm: Fix crash in page table dump with huge pages
Message-Id: <3wSTg26tsyz9s8D@ozlabs.org>
Date: Wed, 17 May 2017 19:34:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-16 at 10:50:35 UTC, Michael Ellerman wrote:
> The page table dump code doesn't know about huge pages, so currently
> it crashes (or walks random memory, usually leading to a crash), if it
> finds a huge page. On Book3S we only see huge pages in the Linux page
> tables when we're using the P9 Radix MMU.
> 
> Teaching the code to properly handle huge pages is a bit more involved,
> so for now just prevent the crash.
> 
> Cc: stable@vger.kernel.org # v4.10+
> Fixes: 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/bfb9956ab4d8242f4594b5f4bee534

cheers
