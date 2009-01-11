Return-Path: <xyzzy@speakeasy.org>
Received: from mail5.sea5.speakeasy.net (mail5.sea5.speakeasy.net
	[69.17.117.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7691DDF7D
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 23:59:32 +1100 (EST)
Date: Sun, 11 Jan 2009 04:58:09 -0800 (PST)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [GIT PULL] LED updates for 2.6.29
In-Reply-To: <1231674559.5304.13.camel@dax.rpnet.com>
Message-ID: <Pine.LNX.4.58.0901110416510.1626@shell2.speakeasy.net>
References: <1231500186.5317.9.camel@dax.rpnet.com>
	<Pine.LNX.4.64.0901091231310.22972@t2.domain.actdsltmp>
	<1231543199.5317.63.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901100428230.1626@shell2.speakeasy.net>
	<1231633983.5330.32.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901102138300.1626@shell2.speakeasy.net>
	<1231674559.5304.13.camel@dax.rpnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Guennadi Liakhovetski <lg@denx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 11 Jan 2009, Richard Purdie wrote:
> On Sat, 2009-01-10 at 21:43 -0800, Trent Piepho wrote:
> > On Sun, 11 Jan 2009, Richard Purdie wrote:
> > > On Sat, 2009-01-10 at 04:31 -0800, Trent Piepho wrote:
> > > > The LED tree makes more sense for what's left I think.  There was a
> > > > openfirmware gpio patch, but that's already gone in.  What's left only
> > > > touches led files and the device tree binding docs.
> > > >
> > > > AFAIK, there were no objections to the patches left.
> > >
> > > Ok, these are now queued in the LED tree:
> > >
> > > http://git.o-hand.com/cgit.cgi/linux-rpurdie-leds/log/
> > >
> > > I did merge the last three patches in one and make some changes to deal
> > > with some other outstanding issues. Let me know ASAP if there are any
> > > problems.
> >
> > Since the last patch looks like it's just my three patches folded into one,
> > shouldn't I be listed as the author and the primary signed off by?
>
> I made changes other than just merging the three together (the
> syspend/resume change and the bitfield parts in leds.h) so putting you
> as signed off by/authorship would not have been "correct" and I credited
> you in the commit message instead. I wanted to get the missing patches
> queued ASAP so I went with the way that does fit in the rules as you'd
> not have been happy if a modified patch was attributed to you. I'll put
> you as author and a signoff if you confirm thats acceptable.

It doesn't seem right to merge someone's patches together, make a very
small change, and then no longer credit them as the author.  Seems like it
defeats the purpose of the SOB lines for tracing the train of custody too.
If someone looks to see where the code came from, it will look like you
wrote it.  Maybe Freescale will say Intel stole our code?  Without the SOB,
what record is there in git that Freescale gave permission to put the code
in the kernel?

I also put some significant effort into writing informative commit
messages, which have been lost.  Along with Grant's acks for my patches.
