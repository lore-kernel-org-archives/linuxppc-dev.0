Return-Path: <B33228@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D33B3B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Jan 2011 22:49:26 +1100 (EST)
Subject: Re: [PATCH] USB: Fix USB Kconfig dependency problem on 85xx/QoirQ
	platforms
From: xulei <B33228@freescale.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <F4B27091-DAAF-4E0C-A726-C7111161210C@freescale.com>
References: <1294654017-32568-1-git-send-email-B33228@freescale.com>
	<F4B27091-DAAF-4E0C-A726-C7111161210C@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Jan 2011 19:51:00 +0800
Message-ID: <1294746660.5871.8.camel@xulei-desktop>
MIME-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks very much.
I'm sorry for that and will get it later.

On =E4=B8=80, 2011-01-10 at 10:22 -0600, Kumar Gala wrote:
> On Jan 10, 2011, at 4:06 AM, Xulei wrote:
>=20
> > For FSL PPC SoCs USB_ARCH_HAS_EHCI currently on depends on PPC_83xx.
> > However that excludes support for USB on 85xx & QorIQ devices.  Use
> > FSL_SOC insted which will get us 83xx, 85xx, QorIQ, and 5xxx which al=
l
> > have the same USB IP on them.
> >=20
> > Signed-off-by: Xulei <B33228@freescale.com>
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> > ---
> > drivers/usb/Kconfig |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index 6a58cb1..d513d3a 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -57,7 +57,7 @@ config USB_ARCH_HAS_OHCI
> > # some non-PCI hcds implement EHCI
> > config USB_ARCH_HAS_EHCI
> > 	boolean
> > -	default y if PPC_83xx
> > +	default y if FSL_SOC
> > 	default y if SOC_AU1200
> > 	default y if ARCH_IXP4XX
> > 	default y if ARCH_W90X900
> > --=20
> > 1.7.0.4
>=20
> This really should have been CC'd to the USB list & maintainer.
>=20
> - k
