Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 344561A1DEE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:55:01 +1000 (AEST)
Date: Tue, 14 Jul 2015 10:54:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org,
 kernel@pengutronix.de
Message-ID: <20150714095442.GO11162@sirena.org.uk>
References: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NRJnUXaAQEpDRr3z"
In-Reply-To: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NRJnUXaAQEpDRr3z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2015 at 11:19:56AM +0200, Uwe Kleine-K=F6nig wrote:

>  static const struct of_device_id mpc512x_psc_spi_of_match[] =3D {
> -	{ .compatible =3D "fsl,mpc5121-psc-spi", },
> +	{ .compatible =3D "fsl,mpc5121-psc-spi", .data =3D (void *)TYPE_MPC5121=
 },
> +	{ .compatible =3D "fsl,mpc5125-psc-spi", .data =3D (void *)TYPE_MPC5125=
 },
>  	{},

The code seems fine but this should update the binding document to
include the new compatible string.

--NRJnUXaAQEpDRr3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpNxhAAoJECTWi3JdVIfQQ+oH/0seBIzXzOt9A+Sap/VyF8pm
vqXxrsMwBRoqmTuT+VOu4+WvPI2bQ6ZlmecEyZf4yLWwPfBe/4g3H6mR2Vok2sGQ
wvvBk9M9VkLlAURjG8AWQ+xERvN1JKMzzHwNmYdVuoLkE7PfMeAQTXpyVQrBjxAZ
TTeKiiGH2jVoX37LucUTNVTltkX4kUJ5Cfuq/yRF7AgPtPE5HX3mdaA248VdXL0N
RfvQSHKV9PYMiRXIZcKEXnAtbcfvjWVQqsnEaiHEIveGGOeMCHiGebij8SXM+YRP
l8G8KXxCLBv7UC8EC4BfnEXPDu9EfbMZtGIhksAhOHHFKEm+KVeUlkTWZUp/sgA=
=S+rD
-----END PGP SIGNATURE-----

--NRJnUXaAQEpDRr3z--
