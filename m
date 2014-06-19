Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B87C11A0354
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 18:51:09 +1000 (EST)
Message-ID: <53A29F44.3020806@pengutronix.de>
Date: Thu, 19 Jun 2014 10:28:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-can@vger.kernel.org, wg@grandegger.com, B07421@freescale.com
Subject: Re: [PATCH 2/2] flexcan: add err interrupt for p1010rdb
References: <1403163973-48239-1-git-send-email-B45475@freescale.com>
 <1403163973-48239-2-git-send-email-B45475@freescale.com>
In-Reply-To: <1403163973-48239-2-git-send-email-B45475@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/19/2014 09:46 AM, Zhao Qiang wrote:
> add err interrupt for p1010rdb into dts.

Please update the flexcan binding documentation, too.

Marc

>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p1010si-post.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc=
/boot/dts/fsl/p1010si-post.dtsi
> index 4313ff6..bcd95ba 100644
> --- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
> @@ -141,13 +141,15 @@
>  	can0: can@1c000 {
>  		compatible =3D "fsl,p1010-flexcan";
>  		reg =3D <0x1c000 0x1000>;
> -		interrupts =3D <48 0x2 0 0>;
> +		interrupts =3D <48 0x2 0 0
> +			      16 0x2 0 0>;
>  	};
> =20
>  	can1: can@1d000 {
>  		compatible =3D "fsl,p1010-flexcan";
>  		reg =3D <0x1d000 0x1000>;
> -		interrupts =3D <61 0x2 0 0>;
> +		interrupts =3D <61 0x2 0 0
> +			      16 0x2 0 0>;
>  	};
> =20
>  	L2: l2-cache-controller@20000 {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOin0QACgkQjTAFq1RaXHMqgACfR61Svvvui3htliIOxNe851uP
GLMAmwTwfBp/ZGP9vTMDX3dblPA1TCz6
=Or2S
-----END PGP SIGNATURE-----

--P6plu1rWV2MRkJ6Q3x3mIGmtEHscfWpQk--
