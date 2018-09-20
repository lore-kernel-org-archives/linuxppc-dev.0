Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SX0TWSzF38M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:00 +1000 (AEST)
In-Reply-To: <1534877088-22303-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, Alistair Popple <alistair@popple.id.au>
Subject: Re: powerpc/iommu: avoid derefence before pointer check
Message-Id: <42G3SW2tMMz9sCm@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-21 at 18:44:48 UTC, Breno Leitao wrote:
> The tbl pointer is being derefenced by IOMMU_PAGE_SIZE prior the check if
> it is not NULL.
> 
> Just moving the dereference code to after the check, where there will be
> guarantee that 'tbl' will not be NULL.
> 
> CC: Alistair Popple <alistair@popple.id.au>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/984ecdd68de0fa1f63ce205d6c19ef

cheers
