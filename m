Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2AB4BDE0DC
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 22:27:21 +1000 (EST)
Date: Tue, 19 May 2009 14:27:14 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: Q: MTD RAM in OF Device Tree
Message-ID: <20090519122714.GH30753@pengutronix.de>
References: <5023288.1242734340173.JavaMail.ngmail@webmail15.arcor-online.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
In-Reply-To: <5023288.1242734340173.JavaMail.ngmail@webmail15.arcor-online.net>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Albrecht,

(adding linux-mtd)

On Tue, May 19, 2009 at 01:59:00PM +0200, Albrecht Dre=DF wrote:
>=20
> is there a standard way to define a ram chip (in my case a battery-buffer=
ed
> nv ram, attached to the 5200's Local Bus) in the OF tree, and are there a=
ny
> drivers (on 2.6.29.1) which pick up the chip/partition specification for =
mtd?
> Does such a driver exist, or do I have to write one (probably based on
> plat-ram.c?)?  I think of something like

I wrote such a driver (yet without partitioning support) and I am trying to=
 get
it mainline, just didn't get any comments so far:

http://patchwork.ozlabs.org/patch/23557/
http://patchwork.ozlabs.org/patch/23556/

I'd be happy if you could give it a try and donate some
{Acked|Tested|Reviewed}-by tags. Maybe this will help for my next try to get
it mainline.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoSpaIACgkQD27XaX1/VRtheACgtR/d4gJ8/exbMEJ0NLDrgxFs
vmQAn36txBFqTh6Ws+IJsc6lIerssUpj
=Myq9
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--
