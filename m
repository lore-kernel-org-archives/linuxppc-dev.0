Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4987D1007D2
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2010 23:42:57 +1100 (EST)
Date: Sat, 20 Nov 2010 13:42:26 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Stijn Devriendt <HIGHGuY@gmail.com>
Subject: Re: [PATCH 1/3] misc: at24: parse OF-data, too
Message-ID: <20101120124226.GB11936@pengutronix.de>
References: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
	<1289995250-17927-2-git-send-email-w.sang@pengutronix.de>
	<5F1D4949966C4C509360407B0F948EFE@HIGHGuY>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
In-Reply-To: <5F1D4949966C4C509360407B0F948EFE@HIGHGuY>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> As far as I could tell, using compatible =3D <24c64>; didn't load the rig=
ht
> module (module name is at24) and using at24 caused a device id mismatch
> because at24 is not a known device ID. I could be wrong here and if so, I=
'd
> very  much like a source code hint as to why...

Have you tried "<vendor>, 24c64"? All I can say is that it works for me. Pl=
ain
at24 worked for years with pcm030.dts and pcm032.dts, so I don't know which
issue you are facing. This patch is just about extending the support.

> My patch worked by changing drivers/of/of_i2c.c to allow a generic
> kind =3D " " statement that was filled in as i2c_board_info.type, to allow
> the module name and the device id to be different.
> This makes the at24 driver no longer rely on probing (which it claims
> is buggy anyway) and also benefits other drivers that support multiple
> devices, but where probing is difficult (e.g. lm90 driver).
>
> I'm in the process of getting employer approval to get these patches =20
> upstream.

I hope you will get it approved, it is a lot easier to talk about code :)

Best regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkznwjIACgkQD27XaX1/VRssnwCgg55UCwZFLcMI8kJI3mhCJQxL
N7kAoJHpLn5BJpNjET+ngaQFrGxUBQm1
=tyTb
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
