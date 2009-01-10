Return-Path: <xyzzy@speakeasy.org>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A043DE830
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 23:31:13 +1100 (EST)
Date: Sat, 10 Jan 2009 04:31:06 -0800 (PST)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [GIT PULL] LED updates for 2.6.29
In-Reply-To: <1231543199.5317.63.camel@dax.rpnet.com>
Message-ID: <Pine.LNX.4.58.0901100428230.1626@shell2.speakeasy.net>
References: <1231500186.5317.9.camel@dax.rpnet.com>
	<Pine.LNX.4.64.0901091231310.22972@t2.domain.actdsltmp>
	<1231543199.5317.63.camel@dax.rpnet.com>
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

On Fri, 9 Jan 2009, Richard Purdie wrote:
> On Fri, 2009-01-09 at 12:37 -0800, Trent Piepho wrote:
> > On Fri, 9 Jan 2009, Richard Purdie wrote:
> > > for the LED tree updates for 2.6.29. This includes some new drivers,
> > > bugfixes and a core improvement resulting in nicer code.
> > >
> >
> > Any chance of these patches getting accepted?  They've been going back and
> > forth for months now.
> >
> > [v2,1/4] leds: Support OpenFirmware led bindings
> > http://patchwork.ozlabs.org/patch/13581/
> >
> > [v2,2/4] leds: Add option to have GPIO LEDs start on
> > http://patchwork.ozlabs.org/patch/13580/
> >
> > [v2,3/4] leds: Let GPIO LEDs keep their current state
> > http://patchwork.ozlabs.org/patch/13583/
> >
> > [v2,4/4] leds: Use tristate property in platform data
> > http://patchwork.ozlabs.org/patch/13584/
>
> I think there was some confusion as to who was going to take them. Are
> the PPC people happy with them? If so I'll merge through the LED tree.
> There are these and a couple of other patches around which have got lost
> in the system. If there is time which I'm hoping there might be, I'll
> try and get a second LED tree merge in.

The LED tree makes more sense for what's left I think.  There was a
openfirmware gpio patch, but that's already gone in.  What's left only
touches led files and the device tree binding docs.

AFAIK, there were no objections to the patches left.
