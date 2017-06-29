Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKT6ksJzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:17 +1000 (AEST)
In-Reply-To: <20170621071804.11660-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: alistair@popple.id.au, Russell Currey <ruscur@russell.cc>
Subject: Re: [1/2] powerpc/powernv/pci: Add helper to check if a PE has a
 single vendor
Message-Id: <3wyzKT5Lbsz9sNZ@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-21 at 07:18:03 UTC, Russell Currey wrote:
> Add a helper that determines if all the devices contained in a given PE
> are all from the same vendor or not.  This can be useful in determining
> if it's okay to make PE-wide changes that may be suitable for some
> devices but not for others.
> 
> This is used later in the series.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a0f98629f19943fb8387a7d5fd01e6

cheers
