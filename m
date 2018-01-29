Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNC4d4zzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:47 +1100 (AEDT)
In-Reply-To: <1509666992-4649-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/cell: Remove axonram driver
Message-Id: <3zVGNB6s1Vz9t2c@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-02 at 23:56:32 UTC, Michael Ellerman wrote:
> The QS21/22 IBM Cell blades had a southbridge chip called Axon. This
> could have DDR DIMMs attached to it, though they were not directly
> usable as RAM, instead they could be used as some sort of buffer, if
> applications were written specifically to use the block device
> provided by the driver.
> 
> Although the driver supposedly had direct access support, it was
> apparently never tested (see commit 91117a20245b ("axonram: Fix bug in
> direct_access")).
> 
> These machines have not been available for over 5 years, and were
> never widely in use. It seems highly unlikely anyone is using this
> driver.
> 
> In general we're happy to leave old drivers in the tree, but because
> DAX is involved this driver is caught up in the ongoing work in that
> area, but none of the DAX folks are able to test it.
> 
> So remove the driver, if any one *is* using it, we'll be happy to put
> it back.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/1d65b1c886be6111f2347bd1a548be

cheers
