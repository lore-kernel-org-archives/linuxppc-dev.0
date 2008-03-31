Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id B99ECDE2F5
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:48:48 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv3 0/4] cpm2: Reset the CPM at startup and fix the cpm_uart
	driver accordingly.
MIME-Version: 1.0
Date: Mon, 31 Mar 2008 18:34:36 +0200
Content-Type: multipart/signed; boundary="nextPart1887746.VXImq0JoiM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803311834.42327.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1887746.VXImq0JoiM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

these 4 patches reset the CPM in cpm2_reset() and fix the cpm_uart driver t=
o=20
initialise SMC ports correctly without relying on any initialisation=20
performed by the boot loader/wrapper. They update the boot wrapper code and
the EP8248E device tree to match the new SMC registers description.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1887746.VXImq0JoiM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8RKi8y9gWxC9vpcRAkP3AKDd9FH9fa9XiVkupLOh0HSPWoZTLQCfQz/D
E5/YpSY69x/qSZewtWs8MUY=
=Lwzz
-----END PGP SIGNATURE-----

--nextPart1887746.VXImq0JoiM--
