Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78A73B7CC1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 22:01:31 +1100 (EST)
Date: Wed, 20 Jan 2010 12:01:24 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 05/11] rtc: Add MPC5121 Real time clock driver
Message-ID: <20100120110124.GC5041@pengutronix.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-6-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
In-Reply-To: <1263932653-3634-6-git-send-email-agust@denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, dzu@denx.de, rtc-linux@googlegroups.com,
	linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2010 at 09:24:07PM +0100, Anatolij Gustschin wrote:
> From: John Rigby <jrigby@freescale.com>
>=20
> Based on Domen Puncer's rtc driver for 5200 posted to
> the ppclinux mailing list:
>         http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=3D11675
> but never commited anywhere.
>=20
> Changes to Domen's original:
>=20
>     Changed filenames/routine names from mpc5200* to mpc5121*
>     Changed match to only care about compatible and use "fsl,"
>     convention for compatible.
>=20
>     Make alarms more sane by dealing with lack of second alarm resolution.
>=20
>     Deal with the fact that most of the 5121 rtc registers are not persis=
tent
>     across a reset even with a battery attached:
>=20
>         Use actual_time register for time keeping
>         and target_time register as an offset to linux time
>=20
>         The target_time register would normally be used for hibernation
>         but hibernation does not work on current silicon

Last time, we discussed if it makes sense to rename it to mpc5xxx, as the r=
tc
is quite similar to the mpc5200 one. I then checked and parts of the
differences include that it is not possible on a 5200 to use the tricks to =
keep
the RTC persistent across resets. Thus, I think the patch is okay with not
supporting the 5200. Its rtc seems pretty useless.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktW4oQACgkQD27XaX1/VRv29QCfST7nnnZlCpXhdpdkSjj663dY
nTQAn3caGXy+1viulhBeKV3a85+NccgA
=4uds
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
