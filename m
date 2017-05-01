Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdn4HYQzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:53 +1000 (AEST)
In-Reply-To: <1493381123-26701-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/mm/hash: Fix off-by-one in comment about kernel contexts
 ids
Message-Id: <3wGTdn35SWz9sNM@ozlabs.org>
Date: Mon,  1 May 2017 12:58:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-04-28 at 12:05:23 UTC, Michael Ellerman wrote:
> Michal Suchánek noticed a comment in book3s/64/mmu-hash.h about the context ids
> we use for the kernel was inconsistent with the code and other comments in the
> same file.
> 
> It should read 1-4 not 1-5.
> 
> While we're touching it, update "address" to "addresses" which makes more sense
> as it's referring to more than one address below.
> 
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/add2e1e585875b42ac745c05bf0e7f

cheers
