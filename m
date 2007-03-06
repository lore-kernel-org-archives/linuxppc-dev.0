Return-Path: <tnt@246tNt.com>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AECD6DDF4A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 21:14:43 +1100 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l26AEXe0016614
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Mar 2007 11:14:33 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45ED3EE3.40304@246tNt.com>
Date: Tue, 06 Mar 2007 11:13:55 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] lite5200(b) typos in dts
References: <20070306095139.GZ4397@moe.telargo.com>
In-Reply-To: <20070306095139.GZ4397@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domen Puncer wrote:
> Fix lite5200(b) copy paste typos in dts.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>   
Acked-by: Sylvain Munaut <tnt@246tNt.com>

Obviously correct ...

> ---
>  arch/powerpc/boot/dts/lite5200.dts  |    2 +-
>  arch/powerpc/boot/dts/lite5200b.dts |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Index: grant.git/arch/powerpc/boot/dts/lite5200.dts
> ===================================================================
> --- grant.git.orig/arch/powerpc/boot/dts/lite5200.dts
> +++ grant.git/arch/powerpc/boot/dts/lite5200.dts
> @@ -179,7 +179,7 @@
>  			interrupt-parent = <500>;
>  		};
>  
> -		gpio-wkup@b00 {
> +		gpio-wkup@c00 {
>  			compatible = "mpc5200-gpio-wkup";
>  			reg = <c00 40>;
>  			interrupts = <1 8 0 0 3 0>;
> Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
> ===================================================================
> --- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
> +++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
> @@ -179,7 +179,7 @@
>  			interrupt-parent = <500>;
>  		};
>  
> -		gpio-wkup@b00 {
> +		gpio-wkup@c00 {
>  			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
>  			reg = <c00 40>;
>  			interrupts = <1 8 0 0 3 0>;
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
