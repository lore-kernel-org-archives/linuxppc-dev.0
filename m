Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id B79BCDDF73
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 22:17:50 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv2 0/3] cpm2: Reset the CPM at startup and fix the cpm_uart
	driver accordingly.
Date: Wed, 26 Mar 2008 12:17:42 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart54846979.kW0sm6Qr3Z";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803261217.46671.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart54846979.kW0sm6Qr3Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

these 3 patches reset the CPM in cpm2_reset() and fix the cpm_uart driver t=
o=20
initialise SMC ports correctly without relying on any initialisation=20
performed by the boot loader/wrapper. They update the EP8248E device tree t=
o=20
match the new SMC registers description.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart54846979.kW0sm6Qr3Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6jDa8y9gWxC9vpcRAtAdAJ45g9RCtFj6/Sz3OWQrnrbdYxhvSACgmAKH
SHOw6xCmL4o0JNiUGyOKFHk=
=6Xjb
-----END PGP SIGNATURE-----

--nextPart54846979.kW0sm6Qr3Z--
