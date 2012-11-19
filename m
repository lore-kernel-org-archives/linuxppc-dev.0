Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EAEA2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 07:24:30 +1100 (EST)
Date: Mon, 19 Nov 2012 22:17:31 +0200
From: Felipe Balbi <balbi@ti.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 431/493] usb: remove use of __devexit
Message-ID: <20121119201731.GE24309@arwen.pp.htv.fi>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-431-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
In-Reply-To: <1353349642-3677-431-git-send-email-wfp5p@virginia.edu>
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

--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 19, 2012 at 01:26:20PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
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
>  drivers/usb/c67x00/c67x00-drv.c      |  2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c   |  2 +-
>  drivers/usb/chipidea/ci13xxx_msm.c   |  2 +-
>  drivers/usb/chipidea/ci13xxx_pci.c   |  2 +-
>  drivers/usb/chipidea/core.c          |  2 +-
>  drivers/usb/chipidea/usbmisc_imx6q.c |  2 +-
>  drivers/usb/dwc3/core.c              |  2 +-
>  drivers/usb/dwc3/debugfs.c           |  2 +-
>  drivers/usb/dwc3/dwc3-exynos.c       |  2 +-
>  drivers/usb/dwc3/dwc3-omap.c         |  2 +-
>  drivers/usb/dwc3/dwc3-pci.c          |  2 +-
>  drivers/usb/gadget/bcm63xx_udc.c     |  2 +-
>  drivers/usb/gadget/fsl_qe_udc.c      |  2 +-
>  drivers/usb/gadget/hid.c             |  2 +-
>  drivers/usb/gadget/lpc32xx_udc.c     |  2 +-
>  drivers/usb/gadget/mv_u3d_core.c     |  2 +-
>  drivers/usb/gadget/mv_udc_core.c     |  2 +-
>  drivers/usb/gadget/net2272.c         | 10 +++++-----
>  drivers/usb/gadget/omap_udc.c        |  2 +-
>  drivers/usb/gadget/s3c-hsotg.c       |  4 ++--
>  drivers/usb/host/bcma-hcd.c          |  2 +-
>  drivers/usb/host/ehci-atmel.c        |  2 +-
>  drivers/usb/host/ehci-msm.c          |  2 +-
>  drivers/usb/host/ehci-platform.c     |  2 +-
>  drivers/usb/host/ehci-s5p.c          |  2 +-
>  drivers/usb/host/ehci-w90x900.c      |  2 +-
>  drivers/usb/host/fhci-hcd.c          |  4 ++--
>  drivers/usb/host/fsl-mph-dr-of.c     |  4 ++--
>  drivers/usb/host/isp1362-hcd.c       |  2 +-
>  drivers/usb/host/isp1760-if.c        |  2 +-
>  drivers/usb/host/ohci-at91.c         |  6 +++---
>  drivers/usb/host/ohci-exynos.c       |  2 +-
>  drivers/usb/host/ohci-jz4740.c       |  2 +-
>  drivers/usb/host/ohci-omap3.c        |  2 +-
>  drivers/usb/host/ohci-platform.c     |  2 +-
>  drivers/usb/host/ohci-s3c2410.c      |  2 +-
>  drivers/usb/host/ohci-tmio.c         |  2 +-
>  drivers/usb/host/r8a66597-hcd.c      |  2 +-
>  drivers/usb/host/sl811-hcd.c         |  2 +-
>  drivers/usb/host/ssb-hcd.c           |  4 ++--
>  drivers/usb/host/u132-hcd.c          |  2 +-
>  drivers/usb/musb/am35x.c             |  2 +-
>  drivers/usb/musb/blackfin.c          |  2 +-
>  drivers/usb/musb/da8xx.c             |  2 +-
>  drivers/usb/musb/davinci.c           |  2 +-
>  drivers/usb/musb/musb_core.c         |  2 +-
>  drivers/usb/musb/musb_dsps.c         |  2 +-
>  drivers/usb/musb/omap2430.c          |  2 +-
>  drivers/usb/musb/tusb6010.c          |  2 +-
>  drivers/usb/musb/ux500.c             |  2 +-
>  drivers/usb/otg/ab8500-usb.c         |  2 +-
>  drivers/usb/otg/fsl_otg.c            |  2 +-
>  drivers/usb/otg/msm_otg.c            |  2 +-
>  drivers/usb/otg/mxs-phy.c            |  2 +-
>  drivers/usb/otg/nop-usb-xceiv.c      |  2 +-
>  drivers/usb/phy/omap-usb2.c          |  2 +-
>  drivers/usb/phy/rcar-phy.c           |  2 +-
>  drivers/usb/renesas_usbhs/common.c   |  2 +-

For drivers/usb/gadget, drivers/usb/dwc3/, drivers/usb/musb/,
drivers/usb/otg/, drivers/usb/phy, and drivers/usb/renesas_usbhs:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqpPbAAoJEIaOsuA1yqREELAQAJeCLcJDvnan3uXKIm5HtOnW
RKq2KWIcYwNEVRZtERha+ppAp+wmIGEijWxt/ppUNAx6gVEBbolhjAZT4pUKnCzK
yJzpnp3EH+yzLAK+2LpztPryTDqG5kDMiJRzsqXNfBjb6edRXBH6+fhRiFLporDq
25hhxKby3xasYKmp8wdXkpv6VE9a/Y4sLenaKBsBQkKDNEaFNiKjmDZIfijSJVnI
I3sewckZr4+MbNevaHz9zbEFQ4LJewHRb1jqGb6OsKsTMwMp6T2i16P3qa0HbK+s
vBMgUtI7j2Y/ga3fJyGz1J9sTqlgcnwOxE2aF/MpCQ+hGGBbDVIl4vCp+E6243lo
KyFsU3NFCABxgOqAKpnXIEXB15+/AjOjHcjvZ0l4MTphlrXLmU9d2zh3edYsSb6w
NHJh+XSPTd3o6RS8UT5eShXFtUO/sEUP8NMx+Wr6mPSR2tP09lGTC1gdFj04Rl2x
ao9s8QkSS9Nog7BPZNm2zonyFa5HdPnoP1IGbWxNyNgQO6u1GvzkdVLRding8tye
acP0elpea+6EcuYLleDadlVyp3nEhy4eG5tpIcflcK97eL1hAdqcnMquc+VHnuUk
Q7btm+gtj/RX6qhNCEAVBU749S3YCuCMo9ef/X0BpnnaY30FInIdnYoYXsOpB0qP
Y518o0ezuTBB3Q4fsd+/
=Xsoi
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
