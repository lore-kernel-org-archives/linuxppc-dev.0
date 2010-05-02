Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id DE82DB6EEB
	for <linuxppc-dev@ozlabs.org>; Sun,  2 May 2010 21:24:46 +1000 (EST)
Date: Sun, 02 May 2010 13:24:34 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: mpc512x uart: testers wanted
To: "Likely, Grant" <grant.likely@secretlab.ca>
In-Reply-To: <1272392908.6504.0@antares> (from albrecht.dress@arcor.de on
	Tue Apr 27 20:28:20 2010)
Message-Id: <1272799482.4130.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-MfLanuQDXAu+ID3dZeM7"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-MfLanuQDXAu+ID3dZeM7
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant:

Am 27.04.10 20:28 schrieb(en) Albrecht Dre=DF:
>> MPC5121e Hardware Design Guide provides correct info according to my tes=
ts using /16 and /10 prescaler. I've send a new patch with the fixed commen=
ts, unfortunately forgot to mark it as v4, but it is threaded to your v.3a =
patch and contains a small changelog, so I hope it is not a problem.
>=20
> Grant?  Is this fine for you, or should I "officially" re-send it?

*ping*

IMHO, this issue can be closed now, as the correct uart operation has been =
verified on both the 512x (Anatolij) and 5200 (me) processors.  Do you acce=
pt Anatolij's "joint patch" he sent on Apr 26, or is that procedure too con=
fusing?  And do we need further Acked-by's?

Cheers, Albrecht.

--=-MfLanuQDXAu+ID3dZeM7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBL3WD6n/9unNAn/9ERApAhAJoCqM5awNs1DBFZ6q5zSX1wh8/pQwCdHZHW
LTV96i+uu3GCuyHs5+MWNp0=
=tB7a
-----END PGP SIGNATURE-----

--=-MfLanuQDXAu+ID3dZeM7--
