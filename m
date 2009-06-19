Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E120BB7249
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 03:51:35 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 48835DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 03:51:34 +1000 (EST)
Date: Fri, 19 Jun 2009 19:51:05 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Lorenz Kolb <lorenz@missinglinkelectronics.com>
Subject: Re: Problem with memcpy on ppc8536
Message-ID: <20090619175105.GA16015@pengutronix.de>
References: <71DEA556544D7A4F9C6848402D8184340C4A13__24467.8549039692$1245370891$gmane$org@usi01.ultsol.local>
	<4A3BC58A.7050408@missinglinkelectronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
In-Reply-To: <4A3BC58A.7050408@missinglinkelectronics.com>
Cc: linuxppc-dev@ozlabs.org, Fahd Abidi <fabidi@ultsol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2009 at 07:06:18PM +0200, Lorenz Kolb wrote:

> Could you please try the following patch, I am quite sure that checking =
=20
> for > 4 was accidentially done within io.c instead of >=3D 4 as if it's 4=
 =20
> we still can copy a 32-bit word. Some hardware might not be happy about =
=20
> 8-bit accesses...

There seems to be desire for this fix:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-May/072582.html

If it works here, too, then you could maybe also ack it?

BTW, I can't find the original patch in patchwork, maybe the patch was miss=
ed
because of that?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko70AkACgkQD27XaX1/VRuHmACgo1pRdxxR+l8OC2qvVg9gNcPh
rz0An3A/EIDx9bC7oXm+19D1A4STzVKK
=sEUy
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
