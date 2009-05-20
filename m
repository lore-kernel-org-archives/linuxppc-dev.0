Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id D2F63DE10A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 17:11:39 +1000 (EST)
Date: Wed, 20 May 2009 09:11:33 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] powerpc/5200: beyond ARRAY_SIZE of
	mpc52xx_uart_{ports, nodes}
Message-ID: <20090520071133.GB29102@pengutronix.de>
References: <4A134EC4.3000805@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
In-Reply-To: <4A134EC4.3000805@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2009 at 02:28:52AM +0200, Roel Kluin wrote:
> Do not go beyond ARRAY_SIZE of mpc52xx_uart_{ports,nodes}
>=20
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 7f72f8c..b3feb61 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -988,7 +988,7 @@ mpc52xx_console_setup(struct console *co, char *optio=
ns)
>  	pr_debug("mpc52xx_console_setup co=3D%p, co->index=3D%i, options=3D%s\n=
",
>  		 co, co->index, options);
> =20
> -	if ((co->index < 0) || (co->index > MPC52xx_PSC_MAXNUM)) {
> +	if ((co->index < 0) || (co->index >=3D MPC52xx_PSC_MAXNUM)) {
>  		pr_debug("PSC%x out of range\n", co->index);
>  		return -EINVAL;
>  	}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoTrSUACgkQD27XaX1/VRtQxQCfRH0kYDRR9TAhJyPparf6nGS+
OMQAnRAw9vUosGmVey6Bn7ggIxCrj30b
=Y5yD
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
