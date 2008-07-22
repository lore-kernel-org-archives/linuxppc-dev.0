Return-Path: <albrecht.dress@arcor.de>
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id C3EBBDEA74
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 05:18:49 +1000 (EST)
Received: from antares (xdsl-87-79-216-93.netcologne.de [87.79.216.93])
	by smtp3.netcologne.de (Postfix) with ESMTP id 2F29E6793F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 20:56:52 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 02E79BA06C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 20:56:51 +0200 (CEST)
Date: Tue, 22 Jul 2008 20:56:43 +0200
From: =?UTF-8?q?Albrecht_Dre=C3=9F?= <albrecht.dress@arcor.de>
Subject: [OT] write flash on MPC5200 board via jtag
To: LinuxPPC Embedded <linuxppc-embedded@ozlabs.org>
Message-Id: <1216753011l.5683l.0l@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-n+M+oDLiGUzN7wiJ1Gt1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=-n+M+oDLiGUzN7wiJ1Gt1
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

sorry for a somewhat off-topic question...

I want to design a mpc5200b board which is roughly derived from =20
Freescale's 5200B Lite demo.  Obviously, I have the problem to =20
initially write u-boot into the boot nor flash.  I believe this would =20
be possible using the jtag/bsm interface (is that true?).

Can you recommend any good hardware and software solution for that, if =20
possible running on linux (OSS?)?  I don't need a "real" debugger =20
(maybe an interface to gdb), just something to write the flash, so =20
u-boot comes up.

Thanks for any help,
Albrecht.

--=-n+M+oDLiGUzN7wiJ1Gt1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBIhi1yn/9unNAn/9ERAuEsAJ0ehKSJUwhuWOY838x/rU5ABzmMDQCePDld
aLn905Y9HTPg6JPtz5mDIws=
=Xz8D
-----END PGP SIGNATURE-----

--=-n+M+oDLiGUzN7wiJ1Gt1--
