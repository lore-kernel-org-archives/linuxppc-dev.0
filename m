Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E80E67B6A
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 23:51:32 +1000 (EST)
In-Reply-To: <44B786D6.7040707@freescale.com>
References: <44B786D6.7040707@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6DFEB2BB-05AB-441E-854E-297987B97A0E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix Freescale high-speed USB host dependency
Date: Fri, 14 Jul 2006 08:51:35 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

On Jul 14, 2006, at 6:58 AM, Li Yang wrote:

> The high-speed USB SOC only exists on MPC834x family not MPC83xx  
> family.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
>
> ---
>
>  drivers/usb/host/ehci-hcd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci- 
> hcd.c index 79f2d8b..3af1844 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -892,7 +892,7 @@ #include "ehci-pci.c"
>  #define	EHCI_BUS_GLUED
>  #endif
>
> -#ifdef CONFIG_PPC_83xx
> +#ifdef CONFIG_MPC834x
>  #include "ehci-fsl.c"
>  #define	EHCI_BUS_GLUED
>  #endif
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
