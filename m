Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2010E67A30
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2005 16:55:46 +1100 (EST)
In-Reply-To: <1107407613.2363.9.camel@gaston>
References: <1107407613.2363.9.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <3C2E1EF2-75A8-11D9-9151-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 2 Feb 2005 23:55:40 -0600
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Chris Friesen <cfriesen@nortel.com>
Subject: Re: new binutils breaks "tlbie" instruction in kernel?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Someone should just add some of our asm files into the ppc binutils=20
testsuite, why we cant seem to get a stability on this seems beyond me=20=

:)  Well, something else to add to the ppc kernel janitors list.

- kumar

On Feb 2, 2005, at 11:13 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2005-02-02 at 12:39 -0600, Chris Friesen wrote:
>  > The "tlbie" instruction has a bit which may be set to indicate=20
> regular
> > or large page size.=A0 This used to be set via an optional second=20
> parameter.
>  >
> > Apparently some time between binutils versions 2.15.91.0.2 and
> > 2.15.92.0.2 a change went in to make this second parameter =
mandatory,
> > which breaks the kernel ppc code.
>  >
> > What is the recommended way to fix this?=A0 Do all binutils versions
> > understand the second parameter, or will "sufficiently old" versions
> > choke on it?
>
> Wasn't it fixed ?
>
> Ben.
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
