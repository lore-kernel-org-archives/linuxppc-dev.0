Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C2BB2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 18:49:11 +1100 (EST)
Date: Mon, 14 Jan 2013 09:48:58 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v2 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130114074858.GA10176@arwen.pp.htv.fi>
References: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2013 at 03:18:17PM +0800, Peter Chen wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the SoC type, and updates the platform code accordingly.
>=20
> Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> Tested at mx51 bbg board, it works ok after enable phy clock
> (Need another patch to fix this problem)
>=20
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

not good for -rc. You have to break this down as you're solving at least
three different problems with this patch.

Besides there are parts which are not related to the build break.

--=20
balbi

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ87hqAAoJEIaOsuA1yqREPM4QAJv8zioi5KRuYZ9bMCibvXx0
Igeib9iPKX1BcOfxeqdrnssXVgNYVTCwwPIIl43ouPjO48ZKPIW/FmI7hDHWlPzm
1qc1o4iYDVaj05zZSX1rQ09QmxYbh68s4BCnzyM0e04QgaaVNCKudmrz73sNMDsE
OfPZ1TvK4DLbLxtQnS+7MFnl5w6izCIFcK3fEtI5dpqrSAgUpjdV/MFuvcTpggB/
ROrABBzdGHXMBo8PRu7d54l6seJGE+6va6p+bSAOel4ydZ2+Oq1ddBBOEjVJM9EX
J7izU/vSLKv4RswVHbC0XKwUE1QAc7SK8nID8k/x/ns82bjIjzhs+MCtwmDN+YNk
kMOQ3jthOnad94adsNUf5MDUfswXSn3u6TgAh9/hLPsN1PZAQqJmvvtIAJO7lJ3o
LdHPRgBe+mrPTBg2dJhro40cbGdJDnu7Q0jKgMuchgPgo9pBTiEgdNC/DuWrRz/2
O06lIKRRZCFDYrDwgR01whGmi/ei7nv+TkluoFSro4XP0QV1yB3AWF7hEGuNF1Ox
lGNdQgtl+4rC8jMzqTrSDyXfJt7qIvdYqK6uVdsMX7au3eJeQ8540iY4Oo5520kf
NUsbXkWhKah8fhydj9/jZIN5NZ2vxJmVibcwu0kLKeGETyYqYzkGY5LVnDc5mBYT
tNkY5YJLsRd6vHwUKij4
=SQfZ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
