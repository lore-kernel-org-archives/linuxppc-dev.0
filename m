Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B19F6DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 00:33:54 +1100 (EST)
Date: Tue, 14 Oct 2008 15:33:46 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull 'next' branch of
	git://git.secretlab.ca/git/linux-2.6-mpc52xx
Message-ID: <20081014133346.GE23594@pengutronix.de>
References: <fa686aa40810090102wcc8acf0i4577f195ca40eac6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
In-Reply-To: <fa686aa40810090102wcc8acf0i4577f195ca40eac6@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Grant,

On Thu, Oct 09, 2008 at 02:02:41AM -0600, Grant Likely wrote:

> Wolfram Sang (1):
>       powerpc/mpc5200: trivial printk-fixes in mpc52xx_common

Thanks.

What about these? :)

http://oldpatchwork.ozlabs.org/linuxppc-embedded/patch?id=3D20188
(remove obsolete code from mpc52xx_phy)

http://oldpatchwork.ozlabs.org/linuxppc-embedded/patch?id=3D20189
(simplify read/write in mpc52xx_phy)

We use them for some time now and there are no bad side-effects.

And to which tree did this one go? I couldn't find it on
git.secretlab.ca.

http://oldpatchwork.ozlabs.org/linuxppc-embedded/patch?id=3D20202
(don't touch pipelining)

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj0n7kACgkQD27XaX1/VRuKzQCgyx6uuSDkLABnhawFJzSE1YtN
9hQAnA3kO4Ltqud3G9aDPmXMnWkRIVwv
=keYr
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
