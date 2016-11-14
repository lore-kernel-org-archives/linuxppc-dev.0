Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzl1FvCzDvN8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:23 +1100 (AEDT)
In-Reply-To: <1472106670-3432-1-git-send-email-rui.teng@linux.vnet.ibm.com>
To: Rui Teng <rui.teng@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rui Teng <rui.teng@linux.vnet.ibm.com>, paulus@samba.org
Subject: Re: powerpc: Remove suspect CONFIG_PPC_BOOK3E #ifdefs in
 nohash/64/pgtable.h
Message-Id: <3tHTzk6qH5z9t17@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-25-08 at 06:31:10 UTC, Rui Teng wrote:
> There are three #ifdef CONFIG_PPC_BOOK3E sections in nohash/64/pgtable.h.
> And there should be no configurations possible which use nohash/64/pgtable.h
> but don't also enable CONFIG_PPC_BOOK3E.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fda0440d82d38e603cd713e997fdfe

cheers
