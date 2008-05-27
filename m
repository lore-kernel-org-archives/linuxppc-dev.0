Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 779DBDDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 21:48:09 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Linux I2C <i2c@lm-sensors.org>
Subject: How to set device's platform_data field for OF-described I2C devices ?
Date: Tue, 27 May 2008 13:47:59 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1578720.ZKAOKRFCBV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200805271348.06470.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1578720.ZKAOKRFCBV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm running into a small issue with the pca953x I2C GPIO driver. The driver=
=20
requires platform data (to set the GPIO base number among other information=
).=20
As the device is automatically instantiated from the OF device tree, I can'=
t=20
find a way to add platform data in the process.

What's the best way to specify platform data for OF-described I2C devices ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1578720.ZKAOKRFCBV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIO/T28y9gWxC9vpcRAqTZAKCuNgeopQtdva+DnU6JxckNmT8P/ACg3nUz
YZCp2UZyA0Ab1h+SxMEQ6aA=
=rmXC
-----END PGP SIGNATURE-----

--nextPart1578720.ZKAOKRFCBV--
