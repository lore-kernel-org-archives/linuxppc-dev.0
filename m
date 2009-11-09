Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 946F3B70B3
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Nov 2009 19:55:12 +1100 (EST)
Subject: Re: [patch 09/16] powerpc: Replace old style lock initializer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20091109161502.ab064092.sfr@canb.auug.org.au>
References: <20091106223547.784916750@linutronix.de>
	<20091106223806.762624109@linutronix.de>
	<1257548144.13611.267.camel@pasglop>
	<20091109161502.ab064092.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Nov 2009 19:53:25 +1100
Message-ID: <1257756805.13611.296.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-11-09 at 16:15 +1100, Stephen Rothwell wrote:
> Hi Thomas,
> 
> On Sat, 07 Nov 2009 09:55:44 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > On Fri, 2009-11-06 at 22:41 +0000, Thomas Gleixner wrote:
> > > plain text document attachment
> > > (power-replace-old-style-lock-init.patch)
> > > SPIN_LOCK_UNLOCKED is deprecated. Init the lock array at runtime
> > > instead.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: linuxppc-dev@ozlabs.org
> > > ---
> > 
> > Looks reasonable. But iseries can be a bitch, so we do need to test it
> > on monday.
> 
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks Stephen !

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
