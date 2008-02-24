Return-Path: <albrecht.dress@arcor.de>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.112])
	by ozlabs.org (Postfix) with ESMTP id 53013DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Feb 2008 21:37:11 +1100 (EST)
Received: from antares.localdomain (xdsl-87-78-201-228.netcologne.de
	[87.78.201.228])
	by smtp2.netcologne.de (Postfix) with ESMTP id 830844F96
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Feb 2008 11:17:40 +0100 (MET)
Received: from antares.localdomain (localhost.localdomain [127.0.0.1])
	by antares.localdomain (Postfix) with ESMTP id 2140532F502
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Feb 2008 11:17:39 +0100 (CET)
Date: Sun, 24 Feb 2008 11:17:39 +0100
From: =?UTF-8?q?Albrecht_Dre=C3=9F?= <albrecht.dress@arcor.de>
Subject: Status of 5200B and 440 Kernel Support
To: LinuxPPC Embedded <linuxppc-embedded@ozlabs.org>
Message-Id: <1203848259l.2313l.1l@antares.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-RCvV/1GqzE0wN8zdlzcs"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=-RCvV/1GqzE0wN8zdlzcs
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

sorry if this is a dumb question, I'm new in the list...

For a new project, I am looking through the available PPC based SoC's.  =20
Good candidates are probably the Freescale 5200B or the AMCC 440EP (I =20
need a FPU).

For a decision, I need some further information about the Kernel =20
support (source code available, if possible in stock kernels, *not* =20
only vendor binary modules!) of the included devices, in particular
- MTD/NAND controller
- Ethernet
- UART, IIC and SPI
- USB host
- local external bus (not PCI) DMA

Any information or pointers would be really appreciated!

Thanks in advance,
Albrecht.

--=-RCvV/1GqzE0wN8zdlzcs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iD8DBQBHwURDn/9unNAn/9ERAm5cAKCTUZwS+ZMR26b3kqsyvJtfQjzBoACgv7XH
BJCvxkbQwLgD5KxkAshxJsk=
=QmPw
-----END PGP SIGNATURE-----

--=-RCvV/1GqzE0wN8zdlzcs--
