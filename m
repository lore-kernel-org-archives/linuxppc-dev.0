Return-Path: <joe@perches.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CD801B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 13:01:36 +1000 (EST)
Received: from mail.perches.com (136-022.dsl.LABridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id D9350DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 13:01:34 +1000 (EST)
Subject: Re: [PATCH] usb/gadget: Update Freescale UDC entry in MAINTAINERS
From: Joe Perches <joe@perches.com>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1249960271-3400-1-git-send-email-leoli@freescale.com>
References: <1249960271-3400-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 20:00:15 -0700
Message-Id: <1249959615.8895.140.camel@Joe-Laptop.home>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, lg@denx.de,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-11 at 11:11 +0800, Li Yang wrote:
> Change the F entry for file rename, and make it also cover fsl_qe_udc
> driver.  Update the name accordingly.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Liakhovetski,
> 
> Is it ok that it also covers your fsl_mx3_udc.c file.  It's much easier
> to use the wildcard.
>  MAINTAINERS |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1114cf..cf1e22c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2067,12 +2067,12 @@ S:	Supported
>  F:	arch/powerpc/sysdev/qe_lib/
>  F:	arch/powerpc/include/asm/*qe.h
>  
> -FREESCALE HIGHSPEED USB DEVICE DRIVER
> +FREESCALE USB PERIPHERIAL DRIVERS
>  M:	Li Yang <leoli@freescale.com>
>  L:	linux-usb@vger.kernel.org
>  L:	linuxppc-dev@ozlabs.org
>  S:	Maintained
> -F:	drivers/usb/gadget/fsl_usb2_udc.c
> +F:	drivers/usb/gadget/fsl*

If you want, you can add an "X:" entry as well

X:	drivers/usb/gadget/fsl_mx3_udc.c

which excludes that file.

Excludes are tested before includes.
