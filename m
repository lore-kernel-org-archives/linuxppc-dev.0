Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82D962C023B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 21:57:14 +1100 (EST)
Date: Fri, 11 Jan 2013 12:56:51 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130111105651.GF11085@arwen.pp.htv.fi>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
In-Reply-To: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
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

--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 11, 2013 at 05:56:28PM +0800, Peter Chen wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the SoC type, and updates the platform code accordingly.
>=20
> Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> Tested at mx51 bbg board, it works ok after enable phy clock
> (Need another patch to fix this problem)
>=20
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

this is too big for -rc, can you break it down into smaller pieces ?

--=20
balbi

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7+/zAAoJEIaOsuA1yqREZWsQAI+XC266ue3cg3tihIbww78s
pScXklPgFUXXI0oP+s5AuXFbhP/dVbeEqTzaZFoNTAK4nixVqR7mU68mrk6uThjH
DV6eAfA/jglrDs5N931h5MkaVzeo8ymjSg7wCb/Jqvs+5MgJ/+pVzn6tnh5NYbwi
7vKC73CIxVC2+yr6S/yDngqpEeeuNeHyG8rHqGQzp2aQoUbGOlbsOdLB4ruKHHcM
w2Fde7URBtz51C6akyhjdQTgaxjoFl1Xs7ALhK4xNFcXYPqzVuNgmB31SG25bX2o
T80Hh8hDC84OVNe4+Zefc1n8DX1jcvANN52+BEaTGqRXMqecdUxUsi37A1THyw9Q
SaT95SygGTVfJ5SsOfRSXU/C1V2md6RlweUiOaBQ+H9RjjQ14jMEM0P+iL/gU/pM
pKu2PYTIz29DaRM9H/18Etrbz8SrVHG0Jj2S5I+HXTT+Ypw80JTuUyj6RdLtlEl7
QDxOnlFh/FA4Q8rw1/cC/ffIfcTz5lRo16hTMjil/hI82acGVpddZ0UGEcL/CbCh
hrVDVpyD0yS8jwHIhyZcCnJqjwuH2dOkHwEMdMAMKyD+T6TbHePFi9ZlYVQqn5F4
2s3C5hb8kGVNMhz6bFz8pmAM83nm3bIdZN4NKIX12sRqKrIjckmSCoi4y9WP99KM
jxzeu3pUuzemYEtorb1I
=xs4H
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
