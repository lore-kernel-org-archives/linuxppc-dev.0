Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00A201A0919
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 23:33:24 +1000 (AEST)
Date: Thu, 16 Jul 2015 14:32:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-spi@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 kernel@pengutronix.de, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <20150716133259.GI4039@sirena.org.uk>
References: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150714095442.GO11162@sirena.org.uk>
 <20150715074018.GD1426@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
In-Reply-To: <20150715074018.GD1426@pengutronix.de>
Subject: Re: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2015 at 09:40:19AM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Jul 14, 2015 at 10:54:42AM +0100, Mark Brown wrote:

> > >  static const struct of_device_id mpc512x_psc_spi_of_match[] =3D {
> > > -	{ .compatible =3D "fsl,mpc5121-psc-spi", },
> > > +	{ .compatible =3D "fsl,mpc5121-psc-spi", .data =3D (void *)TYPE_MPC=
5121 },
> > > +	{ .compatible =3D "fsl,mpc5125-psc-spi", .data =3D (void *)TYPE_MPC=
5125 },
> > >  	{},

> > The code seems fine but this should update the binding document to
> > include the new compatible string.

> I don't find fsl,mpc5121-psc-spi documented either. The best I found is
> ocumentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt which
> describes fsl,mpc5121-psc-uart and fsl,mpc5121-psc.

OK, then please add a basic binding document.  The point is that new
bindings should be being documented, if people have been lax on this in
the past that does involve a bit of cleanup.

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp7KKAAoJECTWi3JdVIfQsDMH/iMvzcRjDtq+CnoSEV4F81Gn
jAGVtfP1xIYXNFzslzb6v2GfzgPAso4XXh8zUdtPi52ECTCW8ezXyyOHqhrEngCh
4VmOySSEAXHQbZA4keZ2eztIFC3Akv9IaFbhf8WmzPI6wL8X7IXXwxSvtka/bTjI
h5Exya3UAPz11ZsD6XQsxPnQxQkc1w30z2gFcNCKWgb6MgDnCxvr8BLdLWdjruwj
mKUDiu2idvj3qOE3EdTTRQiCArxZzrST8c2aLoH2s+kAqUz2Hh71y4sDwgmEU6BZ
PsW39Lg8XByY7TKT5igVEPKcayO+QAZ/aGZBt0xJ86R4XTBgJ/Kbrsgbi+Paffg=
=Jxih
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--
