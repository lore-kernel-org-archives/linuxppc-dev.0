Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0616D2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 07:23:25 +1100 (EST)
Date: Mon, 19 Nov 2012 22:16:50 +0200
From: Felipe Balbi <balbi@ti.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 371/493] usb: remove use of __devinitconst
Message-ID: <20121119201649.GD24309@arwen.pp.htv.fi>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-371-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
In-Reply-To: <1353349642-3677-371-git-send-email-wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 19, 2012 at 01:25:20PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinitconst is no
> longer needed.
>=20
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Li Yang <leoli@freescale.com>=20
> Cc: Felipe Balbi <balbi@ti.com>=20
> Cc: linux-usb@vger.kernel.org=20
> Cc: linuxppc-dev@lists.ozlabs.org=20
> ---
>  drivers/usb/gadget/fsl_qe_udc.c | 2 +-
>  drivers/usb/host/bcma-hcd.c     | 2 +-
>  drivers/usb/host/pci-quirks.c   | 2 +-
>  drivers/usb/host/ssb-hcd.c      | 2 +-
>  drivers/usb/musb/musb_dsps.c    | 6 +++---
>  5 files changed, 7 insertions(+), 7 deletions(-)

For drivers/usb/gadget, drivers/usb/musb/:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqpOxAAoJEIaOsuA1yqRE3FUQAKHhHnZM3lM1lUjlrdqGJMcK
N9WUVIK6ipmtkV4GU1D58sAYHE++j3EvQ/78X5++uSXeImr4zGn/3XwPsh94lxfk
LrWwPMKz8W8IN7ugsB57FPIwGjbrTgiIPHXTHnvikpVamCK5b7QqNjTz0IVXYkQk
patuc4S0B9rEbz1WYk6kwVB5igIUyPXuAVK3KYoUCtl6qqsfJrC5kDR0z7JpXNjd
xuROnlA/iLpx8bWPbmmnzU/sC/WVsLbPE26R+/RNSmDhEzqJ9pon7QUaxVotZt81
S5NK6Q34MenSsStdYHreFdpMWiq9FNAmgBDtKu7GNAYUrNXy3ijaluTPCABM5Rbe
5POqpnPlbv1CFWTNBOUQ8hhemWsVsVLkgmnzFhertRufEhZC+ucpc1Qp3VCnR+3c
7c45HgTymDl9Iv9VapqguXn0efQASxN0kle0rkp3gTJFlS+5700iAKYleEsnn+2m
L+MnF0/ep5CUTBphmlT4k2/PjpLR45LI5V8D6C2xRKMDN5m1jnTIAeoKXt9SLlCu
2S3e2FBk8H7rVyZXATrHMdiscNz0yEPP8GKuz7pPhxeOcFbSzCwW/JkcQqtwEiV2
aw+8iamZG799Rhoj5OTj7FULjsqACo9ElsIEfytWCorbqqHX/JRlW8FSbP5vZ9dV
AfSJZhtu763PvLV7UTLW
=+Ush
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
