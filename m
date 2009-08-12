Return-Path: <g.liakhovetski@gmx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C0124B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 05:40:26 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 99E29DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 05:40:24 +1000 (EST)
Date: Wed, 12 Aug 2009 21:40:14 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] usb/gadget: Update Freescale UDC entry in MAINTAINERS
In-Reply-To: <1249960271-3400-1-git-send-email-leoli@freescale.com>
Message-ID: <Pine.LNX.4.64.0908122139160.27544@axis700.grange>
References: <1249960271-3400-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: joe@perches.com, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 11 Aug 2009, Li Yang wrote:

> Change the F entry for file rename, and make it also cover fsl_qe_udc
> driver.  Update the name accordingly.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Liakhovetski,
> 
> Is it ok that it also covers your fsl_mx3_udc.c file.  It's much easier
> to use the wildcard.

Sure, no problem, if you like

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

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
>  
>  FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
>  M:	Li Yang <leoli@freescale.com>
> -- 
> 1.6.3.1.6.g4bf1f
> 
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
