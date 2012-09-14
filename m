Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1E45F2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2012 00:22:34 +1000 (EST)
Date: Fri, 14 Sep 2012 16:02:34 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
Message-ID: <20120914140234.GH2630@pengutronix.de>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
In-Reply-To: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2012 at 12:40:04PM +0200, Joakim Tjernlund wrote:
> mpc_i2c_stop() only initiates STOP but does not wait for it to
> hit the I2C bus. This is a problem when using I2C devices which
> uses fairly long clock stretching just before STOP if you also
> have an i2c-mux which may switch to another bus before STOP has
> been processed.
>=20
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Patch didn't apply, because it was a p0-patch. Checkpatch would have
warned you.

Fixed that and applied to -next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBTOPoACgkQD27XaX1/VRvYVwCgqsbfnjBfL/VGJVtGxZhkWAPY
1pQAnRbLUcqXArSYnDeQLiRWNs7KQkdl
=5Al6
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--
