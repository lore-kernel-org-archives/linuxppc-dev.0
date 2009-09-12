Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 37E3DB7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 22:43:12 +1000 (EST)
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id CE2D4DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 22:43:11 +1000 (EST)
Received: from antares (xdsl-87-79-59-130.netcologne.de [87.79.59.130])
	by smtp5.netcologne.de (Postfix) with ESMTP id 67BD940D11A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 14:36:29 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 368F2BA03C
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 14:36:29 +0200 (CEST)
Date: Sat, 12 Sep 2009 14:36:21 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: MPC5200/BestComm functions question
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1252758988.3310.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-poBCW3CvwUuhdH1QzsMi"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-poBCW3CvwUuhdH1QzsMi
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have a MPC5200B based system with a 16-bit peripheral attached to the =20
Local Bus, and I am looking into possibilities to use BestComm for the =20
data transfer.

I found Grant Likely's cool 'mpc5200-localplus-test.c' driver which =20
demonstrates this using the 'gen_bd' driver, and which is apparently a =20
great starting point.

However, I also have to (a) 32-bit endianess-swap the data and (b) =20
calculate a 32-bit crc on it.  Of course, this is possible with the =20
buffers using the cpu, but I saw some remarks that the Bestcomm engine =20
also includes functions which can perform swapping and crc =20
calculation.  I believe it would unload the cpu if the BestComm engine =20
could perform these tasks, but I cannot find a good =20
documentation/example for that.  Does anyone know any pointers for =20
that?  Or maybe even a tool to create the bestcomm tasks from a =20
'readable' source?

Thanks in advance,
Albrecht.

--=-poBCW3CvwUuhdH1QzsMi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKq5XMn/9unNAn/9ERAj9pAJ4iwHRp5dD0QS3l7grcRFqTGtN1GACbBhAT
l9yepc+USFnxBd8BQ5J3nyM=
=AgUu
-----END PGP SIGNATURE-----

--=-poBCW3CvwUuhdH1QzsMi--
