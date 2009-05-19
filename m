Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id BFB60DE11D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 06:57:17 +1000 (EST)
Date: Tue, 19 May 2009 22:57:06 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: mpc5200 fec error
Message-ID: <20090519205706.GD27476@pengutronix.de>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519203645.GW19843@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
In-Reply-To: <20090519203645.GW19843@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2009 at 10:36:45PM +0200, Robert Schwebel wrote:
> Wolfram, have you seen this mail? You recently tested -rt on 2.6.29,
> right? Did you only test that on the customer hardware or also on the
> phyCORE-MPC5200B?

So far, I tried only on customer hardware, and that was 2.6.29.2-rt11. With
that setup, I could work with NFS flawlessly, no real stress-testing though.
Testing latest .3-rt is on my todo, will check the phyCOREs, too.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoTHSIACgkQD27XaX1/VRtwKACgrn09SfYX0rjGkYNOoghjUm21
+aYAoKy/MnBRJzmkzafO8FVMlBGUO4br
=jQcq
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
