Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26D2DB71DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 20:24:28 +1000 (EST)
Message-ID: <4E425C50.6030508@pengutronix.de>
Date: Wed, 10 Aug 2011 12:24:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v10 0/5] [flexcan/powerpc] Add support for powerpc flexcan
	(freescale p1010)
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<4E425716.4010104@pengutronix.de> <20110810101113.GN4926@sgi.com>
In-Reply-To: <20110810101113.GN4926@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF2531F8679515AE9C064267"
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF2531F8679515AE9C064267
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/10/2011 12:11 PM, Robin Holt wrote:
> On Wed, Aug 10, 2011 at 12:01:58PM +0200, Marc Kleine-Budde wrote:
>> On 08/10/2011 05:05 AM, Robin Holt wrote:
>>> With all the patches applied, my p1010rdb works for communicating bet=
ween
>>> its two can ports and also can communicate with an external PSOC.  I =
have
>>> done no testing beyond compile testing on an arm system as I have no
>>> access to an arm based system.
>>>
>>> For the first three patches in the series, I believe they are all rea=
dy
>>> for forwarding to David S. Miller for the netdev tree.  I think patch=

>>> 4 is ready for submission to the PPC85xx maintainer.  Patch 5 changed=

>>> from the previous post by adding a second compatible string for the
>>> fsl,p1010_flexcan.
>>
>> One remark for the subjects. It seems no one is using "[$subsystem]"
>> anymore, but rather "$subsystem:".
>=20
> I will, one day, get these patches subject lines correct ;)
>=20
> Did you happen to get a chance to test the patches on arm?

It's still compiling...

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBF2531F8679515AE9C064267
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5CXFMACgkQjTAFq1RaXHM5CACghJ/nPTGxcIDc/+Pa52zDjVFD
K8AAnA7LJJXdI46isS1qU+RaiSMACBxV
=wXYH
-----END PGP SIGNATURE-----

--------------enigBF2531F8679515AE9C064267--
