Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (93-97-173-237.zone5.bethere.co.uk
	[93.97.173.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A208CDDFA0
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 22:49:01 +1100 (EST)
Subject: Re: [GIT PULL] LED updates for 2.6.29
From: Richard Purdie <rpurdie@rpsys.net>
To: Trent Piepho <xyzzy@speakeasy.org>
In-Reply-To: <Pine.LNX.4.58.0901102138300.1626@shell2.speakeasy.net>
References: <1231500186.5317.9.camel@dax.rpnet.com>
	<Pine.LNX.4.64.0901091231310.22972@t2.domain.actdsltmp>
	<1231543199.5317.63.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901100428230.1626@shell2.speakeasy.net>
	<1231633983.5330.32.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901102138300.1626@shell2.speakeasy.net>
Content-Type: text/plain
Date: Sun, 11 Jan 2009 11:49:19 +0000
Message-Id: <1231674559.5304.13.camel@dax.rpnet.com>
Mime-Version: 1.0
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

On Sat, 2009-01-10 at 21:43 -0800, Trent Piepho wrote:
> On Sun, 11 Jan 2009, Richard Purdie wrote:
> > On Sat, 2009-01-10 at 04:31 -0800, Trent Piepho wrote:
> > > The LED tree makes more sense for what's left I think.  There was a
> > > openfirmware gpio patch, but that's already gone in.  What's left only
> > > touches led files and the device tree binding docs.
> > >
> > > AFAIK, there were no objections to the patches left.
> >
> > Ok, these are now queued in the LED tree:
> >
> > http://git.o-hand.com/cgit.cgi/linux-rpurdie-leds/log/
> >
> > I did merge the last three patches in one and make some changes to deal
> > with some other outstanding issues. Let me know ASAP if there are any
> > problems.
> 
> Since the last patch looks like it's just my three patches folded into one,
> shouldn't I be listed as the author and the primary signed off by?

I made changes other than just merging the three together (the
syspend/resume change and the bitfield parts in leds.h) so putting you
as signed off by/authorship would not have been "correct" and I credited
you in the commit message instead. I wanted to get the missing patches
queued ASAP so I went with the way that does fit in the rules as you'd
not have been happy if a modified patch was attributed to you. I'll put
you as author and a signoff if you confirm thats acceptable.

Cheers,

Richard
