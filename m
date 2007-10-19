Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3B0BDDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 13:56:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9J3uYsA018110
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:56:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9J3uXiJ018260
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 22:56:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v6 4/9] add platform support for MPC837x MDS board
Date: Fri, 19 Oct 2007 11:56:34 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5C3A@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071019104318.edfd2ad1.sfr@canb.auug.org.au>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com><1192719847-25045-2-git-send-email-leoli@freescale.com><1192719847-25045-3-git-send-email-leoli@freescale.com><1192719847-25045-4-git-send-email-leoli@freescale.com>
	<20071019104318.edfd2ad1.sfr@canb.auug.org.au>
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
> Sent: Friday, October 19, 2007 8:43 AM
> To: Li Yang-r58472
> Cc: galak@kernel.crashing.org; paulus@samba.org;=20
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v6 4/9] add platform support for MPC837x MDS board

> > +static int __init mpc837x_mds_probe(void) {
> > +        unsigned long root =3D of_get_flat_dt_root();
> > +
> > +        return of_flat_dt_is_compatible(root, "fsl,mpc837xmds");
>=20
> To call these two routines, you should include <asm/prom.h> directly.

<asm/prom.h> is included in <linux/of.h> now.  Do you think it should be
included explicitly?

- Leo
