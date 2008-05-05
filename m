Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47044DDE07
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 18:26:56 +1000 (EST)
Subject: Re: [PATCH]: PPC_OF protect USB driver...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080505.005715.215572318.davem@davemloft.net>
References: <20080505.005715.215572318.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 05 May 2008 18:26:49 +1000
Message-Id: <1209976009.21644.61.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-05 at 00:57 -0700, David Miller wrote:
> This uses APIs that are not generic, or at least not part of
> what Sparc provides yet.
> 
> So just PPC_OF this for now just like the EHCI_OF driver.
> 
> This fixes allmodconfig build errors on sparc.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 33b467a..1ef6df3 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -129,7 +129,7 @@ config USB_ISP1760_PCI
>  
>  config USB_ISP1760_OF
>  	bool "Support for the OF platform bus"
> -	depends on USB_ISP1760_HCD && OF
> +	depends on USB_ISP1760_HCD && PPC_OF
>  	---help---
>  	  Enables support for the device present on the PowerPC
>  	  OpenFirmware platform bus.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
