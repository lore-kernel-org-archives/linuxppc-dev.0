Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvgsf0mDlzDqHC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 23:33:58 +1100 (AEDT)
In-Reply-To: <1490319797.28113.46.camel@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: powerpc/powernv: Fix XSCOM address mangling for form 1 indirect
Message-Id: <3vvgsd5YSDz9s03@ozlabs.org>
Date: Fri, 31 Mar 2017 23:33:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-24 at 01:43:17 UTC, Michael Neuling wrote:
> POWER9 adds form 1 scoms. The form of the indirection is specified in
> the top nibble of the scom address.
> 
> Currently we do some (ugly) bit mangling so that we can fit a 64 bit
> scom address into the debugfs interface. The current code only shifts
> the top bit (indirect bit).
> 
> This patch changes it to shift the whole top nibble so that the form
> of the indirection is also shifted.
> 
> This patch is backwards compatible with older scoms.
> 
> (This change isn't required in the
> arch/powerpc/platformspowernv/opal-prd.c scom interface as it passes
> the whole 64bit scom address without any bit mangling)
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/517c27570cf38f182e7a688d50a9b9

cheers
