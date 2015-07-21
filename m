Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3254A1A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 02:53:05 +1000 (AEST)
Date: Tue, 21 Jul 2015 11:43:32 -0500
From: Felipe Balbi <balbi@ti.com>
To: Robert Baldyga <r.baldyga@samsung.com>
CC: <gregkh@linuxfoundation.org>, <balbi@ti.com>, <Peter.Chen@freescale.com>,
 <johnyoun@synopsys.com>, <dahlmann.thomas@arcor.de>,
 <nicolas.ferre@atmel.com>, <cernekee@gmail.com>, <leoli@freescale.com>,
 <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
 <robert.jarzmik@free.fr>, <michal.simek@xilinx.com>,
 <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-geode@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <andrzej.p@samsung.com>,
 <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 07/46] usb: dwc3: gadget: add ep capabilities support
Message-ID: <20150721164331.GG25385@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
 <1436941953-1327-8-git-send-email-r.baldyga@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
In-Reply-To: <1436941953-1327-8-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 15, 2015 at 08:31:54AM +0200, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 333a7c0..8d1f768 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1713,6 +1713,19 @@ static int dwc3_gadget_init_hw_endpoints(struct dw=
c3 *dwc,
>  				return ret;
>  		}
> =20
> +		if (epnum =3D=3D 0) {
> +			dep->endpoint.caps.type_control =3D true;

as the name says, this function deals with hw endpoints. This means ep1
is also control.

--=20
balbi

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrnazAAoJEIaOsuA1yqREZlsP/iImgKnRRlxvEAeHgOlh9tWz
kNZU4AE5LzmNQY66UVPZ9Mfycpu25vNZMU20SrwF/0NeCju0JoGbQAyVPoJVLwDV
GJlzQZkWOgTwxzYTW7Jwy7guVwmu6nBz+cbVFeCihxT63l+4JBhsq7xl3Dee6MSY
PgCm7TkKpZVmpZSgtJYbJ+dt8kqw/lR8HwF0QzZ2RnGlKgiklGRfJefrwFz7d4eD
TM+hoLSRei+u6gq9umZ5D5oV+YIZURvGm+2WQ9cWVP1cFTreW6OqS3lDu2Ajd8LN
uiQzVg03pHLD/G7m+Ab3dT1gfXHQhxIEQ7a+oX5nX3W9PbDTOI4rFBGE92fJ2FxV
e5rmfidPAxixboXwdEwVcI9VDqXI+Ov0RJjKYrtfPgqX/IZUMdBB8sNUnr5jdhGg
wSQoAKz3Rv4suXF+HaF9kAbUaDyUETvA8rm8EA6P17DJkRM0Hu5jDDaUe2/0pv1J
Ciue6q59wHtg89PwWZad0NHzxJda6Q0RPFrJpkv+iwzk71kX+Wc+CGHFfrwiEBy9
MYNzwuVfhNgeFQmFOqc1xg0JEs6p0+zJ5XBmZAJnJxYt2CyHelkEuOZvHkfwwvja
xIkMS1yt24pZf84IMn1V2yNS8XAlO+ZtXGPIS7/jZ9q+Sd1CrWO672uCct9Iasg5
KzlHFQbZwW5x3IPRhvQr
=k33n
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--
