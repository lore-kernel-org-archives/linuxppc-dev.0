Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C40D1B7D47
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 17:12:31 +1000 (EST)
Date: Tue, 27 Apr 2010 09:12:22 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RESEND 3/3] i2c/ibm-iic: drop NO_IRQ
Message-ID: <20100427071222.GB22743@pengutronix.de>
References: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
	<1270167421-5205-4-git-send-email-w.sang@pengutronix.de>
	<1272351974.24542.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
In-Reply-To: <1272351974.24542.9.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2010 at 05:06:14PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2010-04-02 at 02:17 +0200, Wolfram Sang wrote:
> > Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> > (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driv=
er is
> > only used on powerpc, where NO_IRQ is 0 anyhow.
>=20
> Oops... forgot those. Applied, will show up in -next soon.

Ah, thanks. I also asked Ben Dooks to pick them up, but better twice than n=
ever
;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvWjlYACgkQD27XaX1/VRvb4gCfac8AEkOcE0nKPmbeprc4Uhg+
g4QAn2MpshayIMtohOk4S1jiT+Z8QS6B
=xJuH
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
