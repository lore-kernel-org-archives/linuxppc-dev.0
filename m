Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E02722C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 21:58:46 +1100 (EST)
Date: Thu, 17 Jan 2013 12:58:33 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v6 3/3] ARM: i.MX clock: Change the connection-id for
 fsl-usb2-udc
Message-ID: <20130117105833.GP10814@arwen.pp.htv.fi>
References: <1358416997-29099-1-git-send-email-peter.chen@freescale.com>
 <1358416997-29099-4-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="r7tUYVWcdYzDJoZW"
In-Reply-To: <1358416997-29099-4-git-send-email-peter.chen@freescale.com>
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

--r7tUYVWcdYzDJoZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2013 at 06:03:17PM +0800, Peter Chen wrote:
> As we use platform_device_id for fsl-usb2-udc driver, it needs to
> change clk connection-id, or the related devm_clk_get will be failed.
>=20
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

do I get Acked-by for this one ?

--=20
balbi

--r7tUYVWcdYzDJoZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ99lZAAoJEIaOsuA1yqREOMoP/RgSHwKkPv8ZssyyEaTt2RS4
Hwb4IBVFfUlqZ1XpMwl5LSNrKJP3lclQr3EvsEdsIZy+lW7gFMY6UN4N6JfWr1ag
dqDKyU78tGQM2YGlYywVcvKiv3UoEH90Ub9igCtzaZiqPwUsRPK/wk4L8Ttpvdys
/+gZCB1bsBAgnGQb6KMeIp2ilbs0G/YdP43f4UQEKAjw8DgPD4ii9d0rdrfsonAJ
quQFiyzrfsdMfJIUsW50k1JduKMTO6ZhKL3HgpqBsG5q8t9amFq9E8x7UZT5TPp+
EzwXRrAd6dxWCBwRxXcfFu0hle/effpyosCer5SuqpabRUhKQv8Jj+yZKTx/iqUL
LpulZbRt3OZ3vR1nFMaqXhMid+CI1mS5O0Lk7lgihH2DD/KZz3SKwOXWshOKGopz
asuRX537BcYFepkaFRvS3kiPTFFTWnR8dfB0lFPBUr9C/D+X1M68jatgboIzRWbU
3fxmKbPsH91gbJRzZBAGAhY2aUBDAf8eANdDrn/DX5YrBEKW+lWGzDDwvx+BNfny
85BnJBy52Tq2wQw1F4vNuVW4aE9sHkPSnQ9z/KYVSKYI9FlHSRgC+f1jyLvUs2TZ
2pa9qsDKWkjHuGUr5mAYvOjrwL8fEMFpyZ2OazuIfeR6BipQQtNVQCJvMmR7eZcp
bprzzoAWOEUxF3M5CeDv
=dY7b
-----END PGP SIGNATURE-----

--r7tUYVWcdYzDJoZW--
