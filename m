Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 5959EDE13B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 01:43:51 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org,
 netdev@vger.kernel.org
Subject: [PATCH] fs_enet: Remove unused fields in the fs_mii_bb_platform_info
	structure.
Date: Tue, 22 Jul 2008 17:43:42 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart43458818.Il0IBT7YsP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807221743.47807.laurentp@cse-semaphore.com>
Cc: jgarzik@pobox.com, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart43458818.Il0IBT7YsP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The mdio_port, mdio_bit, mdc_port and mdc_bit fields in the
fs_mii_bb_platform_info structure are left-overs from the move to the Phy
Abstraction Layer subsystem. They are not used anymore and can be safely
removed.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 include/linux/fs_enet_pd.h    |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 9bc045b..decc4b5 100644
=2D-- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -103,10 +103,6 @@ struct fs_mii_bb_platform_info {
 	struct fs_mii_bit 	mdio_dir;
 	struct fs_mii_bit 	mdio_dat;
 	struct fs_mii_bit	mdc_dat;
=2D	int mdio_port;	/* port & bit for MDIO */
=2D	int mdio_bit;
=2D	int mdc_port;	/* port & bit for MDC  */
=2D	int mdc_bit;
 	int delay;	/* delay in us         */
 	int irq[32]; 	/* irqs per phy's */
 };
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart43458818.Il0IBT7YsP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiGADMACgkQ8y9gWxC9vpdugACeMZWMv0IFETZxVd7/xxhR8E7D
wdkAoMsvS0a+lEDni7CL8GZtd6BuII7m
=haH6
-----END PGP SIGNATURE-----

--nextPart43458818.Il0IBT7YsP--
