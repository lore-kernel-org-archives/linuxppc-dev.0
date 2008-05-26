Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 008F8DDFB9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 19:54:29 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: [PATCH 0/2] MDIO on GPIO support for the fs_enet driver
Date: Mon, 26 May 2008 11:52:37 +0200
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Message-Id: <200805261152.37636.laurentp@cse-semaphore.com>
Content-Type: multipart/signed; boundary="nextPart1692576.rq6FsTAGDv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Scott Wood <scottwood@freescale.com>, netdev@vger.kernel.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1692576.rq6FsTAGDv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

here is a patch set that adds MDIO on GPIO support. If there are no show=20
stoppers I'd like to see it going into linux-next.

[PATCH 1/2] net: OpenFirmware GPIO based MDIO bitbang driver
[PATCH 2/2] fs_enet: MDIO on GPIO support

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1692576.rq6FsTAGDv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIOohl8y9gWxC9vpcRAskXAJ0SmI1nAQ7wCwf3mKAN+b+NHvcKlQCfWhfW
xdI59JszkvrWure4zGFXzTY=
=OfZ+
-----END PGP SIGNATURE-----

--nextPart1692576.rq6FsTAGDv--
