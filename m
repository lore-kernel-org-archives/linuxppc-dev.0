Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id DAE27B7BF9
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 09:28:36 +1100 (EST)
Received: from [2001:6f8:1178:2:221:70ff:fe71:1890] (helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>) id 1N3AMu-0002ks-NK
	for linuxppc-dev@ozlabs.org; Wed, 28 Oct 2009 16:23:24 +0100
Date: Wed, 28 Oct 2009 16:23:24 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: SPRN_SVR for MPC5121e?
Message-ID: <20091028152324.GC3920@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hiya,

my MPC5121e (Rev2) has PVR/SVR: 0x8086_2010/0x8018_0020 (as mentioned in th=
e manual)

I would assume that Rev1 has something like 0x8018_0010 for SVR. Seeing this
code in the Denx NFC-driver seconds that:

+	rev =3D (mfspr(SPRN_SVR) >> 4) & 0xF;
+	if (rev !=3D 2) {
+		printk(KERN_ERR DRV_NAME
+				": SoC revision %u is not supported!\n", rev);
+		return -ENXIO;
+	}

Does someone here have a Rev1 and can ultimately confirm and/or supply the
complete PVR/SVR for Rev1? Couldn't find any hint neither in the manual nor=
 in
the web.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkroYewACgkQD27XaX1/VRvgKwCfdNPXnAQ/5657kuY7vpnMeLkp
RkIAn0Qos1bE8ngB4MSW2dttmcuuoE9u
=vy5O
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
