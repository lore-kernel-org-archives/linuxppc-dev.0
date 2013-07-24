Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E2242C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 05:23:11 +1000 (EST)
Date: Wed, 24 Jul 2013 14:22:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20130723133032.GB31944@concordia> (from michael@ellerman.id.au
 on Tue Jul 23 08:30:32 2013)
Message-ID: <1374693773.15592.59@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Neil Horman <nhorman@tuxdriver.com>, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 08:30:32 AM, Michael Ellerman wrote:
> On Fri, Jul 19, 2013 at 05:59:30PM -0500, Scott Wood wrote:
> > On 07/17/2013 11:00:45 PM, Anton Blanchard wrote:
> > >
> > >Hi Scott,
> > >
> > >> What specifically should I do to test it?
> > >
> > >Could you double check perf annotate works? I'm 99% sure it will =20
> but
> > >that is what was failing on ppc64.
> >
> > I'm not really sure what it's supposed to look like when "perf
> > annotate" works.  It spits a bunch of unreadable[1]
> > dark-blue-on-black assembly code at me, all with "0.00 :" in the
> > left column.
> >
> > Oh, wait -- some lines have "100.00 : " on the left, in
> > even-more-unreadable dark-red-on-black.
> >
> > Apart from the annoying colors, is there anything specific I should
> > be looking for?  Some sort of error message, or output that actually
> > makes sense?
>=20
> The colours look fine on my terminal, so I don't know what you've done
> there.

It probably looks better if the terminal is configured to have a light =20
background (which of course makes some other programs look worse), or =20
(as I noted) if you've got your monitor set to be very bright.  I now =20
see that xfce4-terminal lets me redefine the standard colors, though, =20
so that should help.

> If you care you can use "--stdio" to use the plainer interface,
> though it still uses colours.
>=20
> That output looks fine in terms of the bug Anton was chasing. As far =20
> as
> only ever hitting one instruction that does look weird.

OK.  I'll add "investigate weird e500 perf annotate results" to the =20
TODO list...

-Scott=
