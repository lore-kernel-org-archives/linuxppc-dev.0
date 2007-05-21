Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.5.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2501EDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 May 2007 17:45:56 +1000 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4L7jg3Y003011
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 May 2007 09:45:45 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <46514E26.6050704@246tNt.com>
Date: Mon, 21 May 2007 09:45:42 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] unbreak lite5200 dts (_pic vs. -pic)
References: <20070521065600.GD20713@moe.telargo.com>
In-Reply-To: <20070521065600.GD20713@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Acked-by: Sylvain Munaut <tnt@246tNt.com>


Paul, can you pick this up for you next send ? Here's the patchwork link
in case
you don't follow -embedded.

http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11248

    Sylvain

Domen Puncer wrote:
> Unbreak lite5200 dts, which were broken by
> 5c1992f83304cf2d56934dd6c06709b96e1b0c81
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> ---
>  arch/powerpc/boot/dts/lite5200.dts  |    2 +-
>  arch/powerpc/boot/dts/lite5200b.dts |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200.dts
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200.dts
> +++ work-powerpc.git/arch/powerpc/boot/dts/lite5200.dts
> @@ -67,7 +67,7 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  			device_type = "interrupt-controller";
> -			compatible = "mpc5200_pic";
> +			compatible = "mpc5200-pic";
>  			reg = <500 80>;
>  			built-in;
>  		};
> Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
> +++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> @@ -67,7 +67,7 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  			device_type = "interrupt-controller";
> -			compatible = "mpc5200b-pic\0mpc5200_pic";
> +			compatible = "mpc5200b-pic\0mpc5200-pic";
>  			reg = <500 80>;
>  			built-in;
>  		};
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
