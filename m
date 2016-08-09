Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS66ZSgzDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:46 +1000 (AEST)
In-Reply-To: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, gwshan@linux.vnet.ibm.com
Subject: Re: powerpc/eeh: trivial fix to non-conventional PCI address output
 on EEH log
Message-Id: <3s7sS64mSSz9t1L@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-22-07 at 17:05:29 UTC, "Guilherme G. Piccoli" wrote:
> This is a very minor/trivial fix for the output of PCI address on EEH logs.
> The PCI address on "OF node" field currently is using ":" as a separator
> for the function, but the usual separator is ".". This patch changes the
> separator for dot, so the PCI address is printed as usual.
> 
> No functional changes were introduced.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/10560b9afc8abf349843dff88c

cheers
