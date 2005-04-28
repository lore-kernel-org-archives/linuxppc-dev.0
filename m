Return-Path: <p2@mind.be>
Received: from nat.office.mind.be. (NAT.office.mind.be [62.166.230.82])
	by ozlabs.org (Postfix) with ESMTP id A821567B1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 19:53:30 +1000 (EST)
Received: from p2 by codecarverwith local (Exim 3.36 #1 (Debian))
	id 1DR5c4-0004i4-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Apr 2005 11:47:16 +0200
Date: Thu, 28 Apr 2005 11:47:16 +0200
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050428094716.GA17582@mind.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
From: Peter 'p2' De Schrijver <p2@mind.be>
Subject: connecting BDI2000 to ML403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to figure out how to connect the BDI 2000 with a Xilinx ML403=20
development board. As far as I can see in the ML403 schematics, the JTAG
connector lacks the nTRST and the HALT signals needed for JTAG
debugging. Any ideas ?

Thanks,

Peter (p2).

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCcLEkKLKVw/RurbsRAsfdAJ0Rh6i/aVhRv4UwxAlg30UUTAMLrwCgiym9
ivJcvMneY3P9GVnVqSXKA+I=
=dRBv
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
