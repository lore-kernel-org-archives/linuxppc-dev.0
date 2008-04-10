Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 8ABFFDE4F2
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:46:35 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: paulus@samba.org
Subject: Re: Patches added to powerpc.git powerpc-next and master branches
Date: Thu, 10 Apr 2008 13:46:29 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6429418.AviR1SZOQ7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804101346.32376.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6429418.AviR1SZOQ7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

could you please add the following patches ?

[PATCHv4 1/5] cpm_uart: Allocate DPRAM memory for SMC ports on CPM2-based=20
platforms.
http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053858.html

[PATCHv4 2/5] powerpc: Add bootwrapper function to get virtual reg from the=
=20
device tree.
http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053859.html

[PATCHv4 3/5] cpm-serial: Relocate CPM buffer descriptors and SMC parameter=
=20
ram.
http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053860.html

[PATCHv4 4/5] ep8248e: Reference SMC parameter RAM base in the device tree.
http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053862.html

[PATCHv4 5/5] cpm2: Reset the CPM when early debugging is not enabled.
http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053861.html

Thanks.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart6429418.AviR1SZOQ7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH/f4Y8y9gWxC9vpcRAlarAJ9JdA9+219+GIXgStXUCY2agZXHOACgjUm3
dpJMbpyAyosF75ySYRcET+w=
=kvBC
-----END PGP SIGNATURE-----

--nextPart6429418.AviR1SZOQ7--
