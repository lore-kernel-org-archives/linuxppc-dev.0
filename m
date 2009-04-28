Return-Path: <albrecht.dress@arcor.de>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.112])
	by ozlabs.org (Postfix) with ESMTP id A1727DDEF1
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 03:55:34 +1000 (EST)
Received: from antares (xdsl-87-79-53-95.netcologne.de [87.79.53.95])
	by smtp2.netcologne.de (Postfix) with ESMTP id EE3FB4224
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 19:55:27 +0200 (MEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id D4F23BA03B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 19:55:27 +0200 (CEST)
Date: Tue, 28 Apr 2009 19:55:17 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: How to use Localbus on 5200B w/ 2.6.29.1
To: linuxppc-dev@ozlabs.org
In-Reply-To: <fa686aa40904271036n5c610fdehe1c7906fff2b893b@mail.gmail.com>
	(from grant.likely@secretlab.ca on Mon Apr 27 19:36:58 2009)
Message-Id: <1240941326.3710.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-7BMs2DyjpFCNq7gi4CLL"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-7BMs2DyjpFCNq7gi4CLL
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant:

Am 27.04.09 19:36 schrieb(en) Grant Likely:
> For completeness use: compatible =3D =20
> "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";  Then it will work.

I doesn't.  I had to add "fsl,lpb", without no localbus nodes show up.  =20
The file arch/powerpc/platforms/52xx/mpc52xx_common.c lists only =20
"fsl,lpb"  as "compatible".  Or did I miss something here?

> If this is on CS3, then reg should be:
>                reg =3D <3 0x0 0x100>;            // 256 Bytes, 32 used

Ouch.  Sorry, that was the error.  Works perfectly now...

Thanks a lot for your help,
Albrecht.

--=-7BMs2DyjpFCNq7gi4CLL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBJ90MOn/9unNAn/9ERAp5vAKC45bnaBRr2OGnzj7hxHy2NgRMEqACdGAcp
N0cpIFBQpxkRf4HO4Cb98FM=
=+0d7
-----END PGP SIGNATURE-----

--=-7BMs2DyjpFCNq7gi4CLL--
