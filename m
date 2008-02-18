Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6EFC3DDE42
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 00:53:15 +1100 (EST)
Date: Tue, 19 Feb 2008 00:53:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: linux-next: ide pmac.c fix
Message-Id: <20080219005311.69ee72ff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__19_Feb_2008_00_53_11_+1100_WCoOsDyR8JwBxu/c"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__19_Feb_2008_00_53_11_+1100_WCoOsDyR8JwBxu/c
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bart,

the current linux-next produces this error for a pmac32 powerpc build:

drivers/ide/ppc/pmac.c:1094: error: conversion to non-scalar type requested
drivers/ide/ppc/pmac.c:1232: error: conversion to non-scalar type requested

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__19_Feb_2008_00_53_11_+1100_WCoOsDyR8JwBxu/c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHuY3LTgG2atn1QN8RAjRkAJ98qGk4oNVpkXBlOKqBD2UxogoUWgCfS0NB
hU2DUK40ULxAqACFWDvGnlE=
=hTTE
-----END PGP SIGNATURE-----

--Signature=_Tue__19_Feb_2008_00_53_11_+1100_WCoOsDyR8JwBxu/c--
