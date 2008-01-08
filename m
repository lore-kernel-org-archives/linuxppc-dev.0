Return-Path: <SRS0=J7kT=R6=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 25259DDF6C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:23:54 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Miscellaneous for Taco
Date: Tue, 8 Jan 2008 20:23:11 +0100
References: <477F13C0.7040006@pikatech.com> <1199566583.7291.63.camel@pasglop>
	<4783C3E8.3090107@pikatech.com>
In-Reply-To: <4783C3E8.3090107@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801082023.11475.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 January 2008, Sean MacLennan wrote:
> How about just 44x?
>
> Cheers,
>     Sean
>
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 7580aa5..682deae 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
>         # PPC:
>         default y if STB03xxx
>         default y if PPC_MPC52xx
> +       default y if 44x

No. Not all 44x have OHCI built in. Currently 440EP, 440EPx and 405EZ have it. 
But since your patch only touches 440EP, you should just enable OHCI for 
exactly this platform.

Best regards,
Stefan
