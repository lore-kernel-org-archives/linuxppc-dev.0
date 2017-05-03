Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHW0NxXzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:19:03 +1000 (AEST)
In-Reply-To: <1493781848-5826-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, sbaskaran@nvidia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: powerpc/powernv: Fix TCE kill on NVLink2
Message-Id: <3wJCHV6hrFz9s0g@ozlabs.org>
Date: Thu,  4 May 2017 08:19:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-03 at 03:24:08 UTC, Alistair Popple wrote:
> Commit 616badd2fb49 ("powerpc/powernv: Use OPAL call for TCE kill on
> NVLink2") forced all TCE kills to go via the OPAL call for
> NVLink2. However the PHB3 implementation of TCE kill was still being
> called directly from some functions which in some circumstances caused
> a machine check.
> 
> This patch adds an equivalent IODA2 version of the function which uses
> the correct invalidation method depending on PHB model and changes all
> external callers to use it instead.
> 
> Fixes: 616badd2fb49 ("powerpc/powernv: Use OPAL call for TCE kill on NVLink2")
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: stable@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6b3d12a948d27977816a15eb48409a

cheers
