Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 44E46DDE2C
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 13:40:19 +1100 (EST)
Date: Sat, 12 Jan 2008 13:40:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/5] Warp Base Platform
Message-Id: <20080112134005.a262c95c.sfr@canb.auug.org.au>
In-Reply-To: <4787FE23.7010201@pikatech.com>
References: <47852C41.8000506@pikatech.com>
	<20080111174259.b749f1f0.sfr@canb.auug.org.au>
	<47871675.6030602@pikatech.com>
	<20080111115143.4ed89ab6@zod.rchland.ibm.com>
	<4787FE23.7010201@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__12_Jan_2008_13_40_05_+1100_zFSsT3x_/SZOmO7p"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__12_Jan_2008_13_40_05_+1100_zFSsT3x_/SZOmO7p
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Fri, 11 Jan 2008 18:39:15 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> +++ arch/powerpc/platforms/44x/warp-nand.c	2008-01-11 18:04:10.000000000 =
-0500
> @@ -0,0 +1,85 @@

You need a copyright/license notice.

The only other concern I have left is the extern in the C file, but that
can be dealt with later.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__12_Jan_2008_13_40_05_+1100_zFSsT3x_/SZOmO7p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHiCiLTgG2atn1QN8RAh35AKCXejEbyvYBqJlIeiYLmXBswC5hfACeNmjB
02Q1OfZTpUlwgG7dnngk7rQ=
=6LeZ
-----END PGP SIGNATURE-----

--Signature=_Sat__12_Jan_2008_13_40_05_+1100_zFSsT3x_/SZOmO7p--
