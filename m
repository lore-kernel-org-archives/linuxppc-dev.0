Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49D9F1A0484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 10:38:11 +1000 (AEST)
Message-ID: <1442450291.8456.1.camel@ellerman.id.au>
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 17 Sep 2015 10:38:11 +1000
In-Reply-To: <1442420984.2909.179.camel@freescale.com>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-16 at 11:29 -0500, Scott Wood wrote:
> On Wed, 2015-09-16 at 18:23 +0200, Thomas Gleixner wrote:
> > With this commit applied, my MPC5200 board fails to boot 4.3-rc1. The
> > boot failure is silent.
> > 
> > Bisection pointed straight to this commit. Reverting it on top of
> > 4.3-rc1 works like a charm.
> 
> Yes, we've been iterating on a fix for this, and I think the patches posted 
> earlier today are ready to go in:
> 
> http://patchwork.ozlabs.org/patch/518321/
> http://patchwork.ozlabs.org/patch/518323/

Yeah, sorry it took a few iterations, maybe we should have reverted first.

Anyway I'll take that as an ack from you Scott and put these in my fixes branch
with Thomas' Tested-by.

cheers
