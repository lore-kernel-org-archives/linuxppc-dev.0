Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 01C0767A42
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2005 01:12:52 +1000 (EST)
In-Reply-To: <20050505142354.GZ1221@smtp.west.cox.net>
References: <20050505142354.GZ1221@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <a5cd7b845e0ede0ec78656a07f0c15a6@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 5 May 2005 10:12:42 -0500
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 5, 2005, at 9:23 AM, Tom Rini wrote:

> On Thu, May 05, 2005 at 09:00:50AM -0500, Kumar Gala wrote:
>  >
> > On May 5, 2005, at 7:24 AM, Dan Malek wrote:
>  >
> > >
>  > >
>  > >On May 5, 2005, at 1:22 AM, Paul Mackerras wrote:
>  > > > If you think we should have -mcpu=3Dxxx on the command line for=20=

> 4xx,
>  > > > 44x, 8xx, etc., then that's fine, but that is a separate =
problem
> > >from
>  > > > what my patch was addressing (one which my patch might make it
> > >easier
>  > > > to fix, though).
>  > >
>  > >I think that is exactly what we want, although I don't know how=20
> that is
>  > > separate from the patch you sent.? My original comment was the=20
> patch
>  > > fixes the problem for only one of the cpu cores, not all of =
them.?
> > >Which
>  > > then led into the subsequent suggestion of making the biarch work
>  > > like the past compilers, and we must specific the flags for =
POWER4
>  > > instead of the other way around.? Without explicit -mcpu flags,=20=

> the
>  > > existing compiler behavior is just fine .....? but, I guess I'd =
be
>  > >standing
>  > > in the way of progress to want this :-)
>  >
> > I agree with Dan here.=A0 I think we should go ahead and extend the=20=

> patch
> > to set -mcpu and -mtune flags for the list of processors we have in
> > "Processor Type".=A0 If I'm building a kernel for e500 or 4xx I =
might=20
> as
> > well get a kernel that is tuned a bit more for the subarch.=A0
>
>  This is fine.
>
> > Additionally, there should be some expert override ability, so if I
> > really want to do -mcpu=3D7455 -mtune=3D7455 I can.
>
> Gack, no!=A0 It's quite a pain to go from CONFIG_FOO=3D"string" into=20=

> useable
>  Makefile bits that the one we did have back in 2.4 is gone.=A0 That =
also
>  implies gcc finally knows something about these cores that might be
>  useful, which I don't think is the case, nor is it likely to be.=A0 =
But=20
> if
>  we did want it, we'd probably go the route x86 has.

I'm not saying it has to be done via a CONFIG option, all I'm saying is=20=

if I want to explicitly use GCC then I would hope we could somehow=20
disable it being override.

- kumar=
