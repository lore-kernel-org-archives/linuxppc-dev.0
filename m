Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 062A41A0711
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 07:47:36 +1000 (AEST)
Date: Fri, 31 Jul 2015 23:47:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 00/20] powerpc: Interrupt cleanups and API change
 preparation
In-Reply-To: <1437021436.28475.7.camel@ellerman.id.au>
Message-ID: <alpine.DEB.2.11.1507312344220.3825@nanos>
References: <20150713135648.540293392@linutronix.de>
 <1437021436.28475.7.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 16 Jul 2015, Michael Ellerman wrote:

Sorry I missed your reply ...

> On Mon, 2015-07-13 at 20:50 +0000, Thomas Gleixner wrote:
> > The following patch series contains the following changes:
> > 
> >     - Consolidation of chained interrupt handler setup/removal
> > 
> >     - Switch to functions which avoid a redundant interrupt
> >       descriptor lookup
> > 
> >     - Preparation of interrupt flow handlers for the 'irq' argument
> >       removal
> > 
> > The series has no dependencies ...
> 
> But I assume you have work that will depend on it? So you're going to merge it
> via your tree at least I assume?

Can be done either way. The last step will happen when the merge
window closes. So all I care it that it lands in 4.3

> > ... and is also available as a git branch for your convenience:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/arm
> 
> I can't find this.
> 
> Did you mean irq/ppc or irq/powerpc maybe? I can't find those either.

Gah.

git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git queue/irq/powerpc

Sorry for the confusion.

Thanks,

	tglx
