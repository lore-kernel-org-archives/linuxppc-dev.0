Return-Path: <hjk@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 31679B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 05:24:09 +1000 (EST)
Date: Sun, 14 Jun 2009 21:23:59 +0200
From: "Hans J. Koch" <hjk@linutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614192359.GG3639@local>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
	<20090614171406.GA1010@pengutronix.de>
	<20090614183357.GE3639@local>
	<20090614190533.GA7387@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090614190533.GA7387@pengutronix.de>
Cc: devicetree-discuss@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 14, 2009 at 09:05:33PM +0200, Wolfram Sang wrote:
> 
> > Anyway, 0 is a valid IRQ number, so it cannot be used as "no irq".
> 
> May I point you to this thread?
> 
> http://lkml.org/lkml/2005/11/21/221

Linus is just plain wrong in this 4 year old mail.

> 
> (The issue comes up once in a while as some archs still use NO_IRQ, some with
> 0 some with -1)
> 
> > > 	if (uioinfo->irq == NO_IRQ)
> > > 		uioinfo->irq = UIO_IRQ_NONE;
> > 
> > Sorry for my ignorance, but what is NO_IRQ? If I do a
> > 
> > grep -r NO_IRQ include/
> > 
> > I get nothing.
> 
> Try a 'cd arch' before that :)

no such luck in arch/x86/ ...

> 
> > Well, you claim it's a false positive. So far, you did not get any responses,
> > AFAICS. I tend to agree with you, but I'd like to avoid patches that don't
> > pass checkpatch.pl, whatever the reason. Either the false positive gets
> > confirmed and fixed, or you should fix your patch.
> 
> Well, I assume that issues regarding checkpatch do not have the highest
> priority (especially while the merge-window is open), which is understandable.
> Fixing this bug (I take any bets that this is one ;)) might not be so trivial,
> as modifying $Attributes can easily have lots of side-effects.
> 
> Now, all this does not matter much, as the objections Grant raised are valid
> and there might be a totally different outcome to bind devices to UIO. But at
> least, we have some code to discuss...

OK, I'm looking forward to your next version.

Thanks,
Hans


> 
> Regards,
> 
>    Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
