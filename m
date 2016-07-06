Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl0Pk1ZY5zDr0Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 22:27:22 +1000 (AEST)
In-Reply-To: <1467781086-21125-1-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
 cyrilbur@gmail.com
Subject: Re: powerpc/tm: Fix stack pointer corruption in __tm_recheckpoint
Message-Id: <3rl0Pk0bDhz9snm@ozlabs.org>
Date: Wed,  6 Jul 2016 22:27:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-07 at 04:58:06 UTC, Michael Neuling wrote:
> At the start of __tm_recheckpoint we save the kernel stack pointer
> (r1) in SPRG SCRATCH0 (SPRG2) so that we can restore it after the
> trecheckpoint.
...
> 
> This patches moves the saving of r1 to the SPRG to the region where we
> are guaranteed not to take any further SLB misses.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Acked-by: Cyril Bur <cyrilbur@gmail.com>
> Cc: stable@vger.kernel.org # v3.9+

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/eb584b3ee4d317cf7e0068bec0

cheers
