Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 467C82C0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 07:21:46 +1100 (EST)
Date: Mon, 19 Nov 2012 22:14:54 +0200
From: Felipe Balbi <balbi@ti.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 119/493] usb: remove use of __devexit_p
Message-ID: <20121119201454.GA24309@arwen.pp.htv.fi>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Wan ZongShun <mcuos.com@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Ben Dooks <ben-linux@fluff.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 19, 2012 at 01:21:08PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>=20
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>=20
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>=20
> Cc: Felipe Balbi <balbi@ti.com>=20
> Cc: Li Yang <leoli@freescale.com>=20
> Cc: Alan Stern <stern@rowland.harvard.edu>=20
> Cc: Wan ZongShun <mcuos.com@gmail.com>=20
> Cc: Ben Dooks <ben-linux@fluff.org>=20
> Cc: Kukjin Kim <kgene.kim@samsung.com>=20
> Cc: linux-usb@vger.kernel.org=20
> Cc: linux-omap@vger.kernel.org=20
> Cc: linuxppc-dev@lists.ozlabs.org=20
> Cc: linux-arm-kernel@lists.infradead.org=20
> Cc: linux-samsung-soc@vger.kernel.org=20
> ---
>  drivers/usb/c67x00/c67x00-drv.c      | 2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c   | 2 +-
>  drivers/usb/chipidea/ci13xxx_msm.c   | 2 +-
>  drivers/usb/chipidea/ci13xxx_pci.c   | 2 +-
>  drivers/usb/chipidea/core.c          | 2 +-
>  drivers/usb/chipidea/usbmisc_imx6q.c | 2 +-
>  drivers/usb/dwc3/core.c              | 2 +-
>  drivers/usb/dwc3/dwc3-exynos.c       | 2 +-
>  drivers/usb/dwc3/dwc3-omap.c         | 2 +-
>  drivers/usb/dwc3/dwc3-pci.c          | 2 +-
>  drivers/usb/gadget/bcm63xx_udc.c     | 2 +-
>  drivers/usb/gadget/fsl_qe_udc.c      | 2 +-
>  drivers/usb/gadget/hid.c             | 2 +-
>  drivers/usb/gadget/lpc32xx_udc.c     | 2 +-
>  drivers/usb/gadget/net2272.c         | 4 ++--
>  drivers/usb/gadget/omap_udc.c        | 2 +-
>  drivers/usb/gadget/s3c-hsotg.c       | 2 +-
>  drivers/usb/host/bcma-hcd.c          | 2 +-
>  drivers/usb/host/ehci-atmel.c        | 2 +-
>  drivers/usb/host/ehci-msm.c          | 2 +-
>  drivers/usb/host/ehci-platform.c     | 2 +-
>  drivers/usb/host/ehci-s5p.c          | 2 +-
>  drivers/usb/host/ehci-w90x900.c      | 2 +-
>  drivers/usb/host/fhci-hcd.c          | 2 +-
>  drivers/usb/host/fsl-mph-dr-of.c     | 2 +-
>  drivers/usb/host/isp1362-hcd.c       | 2 +-
>  drivers/usb/host/isp1760-if.c        | 2 +-
>  drivers/usb/host/ohci-at91.c         | 2 +-
>  drivers/usb/host/ohci-exynos.c       | 2 +-
>  drivers/usb/host/ohci-jz4740.c       | 2 +-
>  drivers/usb/host/ohci-omap3.c        | 2 +-
>  drivers/usb/host/ohci-platform.c     | 2 +-
>  drivers/usb/host/ohci-s3c2410.c      | 2 +-
>  drivers/usb/host/ohci-tmio.c         | 2 +-
>  drivers/usb/host/r8a66597-hcd.c      | 2 +-
>  drivers/usb/host/sl811-hcd.c         | 2 +-
>  drivers/usb/host/ssb-hcd.c           | 2 +-
>  drivers/usb/host/u132-hcd.c          | 2 +-
>  drivers/usb/musb/am35x.c             | 2 +-
>  drivers/usb/musb/da8xx.c             | 2 +-
>  drivers/usb/musb/davinci.c           | 2 +-
>  drivers/usb/musb/musb_core.c         | 2 +-
>  drivers/usb/musb/musb_dsps.c         | 2 +-
>  drivers/usb/musb/omap2430.c          | 2 +-
>  drivers/usb/musb/tusb6010.c          | 2 +-
>  drivers/usb/musb/ux500.c             | 2 +-
>  drivers/usb/otg/ab8500-usb.c         | 2 +-
>  drivers/usb/otg/fsl_otg.c            | 2 +-
>  drivers/usb/otg/msm_otg.c            | 2 +-
>  drivers/usb/otg/mxs-phy.c            | 2 +-
>  drivers/usb/otg/nop-usb-xceiv.c      | 2 +-
>  drivers/usb/phy/mv_u3d_phy.c         | 2 +-
>  drivers/usb/phy/omap-usb2.c          | 2 +-
>  drivers/usb/phy/rcar-phy.c           | 2 +-
>  drivers/usb/renesas_usbhs/common.c   | 2 +-
>  55 files changed, 56 insertions(+), 56 deletions(-)

For drivers/usb/gadget, drivers/usb/dwc3/, drivers/usb/musb/,
drivers/usb/otg/, drivers/usb/phy, and drivers/usb/renesas_usbhs:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqpM9AAoJEIaOsuA1yqREWjQQAIXXAJx5+kSOe2m3cZ9ihY9h
kNSeWwzGQzkWj5ZjJ0+PbI6ivH32XT83gnojK5ZiI4ZY+z12Qg2GdKonjKD2p2Ay
m/HKSWBbuM21YmDbEKMnnTrBjoPpDisBpV+0wfkJWn8czmkWsFIYmvovZcg7bWF3
75B3lI8lrqxeM/cFKm+3iq800BHQ6j0oakvNFOM/I3e/hitJ/SOZbSiVrIJk2Y70
49rTGAKeyiXRHTOmIdPfl7/AJGwUkXkpdNygHwuRfCFjgERkRJfyQpIu3Fyc13/F
caVJqrImlJHT6GJUZcPICybxYfbG8FKxl62PvTEW1Q+3pgtM2P2RSWq8LGrwLiX+
QzFIIddhhPAxhyxQeRLNdpdQQojKT65vlRWUgnVqmVnR3XCrbJVoUqVHxYWYZjK3
D0OJ79gd4kmj8MtkjEzyGYywCxkPswDZuxB7Nj+ycZ9AkQpnqMnayJoybDAGMTuO
L1VD4ExGzOwMC8NEK6yC1sEKXe46eEmRuJGFw8ppDyGs2qGu85bfC1+KJIpsYtYs
tLGvMSZ2za7/aLOuyI5UdA0ZzXPjtVgPSJezObuG+oZMgs3DoB1naMxC/dFfA/u6
vS4PTB3MWW+BKMV6WHJYmAzGQFJGpMz8UjaYTTCo0wvd7stJ0Nz2KH+uMasV5/Os
C7YHTUcUEg5VWWj0gCTG
=JUhY
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
