Return-Path: <ronb@lcsaudio.com>
Received: from pd3mo1so.prod.shaw.ca (shawidc-mo1.cg.shawcable.net
	[24.71.223.10]) by ozlabs.org (Postfix) with ESMTP id 5F82B67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 06:04:00 +1100 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0ICQ00DSMNML8RA0@l-daemon> for
	linuxppc-embedded@ozlabs.org; Wed, 02 Mar 2005 12:03:57 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd2mr2so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01
	(built Mar
	15 2004)) with ESMTP id <0ICQ004RQNML8Q40@pd2mr2so.prod.shaw.ca> for
	linuxppc-embedded@ozlabs.org; Wed, 02 Mar 2005 12:03:57 -0700 (MST)
Received: from ronsp4 ([24.70.124.240])
	by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28
	2003))
	with SMTP id <0ICQ00E1FNMLMB@l-daemon> for linuxppc-embedded@ozlabs.org;
	Wed, 02 Mar 2005 12:03:57 -0700 (MST)
Date: Wed, 02 Mar 2005 11:03:32 -0800
From: Ron Bianco <ronb@lcsaudio.com>
In-reply-to: <42260A4F.8030205@katalix.com>
To: James Chapman <jchapman@katalix.com>
Message-id: <NCBBJPCHJLKAEAHINDCEMEKAFMAA.ronb@lcsaudio.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: linuxppc tree with mv64xxx included?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks James and Mark,

I should have searched it rather than looking in 2.4 tree locations. :-P
We're going with 2.5 (2.6), but still getting familiar... many improvements
over 2.4.23.

Ron

> -----Original Message-----
> From: James Chapman [mailto:jchapman@katalix.com]
>
> Ron Bianco wrote:
>
> > I'm trying to locate the correct bitkeeper or other URL to get
> access to a
> > linux 2.5 or 2.6 tree that includes the support for the marvell mv64xxx
> > series chips.
> > I've examined the emails in this list regarding related patches
> for clues,
> > but am still confused.
> >
> > Tried bk://ppc.bkbits.net/linuxppc-2.5, but there is no marvell code.
>
> There is Marvell code in that tree. Look in drivers/net/mv64*,
> arch/ppc/syslib/mv*
>
> Some boards are already ported. See arch/ppc/platforms/*
>
> You'll also find the Marvell code in the "mainline" at
>
> bk://linux.bkbits.net/linux-2.6
>
> > We downloaded a 2.4.23 kernel tree directly from the marvell
> website, but it
> > is lacking some things like i2c for marvell, that have been
> discussed here.
> > Was further work, existing in some other tree, based on this?
>
> i2c and several other improvements are in queue. Check the archives for
> patches.
>
> The latest ethernet code can be obtained from
> bk://farnsworth.bkbits.net/linux-2.5-mv643xx-enet
>
> --
> James Chapman
> PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
