Return-Path: <kumar.gala@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86541B712D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Jan 2011 03:22:56 +1100 (EST)
Subject: Re: [PATCH] USB: Fix USB Kconfig dependency problem on 85xx/QoirQ
	platforms
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1294654017-32568-1-git-send-email-B33228@freescale.com>
Date: Mon, 10 Jan 2011 10:22:40 -0600
Message-ID: <F4B27091-DAAF-4E0C-A726-C7111161210C@freescale.com>
References: <1294654017-32568-1-git-send-email-B33228@freescale.com>
To: Xulei Lei-B33228 <B33228@freescale.com>
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


On Jan 10, 2011, at 4:06 AM, Xulei wrote:

> For FSL PPC SoCs USB_ARCH_HAS_EHCI currently on depends on PPC_83xx.
> However that excludes support for USB on 85xx & QorIQ devices.  Use
> FSL_SOC insted which will get us 83xx, 85xx, QorIQ, and 5xxx which all
> have the same USB IP on them.
> 
> Signed-off-by: Xulei <B33228@freescale.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> ---
> drivers/usb/Kconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 6a58cb1..d513d3a 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -57,7 +57,7 @@ config USB_ARCH_HAS_OHCI
> # some non-PCI hcds implement EHCI
> config USB_ARCH_HAS_EHCI
> 	boolean
> -	default y if PPC_83xx
> +	default y if FSL_SOC
> 	default y if SOC_AU1200
> 	default y if ARCH_IXP4XX
> 	default y if ARCH_W90X900
> -- 
> 1.7.0.4

This really should have been CC'd to the USB list & maintainer.

- k
