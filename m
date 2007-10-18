Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C677CDDF26
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 01:29:43 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9IFTcSD017503
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:29:38 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9IFTaMX004153
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 10:29:37 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v6 2/9] ipic: add new interrupts introduced by new chip
Date: Thu, 18 Oct 2007 23:29:35 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5BD8@zch01exm26.fsl.freescale.net>
In-Reply-To: <3551DBD0-5DCB-4ECE-8509-E99B010A6D07@kernel.crashing.org>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<3551DBD0-5DCB-4ECE-8509-E99B010A6D07@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, October 18, 2007 10:57 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v6 2/9] ipic: add new interrupts=20
> introduced by new chip
>=20
>=20
> On Oct 18, 2007, at 10:04 AM, Li Yang wrote:
>=20
> > These interrupts are introduced by the latest Freescale SoC such as=20
> > MPC837x.  The patch also adds comment to interrupts.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/sysdev/ipic.c |  224 +++++++++++++++++++++++++++++++++
> > +----------
> >  arch/powerpc/sysdev/ipic.h |    7 +-
> >  include/asm-powerpc/ipic.h |   12 ++-
> >  3 files changed, 186 insertions(+), 57 deletions(-)
>=20
> see comments:
>=20
> http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044636.html

But you didn't answer to my feedback
http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044711.html

If you are so persistent on thinking it's harmful rather than useful,
please at least attempt to persuade me.

- Leo
