Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 83FBDB7CCD
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 03:15:32 +1100 (EST)
Received: from antares (xdsl-89-0-133-48.netcologne.de [89.0.133.48])
	by smtp6.netcologne.de (Postfix) with ESMTP id 769902A0B61
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Mar 2010 17:15:30 +0100 (CET)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 0C13ABA03E
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Mar 2010 17:15:30 +0100 (CET)
Date: Sun, 07 Mar 2010 17:15:21 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: mpc512x uart: testers wanted
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1267978529.2306.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-qyyQ4bzHLTNOOn8Mpqeg"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-qyyQ4bzHLTNOOn8Mpqeg
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I recently posted a patch which improves the baud rate calculation on the m=
pc5200b.  Following requests by Grant and Wolfram, I added changes which do=
 also affect the mpc512x.

Unfortunately, I don't have access to such a system, but IMHO the code (bot=
h the old implementation and my changes) contradict the data sheet.  Thus, =
it would be really helpful if you give give the code a try and report your =
experiences:

<http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/080815.html>

Thanks in advance,
Albrecht.

--=-qyyQ4bzHLTNOOn8Mpqeg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLk9Ehn/9unNAn/9ERAtc3AJ9lk7DSko33MryTSBMC/ZtgBxs+BwCggkTf
4LeXR/UXruB9GZ16wN56b3A=
=4jap
-----END PGP SIGNATURE-----

--=-qyyQ4bzHLTNOOn8Mpqeg--
