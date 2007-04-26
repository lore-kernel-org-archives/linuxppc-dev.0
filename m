Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 2929DDDF35
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 21:39:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Date: Thu, 26 Apr 2007 13:39:18 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260225.27740.arnd@arndb.de>
	<20070426063315.GE2030@xyzzy.farnsworth.org>
In-Reply-To: <20070426063315.GE2030@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261339.18640.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Dale Farnsworth wrote:
> > /* The probing of PCI controllers from of_platform is currently
> > =A0* 64 bits only, mostly due to gratuitous differences between
> > =A0* the 32 and 64 bits PCI code on PowerPC and the 32 bits one
> > =A0* lacking some bits needed here.
> > =A0*/
>=20
> Is this comment incorrect?
>=20
> I agree that this is more code duplication than I like, and we could
> benefit from some refactoring. =A0However, I find 15 other places in
> arch/powerpc that largely duplicate this pci initialization code.
> That doesn't make a 16th right, but at least I'm in good company.=20

Yes, you're right. I was assuming that the code had been ported to
32 bit already, which was incorrect.

While I would very much like you (or someone else) to make it work,
it should not be a prerequisite to get your code merged in 2.6.22.

The one remaining comment I have about this one is that IMHO it
should be a separate file, mv64x60-pci.c instead of being
in the same file as the interrupt controller and other code.

	Arnd <><
