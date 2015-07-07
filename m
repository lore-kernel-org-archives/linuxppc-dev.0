Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A3B41A1059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:03 +1000 (AEST)
In-Reply-To: <1435816521-13159-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Daniel Axtens <dja@axtens.net>, imunsie@au.ibm.com
Subject: Re: cxl: Test the correct mmio space before unmapping
Message-Id: <20150707103803.7304D1402BF@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-07 at 05:55:21 UTC, Daniel Axtens wrote:
> Before freeing p2n, test p2n, not p1n.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=8c00d5c9d3e7452658dda55024485d52919ebfdd

cheers
