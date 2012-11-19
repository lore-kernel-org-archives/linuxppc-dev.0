Return-Path: <balbi@ti.com>
Date: Mon, 19 Nov 2012 22:15:26 +0200
From: Felipe Balbi <balbi@ti.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 159/493] usb: remove use of __devinit
Message-ID: <20121119201526.GB24309@arwen.pp.htv.fi>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-159-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
In-Reply-To: <1353349642-3677-159-git-send-email-wfp5p@virginia.edu>
Cc: cbe-oss-dev@lists.ozlabs.org, Kukjin Kim <kgene.kim@samsung.com>,
 Wan ZongShun <mcuos.com@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Felipe Balbi <balbi@ti.com>,
 Geoff Levand <geoff@infradead.org>, linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Ben Dooks <ben-linux@fluff.org>, Olav Kongas <ok@artecdesign.ee>,
 Lennert Buytenhek <kernel@wantstofly.org>,
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

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 19, 2012 at 01:21:48PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>=20
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>=20
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>=20
> Cc: Felipe Balbi <balbi@ti.com>=20
> Cc: Li Yang <leoli@freescale.com>=20
> Cc: Alan Stern <stern@rowland.harvard.edu>=20
> Cc: Geoff Levand <geoff@infradead.org>=20
> Cc: Wan ZongShun <mcuos.com@gmail.com>=20
> Cc: Olav Kongas <ok@artecdesign.ee>=20
> Cc: Lennert Buytenhek <kernel@wantstofly.org>=20
> Cc: Ben Dooks <ben-linux@fluff.org>=20
> Cc: Kukjin Kim <kgene.kim@samsung.com>=20
> Cc: linux-usb@vger.kernel.org=20
> Cc: linux-omap@vger.kernel.org=20
> Cc: linuxppc-dev@lists.ozlabs.org=20
> Cc: cbe-oss-dev@lists.ozlabs.org=20
> Cc: linux-arm-kernel@lists.infradead.org=20
> Cc: linux-samsung-soc@vger.kernel.org=20
> ---
>  drivers/usb/c67x00/c67x00-drv.c      |  2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c   |  2 +-
>  drivers/usb/chipidea/ci13xxx_msm.c   |  2 +-
>  drivers/usb/chipidea/ci13xxx_pci.c   |  2 +-
>  drivers/usb/chipidea/core.c          |  2 +-
>  drivers/usb/chipidea/usbmisc_imx6q.c |  2 +-
>  drivers/usb/dwc3/core.c              | 11 +++++------
>  drivers/usb/dwc3/debugfs.c           |  2 +-
>  drivers/usb/dwc3/dwc3-exynos.c       |  4 ++--
>  drivers/usb/dwc3/dwc3-omap.c         |  4 ++--
>  drivers/usb/dwc3/dwc3-pci.c          |  4 ++--
>  drivers/usb/dwc3/gadget.c            |  4 ++--
>  drivers/usb/gadget/at91_udc.c        |  4 ++--
>  drivers/usb/gadget/bcm63xx_udc.c     |  2 +-
>  drivers/usb/gadget/f_uac2.c          |  2 +-
>  drivers/usb/gadget/fsl_qe_udc.c      |  8 ++++----
>  drivers/usb/gadget/mv_udc_core.c     |  2 +-
>  drivers/usb/gadget/net2272.c         | 13 ++++++-------
>  drivers/usb/gadget/omap_udc.c        |  6 +++---
>  drivers/usb/gadget/s3c-hsotg.c       |  6 +++---
>  drivers/usb/gadget/s3c-hsudc.c       |  2 +-
>  drivers/usb/host/bcma-hcd.c          |  9 ++++-----
>  drivers/usb/host/ehci-atmel.c        |  2 +-
>  drivers/usb/host/ehci-grlib.c        |  2 +-
>  drivers/usb/host/ehci-orion.c        |  4 ++--
>  drivers/usb/host/ehci-platform.c     |  2 +-
>  drivers/usb/host/ehci-ppc-of.c       |  4 ++--
>  drivers/usb/host/ehci-ps3.c          |  2 +-
>  drivers/usb/host/ehci-s5p.c          |  2 +-
>  drivers/usb/host/ehci-w90x900.c      |  4 ++--
>  drivers/usb/host/ehci-xilinx-of.c    |  2 +-
>  drivers/usb/host/fhci-hcd.c          |  2 +-
>  drivers/usb/host/fsl-mph-dr-of.c     |  8 ++++----
>  drivers/usb/host/imx21-hcd.c         |  2 +-
>  drivers/usb/host/isp116x-hcd.c       |  2 +-
>  drivers/usb/host/isp1362-hcd.c       |  2 +-
>  drivers/usb/host/isp1760-if.c        |  4 ++--
>  drivers/usb/host/ohci-at91.c         | 12 ++++++------
>  drivers/usb/host/ohci-ep93xx.c       |  2 +-
>  drivers/usb/host/ohci-exynos.c       |  2 +-
>  drivers/usb/host/ohci-jz4740.c       |  2 +-
>  drivers/usb/host/ohci-nxp.c          |  4 ++--
>  drivers/usb/host/ohci-octeon.c       |  2 +-
>  drivers/usb/host/ohci-omap3.c        |  2 +-
>  drivers/usb/host/ohci-pci.c          |  2 +-
>  drivers/usb/host/ohci-platform.c     |  2 +-
>  drivers/usb/host/ohci-ppc-of.c       |  4 ++--
>  drivers/usb/host/ohci-ps3.c          |  4 ++--
>  drivers/usb/host/ohci-pxa27x.c       |  6 +++---
>  drivers/usb/host/ohci-s3c2410.c      |  2 +-
>  drivers/usb/host/ohci-sa1111.c       |  2 +-
>  drivers/usb/host/ohci-spear.c        |  2 +-
>  drivers/usb/host/ohci-tmio.c         |  2 +-
>  drivers/usb/host/pci-quirks.c        | 14 +++++++-------
>  drivers/usb/host/r8a66597-hcd.c      |  2 +-
>  drivers/usb/host/sl811-hcd.c         |  2 +-
>  drivers/usb/host/ssb-hcd.c           | 11 +++++------
>  drivers/usb/host/u132-hcd.c          |  2 +-
>  drivers/usb/host/uhci-grlib.c        |  2 +-
>  drivers/usb/host/uhci-platform.c     |  2 +-
>  drivers/usb/musb/am35x.c             |  2 +-
>  drivers/usb/musb/blackfin.c          |  2 +-
>  drivers/usb/musb/cppi_dma.c          |  3 +--
>  drivers/usb/musb/da8xx.c             |  2 +-
>  drivers/usb/musb/davinci.c           |  2 +-
>  drivers/usb/musb/musb_core.c         | 15 +++++++--------
>  drivers/usb/musb/musb_debugfs.c      |  2 +-
>  drivers/usb/musb/musb_dma.h          |  3 +--
>  drivers/usb/musb/musb_dsps.c         |  4 ++--
>  drivers/usb/musb/musb_gadget.c       |  6 +++---
>  drivers/usb/musb/musbhsdma.c         |  3 +--
>  drivers/usb/musb/omap2430.c          |  2 +-
>  drivers/usb/musb/tusb6010.c          |  2 +-
>  drivers/usb/musb/tusb6010_omap.c     |  3 +--
>  drivers/usb/musb/ux500.c             |  2 +-
>  drivers/usb/musb/ux500_dma.c         |  3 +--
>  drivers/usb/otg/ab8500-usb.c         |  2 +-
>  drivers/usb/otg/fsl_otg.c            |  2 +-
>  drivers/usb/otg/isp1301_omap.c       |  2 +-
>  drivers/usb/otg/nop-usb-xceiv.c      |  2 +-
>  drivers/usb/otg/twl4030-usb.c        |  2 +-
>  drivers/usb/otg/twl6030-usb.c        |  2 +-
>  drivers/usb/phy/mv_u3d_phy.c         |  2 +-
>  drivers/usb/phy/omap-usb2.c          |  2 +-
>  drivers/usb/phy/rcar-phy.c           |  2 +-
>  85 files changed, 145 insertions(+), 155 deletions(-)

For drivers/usb/gadget, drivers/usb/dwc3/, drivers/usb/musb/,
drivers/usb/otg/, drivers/usb/phy, and drivers/usb/renesas_usbhs:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqpNeAAoJEIaOsuA1yqREMrUP/jaYoehGFVHD69c20yGz1/b2
cQHufSEQjN8g1619XBBRhoJ2fVyrvtyMVPAlMgN14RnnAr7C1SHHnFFNGsh3ObGC
bSftZxKNrktIOi104fKJpGLYs0GgevDIfgHj4CXPA0e1wmasZ0PMj6CUGoYWMHby
Vp7CkDXCMffodqjrhEzrC6+kmNadSQk53t5wsOQ+gBywyCZJ6hWpWgHcByHUEmY9
w4lyBGsfB9+kttqa2IoITXjl+P/ftOP2poxIeALeYHDDd291K84LG5xdrVI52iuK
NOuKdzIA9C6bIj4VCYa2EkL0eVhTwjjxVmvIIei7kwRp7uX9jfV+kTfbutrIY5Pt
B3um65r46u317wGxxSHh+45Nhjbb0W2+hFD74yXsoKvTS1dAWeV+Cm4h/V4v/K6F
cVFkSd4SAknghvFOMvvUMkuwHkW1irhqDbaM9E8xZWoRkoKYIytNd60nxD/ZfB1L
d1tRKpb7M9tRGTuW8bDi3iv9jsM+B3SbvCCAdXHtHSrmT4NoA9gH6nLXmcdtCO0K
DRWUWcjVE/FwIUKQG4VG7952qyj7BrkMNhiUR288F0tg4SRF6QMCQ4cysARy/eEi
KHKXskG1aP6Dd/HwrpOa+LlIYWkMFchMm4YYMzjOJpohLAV9Hn/t4uFMVNWTupSM
rxYDtjZ0Ny0ufAbJSHpD
=8H6d
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
