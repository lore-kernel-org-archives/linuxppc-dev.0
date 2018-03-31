Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bG2hKLzF1pr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:10 +1100 (AEDT)
In-Reply-To: <20180326150233.23089-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/powernv/nvram: opal_nvram_write handle unknown OPAL errors
Message-Id: <40D0bF6VVsz9s3v@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-26 at 15:02:33 UTC, Nicholas Piggin wrote:
> opal_nvram_write currently just assumes success if it encounters an
> error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
> on other errors instead.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/741de617661794246f84a21a02fc5e

cheers
