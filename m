Return-Path: <riesebie@lxtec.de>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtpout.hostsharing.net",
	Issuer "Hostsharing eG Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 089BEDDE2E
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 21:50:15 +1000 (EST)
Date: Sun, 20 May 2007 13:30:14 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: benh@kernel.crashing.org
Subject: 2.6.22-rc2 built on ppc
Message-ID: <20070520113014.GN3253@aragorn.home.lxtec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

FYI, building the kernel modules with
gcc (GCC) 4.1.3 20070514 (prerelease) (Debian 4.1.2-7)
on my powerbook (PPC) gives:

=2E..
drivers/macintosh/therm_adt746x.c: In function 'thermostat_init':
drivers//therm_adt746x.c:617: warning: ignoring return value of 'device_cre=
ate_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:618: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:619: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:620: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:621: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:622: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:623: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:624: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:625: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_adt746x.c:627: warning: ignoring return value of 'd=
evice_create_file', declared with attribute warn_unused_result
=2E..

If more info is needed, please contact me via PM, as I am not
subscribed.

Thanks for your patience
Elimar

--=20
  Never make anything simple and efficient when a way=20
  can be found to make it complex and wonderful ;-)

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUDFG3Ig8bsVPf7ARAo4nAJ9tluYCQ93/7ltSNrUs1CG9alCXPwCglsYW
Frub8ufWaToFf6rsGWyiN0g=
=n+7E
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--
