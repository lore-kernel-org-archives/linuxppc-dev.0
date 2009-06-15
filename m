Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C8E4DB7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 16:31:56 +1000 (EST)
Subject: Re: [PATCH 24/33] usb/ps3: Add missing annotations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 16:31:41 +1000
Message-Id: <1245047501.19217.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 16:38 +0200, Geert Uytterhoeven wrote:
> probe functions should be __devinit
> initialization functions should be __init

Please send to USB maintainers or get an ack from them.

Cheers,
Ben.

> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Cc: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  drivers/usb/host/ehci-ps3.c |    4 ++--
>  drivers/usb/host/ohci-ps3.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
> index bb870b8..3e8844e 100644
> --- a/drivers/usb/host/ehci-ps3.c
> +++ b/drivers/usb/host/ehci-ps3.c
> @@ -76,7 +76,7 @@ static const struct hc_driver ps3_ehci_hc_driver = {
>  	.port_handed_over	= ehci_port_handed_over,
>  };
>  
> -static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
> +static int __devinit ps3_ehci_probe(struct ps3_system_bus_device *dev)
>  {
>  	int result;
>  	struct usb_hcd *hcd;
> @@ -224,7 +224,7 @@ static int ps3_ehci_remove(struct ps3_system_bus_device *dev)
>  	return 0;
>  }
>  
> -static int ps3_ehci_driver_register(struct ps3_system_bus_driver *drv)
> +static int __init ps3_ehci_driver_register(struct ps3_system_bus_driver *drv)
>  {
>  	return firmware_has_feature(FW_FEATURE_PS3_LV1)
>  		? ps3_system_bus_driver_register(drv)
> diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
> index 1d56259..7009504 100644
> --- a/drivers/usb/host/ohci-ps3.c
> +++ b/drivers/usb/host/ohci-ps3.c
> @@ -75,7 +75,7 @@ static const struct hc_driver ps3_ohci_hc_driver = {
>  #endif
>  };
>  
> -static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
> +static int __devinit ps3_ohci_probe(struct ps3_system_bus_device *dev)
>  {
>  	int result;
>  	struct usb_hcd *hcd;
> @@ -224,7 +224,7 @@ static int ps3_ohci_remove(struct ps3_system_bus_device *dev)
>  	return 0;
>  }
>  
> -static int ps3_ohci_driver_register(struct ps3_system_bus_driver *drv)
> +static int __init ps3_ohci_driver_register(struct ps3_system_bus_driver *drv)
>  {
>  	return firmware_has_feature(FW_FEATURE_PS3_LV1)
>  		? ps3_system_bus_driver_register(drv)
