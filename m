Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D085BDDE3A
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 03:47:59 +1000 (EST)
Date: Sat, 19 May 2007 19:28:05 +0200 (MEST)
Message-Id: <200705191728.l4JHS5A9026303@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: segher@kernel.crashing.org
Subject: Re: gcc-4.2.0 breakage on powerpc?
Cc: linuxppc-dev@ozlabs.org, mikpe@it.uu.se, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 19 May 2007 18:11:20 +0200, Segher Boessenkool wrote:
> >>>> and we'll end up
> >>>> having major kernel releases which don't build on i386 with major 
> >>>> gcc
> >>>> releases, which isn't altogether desirable.
> >>>
> >>> Yeah, like 4.2.0 with powerpc.  Seems like no one tested it :-(
> >>
> >> Details please. What exactly are the gcc-4.2.0 problems on powerpc?
> >
> > http://gcc.gnu.org/PR31490 .  Most stuff using named
> > sections won't build; that includes CONFIG_MODULES.
> > There is no viable workaround.  The problem is being
> > handled.  I'll post a patch for the kernel refusing
> > to build with this combination soon.
> 
> [Cc:ing the PowerPC list]
> 
> Oh btw, most likely this is a problem on 64-bit only.

I believe so too. PR31490 mostly talks about ppc64,
and I've built both ppc32 kernels and complex ppc32
user-space programs with gcc-4.2.0 without noticing
any regressions.

/Mikael
