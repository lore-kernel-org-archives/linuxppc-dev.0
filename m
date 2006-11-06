Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 1306867C71
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 20:13:49 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 1311521461
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 10:13:44 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add MPC52xx PIO/ATA support for arch/powerpc
References: <20061105105325.44e7287f.nd@bplan-gmbh.de>
In-Reply-To: <20061105105325.44e7287f.nd@bplan-gmbh.de>
MIME-Version: 1.0
Message-ID: <200611061013.43676.roman.fietze@telemotive.de>
Date: Mon, 6 Nov 2006 10:13:40 +0100
Content-Type: multipart/signed; boundary="nextPart1243200.m1go60MI1o";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1243200.m1go60MI1o
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hallo,

On Sunday 05 November 2006 12:57, Nicolas DET wrote:

> This patch adds ATA/PIO support for Freescale MPC5200 plaforms.

Assumed I've got a preliminary version of an MPC5200 ATA driver with
BestComm ATA support (besides a FEC driver with DMA support as well)
mainly based on code from Sylvain Munaut, Dale Farnsworth and John
Rigby.

Would you recommend posting those patches here? They are working on
our platform, any comment would be appreciated.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--nextPart1243200.m1go60MI1o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFTvzHp5XY/BK//MIRAvenAJ4t+gYRUmIlWrrSWCekg1shxlDysQCdE7GL
RP93IIeo+qsS7Qw8BCB0vJA=
=qrxh
-----END PGP SIGNATURE-----

--nextPart1243200.m1go60MI1o--
