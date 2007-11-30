Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay001.isp.belgacom.be (mailrelay001.isp.belgacom.be
	[195.238.6.51]) by ozlabs.org (Postfix) with ESMTP id CE0B1DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 21:45:57 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: CPM2 USB host driver
Date: Fri, 30 Nov 2007 11:45:49 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4116126.aMC6kO4Efn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711301145.52926.laurentp@cse-semaphore.com>
Cc: mike@compulab.co.il
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4116126.aMC6kO4Efn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

Linux USB host support for the CPM, CPM2 and CPM2 pro is far from complete.=
=20
Many people showed interest on this list (and on linuxppc-embedded) in the=
=20
past, but nobody managed to complete a driver and get it merged.

As I need USB host support on my MPC8248 (CPM2), I decided to scratch the i=
tch=20
and try to get a working driver that could be merged upstream. This mail=20
describes my plans to make sure the code I write will be useful for other=20
people.

The driver will be based on the cpm2usb project (http://cpm2usb.sf.net/). A=
s I=20
don't own any CPM1-based platform, I will convert the driver to use the CPM=
2=20
transaction-level interface, thus making it incompatible with the CPM1. CPM=
1=20
support could be added back later. There is no planned release date, and mo=
re=20
urgent projects could put this development on hold.

Comments are welcome (and contributions too, especially in the form of a=20
working driver :-)).

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4116126.aMC6kO4Efn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHT+ng8y9gWxC9vpcRAuUQAKCA0B4qEFsNmyZtExWvDi6qSz9rlwCgpVIb
Zn/EX2S9gZ4Cp3BbdMrOu3k=
=qkrM
-----END PGP SIGNATURE-----

--nextPart4116126.aMC6kO4Efn--
