Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 77CDBDDF3C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 17:07:01 +1100 (EST)
Date: Wed, 9 Jan 2008 17:06:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 7/7] Add MPC512x PSC serial driver
Message-Id: <20080109170650.a9673be5.sfr@canb.auug.org.au>
In-Reply-To: <20080109141649.04a1783c.sfr@canb.auug.org.au>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
	<1199808093-15929-6-git-send-email-jrigby@freescale.com>
	<1199808093-15929-7-git-send-email-jrigby@freescale.com>
	<1199808093-15929-8-git-send-email-jrigby@freescale.com>
	<20080109141649.04a1783c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_17_06_50_+1100_Ump9N1aTpXqecIIB"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_17_06_50_+1100_Ump9N1aTpXqecIIB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Jan 2008 14:16:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Tue,  8 Jan 2008 09:01:33 -0700 John Rigby <jrigby@freescale.com> wrot=
e:
> >
> > +++ b/drivers/serial/mpc512x_uart.c
> >
> > +#include <asm/of_platform.h>
>=20
> Purely to avoid suggestions of favouritism, I will not the above. :-)
                                                     ^^^
"note", of course :-(

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_17_06_50_+1100_Ump9N1aTpXqecIIB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhGR9TgG2atn1QN8RArMiAJ9dj8bK1UcjAgo6xnkMtmLVNVDCMgCfa4yU
X4N49Mmk3egERmY8O/iSPnI=
=sjLL
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_17_06_50_+1100_Ump9N1aTpXqecIIB--
