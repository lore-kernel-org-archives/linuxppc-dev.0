Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id EB0E4B7C54
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 00:01:40 +1100 (EST)
Date: Sat, 31 Oct 2009 14:01:31 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mpc512x/clock: fix clk_get logic
Message-ID: <20091031130131.GA23009@pengutronix.de>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
	<1256939657.6372.81.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
In-Reply-To: <1256939657.6372.81.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

> Have you considered switching to my proposed device-tree based clock
> reprentation ?

You mean this one?

http://patchwork.ozlabs.org/patch/31551/

Sorry, I have missed it up to now :(

While I think (after one glimpse) this moves things into the right directio=
n,
my priority at the moment is to get the mscan driver working on 512x (and t=
hen
to mainline). For that, I needed the patch I posted. I hope I can have anot=
her
look at your proposal later on, it looks really worth it.

Until then I'd propose to consider this patch as it fixes a bug in clock
assignment. But I leave the final decision to you maintainers, of course.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrsNSsACgkQD27XaX1/VRtTzwCeLyTJ42+b2WDXqLf8ul+n4fLk
RDEAoMf+nmmYFgHVO6FFv2jGn9iLjsUG
=UDFz
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
