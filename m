Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0220B7D4A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 05:58:16 +1100 (EST)
Date: Tue, 2 Feb 2010 19:58:12 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] serial/mpc52xx_uart: Drop outdated comments
Message-ID: <20100202185812.GM4757@pengutronix.de>
References: <1262985569-29826-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M2Pxvdb9QxnGd/3e"
In-Reply-To: <1262985569-29826-1-git-send-email-w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--M2Pxvdb9QxnGd/3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2010 at 10:19:29PM +0100, Wolfram Sang wrote:
> Most things mentioned are either obsolete (platform-support) or wrong (de=
vice
> numbering, DCD spport) these days. The remaining rest is obvious.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Ping. Anyone interested in this patch?

> ---
>  drivers/serial/mpc52xx_uart.c |   33 ---------------------------------
>  1 files changed, 0 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 7ce9e9f..c7ec1a2 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -29,39 +29,6 @@
>   * kind, whether express or implied.
>   */
> =20
> -/* Platform device Usage :
> - *
> - * Since PSCs can have multiple function, the correct driver for each one
> - * is selected by calling mpc52xx_match_psc_function(...). The function
> - * handled by this driver is "uart".
> - *
> - * The driver init all necessary registers to place the PSC in uart mode=
 without
> - * DCD. However, the pin multiplexing aren't changed and should be set e=
ither
> - * by the bootloader or in the platform init code.
> - *
> - * The idx field must be equal to the PSC index (e.g. 0 for PSC1, 1 for =
PSC2,
> - * and so on). So the PSC1 is mapped to /dev/ttyPSC0, PSC2 to /dev/ttyPS=
C1 and
> - * so on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed m=
ainly
> - * fpr the console code : without this 1:1 mapping, at early boot time, =
when we
> - * are parsing the kernel args console=3DttyPSC?, we wouldn't know which=
 PSC it
> - * will be mapped to.
> - */
> -
> -/* OF Platform device Usage :
> - *
> - * This driver is only used for PSCs configured in uart mode.  The device
> - * tree will have a node for each PSC with "mpc52xx-psc-uart" in the com=
patible
> - * list.
> - *
> - * By default, PSC devices are enumerated in the order they are found.  =
However
> - * a particular PSC number can be forces by adding 'device_no =3D <port#=
>'
> - * to the device node.
> - *
> - * The driver init all necessary registers to place the PSC in uart mode=
 without
> - * DCD. However, the pin multiplexing aren't changed and should be set e=
ither
> - * by the bootloader or in the platform init code.
> - */
> -
>  #undef DEBUG
> =20
>  #include <linux/device.h>
> --=20
> 1.6.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--M2Pxvdb9QxnGd/3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktodcQACgkQD27XaX1/VRtmjgCgwaGxdB1Cvxg1N/YGy9Cx0d2t
IGwAnjFQf89kQIFuRjUdiEtHh6q3dD1j
=9BM4
-----END PGP SIGNATURE-----

--M2Pxvdb9QxnGd/3e--
