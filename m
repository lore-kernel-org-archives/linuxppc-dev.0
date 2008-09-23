Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB6D5DE419
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 00:39:29 +1000 (EST)
Subject: G5 doesn't shut down with current kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-di0o3LTh+GitCikvbesA"
Date: Tue, 23 Sep 2008 16:38:33 +0200
Message-Id: <1222180713.18015.17.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-di0o3LTh+GitCikvbesA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Instead, I get an oops right after trying to disable the non-boot CPUs.

This was on 2.6.27-rc6-wl-01382-g0bea1f7-dirty.

http://johannes.sipsolutions.net/files/dsc_2274.jpg

johannes

--=-di0o3LTh+GitCikvbesA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI2P9mAAoJEKVg1VMiehFYQ5UP+wUry/LabOnXFvtHU7JION53
uOO2bKFXyUTC/3dEp9oODgfd/WiWCisrZ85EWO7GL9frbXK5TIxNz7nq1NU03iGS
H9t3S2abW08KR7koZxT9++7xFY5olcmASUeIVEUzV/8vGdEYhawQ4O+AS5DpFRVw
+txy9Eg00xy8bTzbRujkJ2R1afoeaFJgXnX2GpVFBji32m+3khYjB+pztY+AaqsU
X2bCVZK8Nds1Apq/snmogDfvCh22UgB2Ch9vCWs+e2oXTXSBHW1ptcfOFSJy8Fwq
CB6irxH7JBBwtsVswYeT5uoZUPYBOx7YL0TOEy3Fllc74JuhzEV4MHHlpj2vjF6O
t9cuy9QJQHfo7trWcFpaVp9cLbsHT9L9O5oH7yJBWb49Q+Y0IjprCqlqGEokro3B
5YuiR2fA+O6Z8obGuUukLd0QGRwFyEGsBc2pDCTlEXLpAoOGu/iALl9KI46n5cJs
AIN8A8BlpbTeNRGfdDDAeThpdk5SMep5NT/JNZFFpyEmIV7RojAdeP+rLn2r0zoY
+BKO96VOC4jeI9jmxVfRPdkM1ebdUmmL+UbODMnjpMaSw9FkTUR8KdQCEJj+0UY3
g9OjbAyAwDLWhb+Kz9DG1XpAVmGLxpl/48z9c/cSsd/kwGWnZ1t3vHS8Tg+xJpiA
HF3kerSsj0fgeAyd492P
=iYi0
-----END PGP SIGNATURE-----

--=-di0o3LTh+GitCikvbesA--
