Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2EA05DE06B
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:35:17 +1000 (EST)
Date: Sun, 24 May 2009 22:35:07 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2 5/9] Main rewite of the mpc5200 audio DMA code
Message-ID: <20090524203507.GA13491@pengutronix.de>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231305.17919.12239.stgit@terra>
	<20090524185509.GA3561@pengutronix.de>
	<9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2009 at 04:10:52PM -0400, Jon Smirl wrote:
> On Sun, May 24, 2009 at 2:55 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> >> Rewrite the mpc5200 audio DMA code to support both I2S and AC97. Make =
it more robust.
> >
> > Why is it more robust?
>=20
> I've implemented retries for when the AC97 hardware doesn't reset on
> first try. About 10% of the time both the Efika and pcm030 AC97 codecs
> don't reset on first try and need to be poked multiple times.  Failure
> is indicated by not having the link clock start ticking. Every once in
> a while even five pokes won't get the link started and I have to power
> cycle.
>=20
> I don't have an oscilloscope, after I get these basic drivers in maybe
> someone can put a scope on this and figure out why reset is failing.
> I've read the various datasheets and I believe my reset pulses have
> the correct timings.

That's good to know. In fact, I think a summary of this should go into the
patch description.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoZr3sACgkQD27XaX1/VRthugCgyMk6m3VXlus5di2EBlMApObO
y1QAn1fvipzt6UkqglM5xC1JMll/iGbV
=7EUQ
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
