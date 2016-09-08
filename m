Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVFrB6ScgzDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:47:54 +1000 (AEST)
In-Reply-To: <1473133425.2313.58.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <michaele@au1.ibm.com>
Subject: Re: powerpc/xics/opal: Fix processor numbers in OPAL ICP
Message-Id: <3sVFrB4KyXz9s36@ozlabs.org>
Date: Thu,  8 Sep 2016 19:47:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 03:43:45 UTC, Benjamin Herrenschmidt wrote:
> When using the OPAL ICP backend we incorrectly pass Linux CPU numbers
> rather than HW CPU numbers to OPAL.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: d74361881f0dfe5f9dcac37d1b753a15a2345d8c

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f8e33475b0da98c4bffc91017a

cheers
