Return-Path: <scottwood@freescale.com>
Message-ID: <463237EA.4010102@freescale.com>
Date: Fri, 27 Apr 2007 12:50:34 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Small cleanups to the cuboot bootwrapper code
References: <20070427020154.GA20608@localhost.localdomain>
In-Reply-To: <20070427020154.GA20608@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> Index: working-2.6/arch/powerpc/boot/Makefile
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/Makefile	2007-04-27 11:48:56.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/Makefile	2007-04-27 11:57:41.000000000 +1000
> @@ -129,7 +129,8 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
>  image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
>  image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
>  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
> -image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
> +image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
> +image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage

You need to update BOOT_TARGETS in arch/powerpc/Makefile as well.
Otherwise, it looks good.

-Scott
