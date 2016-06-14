Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTFGf2yDvzDqgV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 13:18:34 +1000 (AEST)
In-Reply-To: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/nohash: Fix build break with 4K pages
Message-Id: <3rTFGf1lJLz9t0t@ozlabs.org>
Date: Tue, 14 Jun 2016 13:18:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-06 at 13:21:11 UTC, Michael Ellerman wrote:
> Commit 74701d5947a6 "powerpc/mm: Rename function to indicate we are
> allocating fragments" renamed page_table_free() to pte_fragment_free().
> One occurrence was mistyped as pte_fragment_fre().
> 
> This only breaks the nohash 4K page build, which is not the default or
> enabled in any defconfig.
> 
> Fixes: 74701d5947a6 ("powerpc/mm: Rename function to indicate we are allocating fragments")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes with fixed changelog.

https://git.kernel.org/powerpc/c/8017ea35d33f9e0950d369773a

cheers
