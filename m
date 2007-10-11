Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62AB0DDFAF
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 17:29:20 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9B7TDLI002182
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 00:29:14 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9B7TCno026182
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 02:29:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/9] add platform support for MPC837x MDS board
Date: Thu, 11 Oct 2007 15:28:59 +0800
Message-ID: <989B956029373F45A0B8AF029708189001764A74@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071011110546.99239e24.sfr@canb.auug.org.au>
References: <1192010804-20071-1-git-send-email-leoli@freescale.com><1192010804-20071-2-git-send-email-leoli@freescale.com><1192010804-20071-3-git-send-email-leoli@freescale.com><1192010804-20071-4-git-send-email-leoli@freescale.com>
	<20071011110546.99239e24.sfr@canb.auug.org.au>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
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
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]=20
> Sent: Thursday, October 11, 2007 9:06 AM
> To: Li Yang-r58472
> Cc: galak@kernel.crashing.org; paulus@samba.org;=20
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 4/9] add platform support for MPC837x MDS board
>=20
> On Wed, 10 Oct 2007 18:06:39 +0800 Li Yang=20
> <leoli@freescale.com> wrote:
> >
> > +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> >
> > +#include <asm/of_platform.h>
>=20
> You actually neeed linux/of.h (for of_ routines) and=20
> asm/prom.h (for of_flat_dt_is_compatible).

Thanks for the comments.  Updated version on the way.

- Leo
