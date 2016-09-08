Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVFr83kY8zDsTF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:47:52 +1000 (AEST)
In-Reply-To: <1473135438-32761-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Fix corrupted PE allocation bitmap on releasing
 PE
Message-Id: <3sVFr82KMSz9s5w@ozlabs.org>
Date: Thu,  8 Sep 2016 19:47:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 04:17:18 UTC, Gavin Shan wrote:
> In pnv_ioda_free_pe(), the PE object (including the associated PE
> number) is cleared before resetting the corresponding bit in the
> PE allocation bitmap. It means PE#0 is always released to the bitmap
> wrongly.
> 
> This fixes above issue by caching the PE number before the PE object
> is cleared.
> 
> Fixes: 1e9167726c41 ("powerpc/powernv: Use PE instead of number during setup and release"
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/caa58f808834fca9a4443233fd

I added:
    Cc: stable@vger.kernel.org # v4.7+

cheers
