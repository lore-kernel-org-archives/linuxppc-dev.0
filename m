Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 97969DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 23:38:07 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv4 0/5] cpm2: Reset the CPM at startup and fix the cpm_uart
	driver accordingly.
MIME-Version: 1.0
Date: Tue, 1 Apr 2008 14:33:23 +0200
Content-Type: multipart/signed; boundary="nextPart7232643.Kbsr3ZBWrv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804011433.29841.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart7232643.Kbsr3ZBWrv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

these 5 patches reset the CPM in cpm2_reset() and fix the cpm_uart driver t=
o=20
initialise SMC ports correctly without relying on any initialisation=20
performed by the boot loader/wrapper. They update the boot wrapper code and
the EP8248E device tree to match the new SMC registers description.

Patches 2/5, 3/5 and 4/5 (boot wrapper and EP8248E device tree updates)=20
haven't been tested due to lack of hardware.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart7232643.Kbsr3ZBWrv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8iuZ8y9gWxC9vpcRAhcEAKDWv9XzCpeUnvq+anJn2F5N9H9R8wCfV86L
cDijfWezj3u7uvKKsa2/rVU=
=sEXW
-----END PGP SIGNATURE-----

--nextPart7232643.Kbsr3ZBWrv--
