Return-Path: <silvio.fricke@googlemail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 7F0C6DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 00:53:12 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so2351454fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 05:53:10 -0800 (PST)
Date: Tue, 15 Jan 2008 14:53:06 +0100
To: linuxppc-dev@ozlabs.org
Subject: psc and spi
Message-ID: <20080115135306.GE14333@sfrouter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
From: "S. Fricke" <silvio.fricke@googlemail.com>
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello friends,

I have on the psc3 the spi-interface of a fpga connected.

   psc3-0 - MOSI
   psc3-1 - MISO
   psc3-2 - CLK
   psc3-3 - SlaveSelect
   psc3-4 - CS-FPGA
   psc3-5 - CS Another device
   psc3-6 - SPI-SEL0
   psc3-7 - SPI-SEL1
   psc3-8/9 - Not connected

Can I use the mpc52xx_psc_spi-driver? And if yes, how I have to use this
driver?  Or must I write a own spi-master/slave thing? Can anyone point me
to a good start-position?

Best regards,
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung
----------------------------------------------------------------------------


--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkeMusIACgkQ8WEBxatmn41MtgCfX5MhZUpbrlh4oxo8IMKEUma3
BVYAn1H/HoGx6+dn0+YBbKVnXTYVJU7Q
=bhH1
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
