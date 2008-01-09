Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5F9CDDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:18:39 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09JIYUx024649
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 14:18:34 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09JISJH073062
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:18:29 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09JIQBx005637
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:18:28 -0700
Date: Wed, 9 Jan 2008 13:18:07 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Miscellaneous for Taco
Message-ID: <20080109131807.4cb2af29@zod.rchland.ibm.com>
In-Reply-To: <478503B6.3060402@pikatech.com>
References: <477F13C0.7040006@pikatech.com> <1199566583.7291.63.camel@pasglop>
	<4783C3E8.3090107@pikatech.com> <200801082023.11475.sr@denx.de>
	<478503B6.3060402@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jan 2008 12:26:14 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

This one needs to go to the linux-usb list and David Brownell.

Although I'm not sure what the benefit here really is.  You can still
set this in the defconfig without adding this patch...  I don't see a
need to do a default.

josh

> ---
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 7580aa5..2660f30 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
>         # PPC:
>         default y if STB03xxx
>         default y if PPC_MPC52xx
> +       default y if 440EP
>         # MIPS:
>         default y if SOC_AU1X00
>         # more:
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
