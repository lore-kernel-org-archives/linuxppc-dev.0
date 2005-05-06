Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 48778679F6
	for <linuxppc-dev@ozlabs.org>; Sat,  7 May 2005 01:47:15 +1000 (EST)
In-Reply-To: <20050506145313.GE1221@smtp.west.cox.net>
References: <20050506145313.GE1221@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <295499f9bdebac826a534516d85db8f0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 6 May 2005 10:47:14 -0500
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


On May 6, 2005, at 9:53 AM, Tom Rini wrote:

> On Fri, May 06, 2005 at 04:44:33PM +0200, Segher Boessenkool wrote:
>  > >Well, say you are compiling for 405.=A0 You either need to have a =
gcc
>  > >that was configured with --with-cpu=3D405, or you need to have =
hacked
>  > >arch/ppc/Makefile to add -mcpu=3D405.=A0 In both cases the problem=20=

> doesn't
>  > >arise.=A0 It only arises if you have a biarch gcc4 that was=20
> configured
>  > >without any --with-cpu=3Dxxx option and is run without any =
-mcpu=3Dxxx
> > >option.
>  >
> > It happens for any installation where the default chosen by the GCC
>  > used is not the -mcpu=3DXXX flag you need used for your kernel.=A0 =
Which
>  > is a much more general statement than the biarch one.=A0 Most =
people=20
> just
>  > get lucky, because they compile code with a compiler that is=20
> defaulted
>  > for their target, and userland and kernel use (about) the same=20
> options
>  > on most targets.=A0 Not so in biarch land (bleeech).
>
> Note that up until very recently (and just a bit before conflicting
>  opcodes were added), no -mcpu=3DXXX was required.=A0 For example, I=20=

> compiled
>  a 44x kernel with a -mcpu=3D750 toolchain no problems shortly after =
Paul
>  posted this.=A0 The only exception to this rule I can possibly think =
of=20
> is
>  85xx.=A0 But even that would be the "very recently" thing I mentioned =
as
>  I know you can use an 82xx-set toolchain to build for 85xx.
>
> Having said that..

I do the same thing as well and the only issue I have is that 85xx=20
doesn't support strings thus the conditional we currently have for=20
-mstring.

- kumar=
