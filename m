Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0A405DDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 23:34:26 +1100 (EST)
Date: Sat, 19 Jan 2008 23:34:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 1/2] [POWERPC] mpc5200: normalize compatible
	property bindings
Message-Id: <20080119233417.8d4a5563.sfr@canb.auug.org.au>
In-Reply-To: <20080118170443.10592.97538.stgit@trillian.secretlab.ca>
References: <20080118170324.10592.47360.stgit@trillian.secretlab.ca>
	<20080118170443.10592.97538.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__19_Jan_2008_23_34_17_+1100_CeZ06H+w1dWYXMcP"
Cc: linuxppc-dev@ozlabs.org, jrigby@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__19_Jan_2008_23_34_17_+1100_CeZ06H+w1dWYXMcP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Fri, 18 Jan 2008 10:04:49 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +++ b/arch/powerpc/platforms/52xx/lite5200.c
> @@ -44,9 +44,14 @@ lite5200_fix_clock_config(void)
>  {
>  	struct device_node *np;
>  	struct mpc52xx_cdm  __iomem *cdm;
> +	struct of_device_id cdm_ids[] =3D {

Surely this should be static and __initdata?

> @@ -79,9 +84,14 @@ lite5200_fix_port_config(void)
>  {
>  	struct device_node *np;
>  	struct mpc52xx_gpio __iomem *gpio;
> +	struct of_device_id gpio_ids[] =3D {

And this?

> +++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
> @@ -43,6 +43,12 @@ static int lite5200_pm_set_target(suspend_state_t stat=
e)
>  static int lite5200_pm_prepare(void)
>  {
>  	struct device_node *np;
> +	struct of_device_id immr_ids[] =3D {

This should be static and const.

Similarly for the rest ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__19_Jan_2008_23_34_17_+1100_CeZ06H+w1dWYXMcP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHke5OTgG2atn1QN8RAmi6AJ40CWe2PsfSSKbMFLQWNAyTG/cxMwCeLWXF
DlnmezpCgLw6SSvLKwCZpWU=
=xw62
-----END PGP SIGNATURE-----

--Signature=_Sat__19_Jan_2008_23_34_17_+1100_CeZ06H+w1dWYXMcP--
