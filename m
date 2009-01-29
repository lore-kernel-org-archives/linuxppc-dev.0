Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 58CB1DDFB5
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 06:20:35 +1100 (EST)
Date: Thu, 29 Jan 2009 22:20:31 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Reynes Philippe <philippe.reynes@isismpp.fr>
Subject: Re: [PATCH] add gpio to mpc837X rdb
Message-ID: <20090129192031.GA17060@oksana.dev.rtsoft.ru>
References: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 29, 2009 at 06:37:15PM +0100, Reynes Philippe wrote:
> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index 165463f..45c9f03 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -109,6 +109,24 @@
>  			reg = <0x200 0x100>;
>  		};
>  
> +		gpio1: gpio-controller@c00 {
> +			#gpio-cells = <2>;
> +			compatible = "fsl,mpc8347-gpio",

I think this should be "fsl,mpc8377-gpio", "fsl,mpc8349-gpio".

[...]
> --- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> @@ -109,6 +109,24 @@
>  			reg = <0x200 0x100>;
>  		};
>  
> +		gpio1: gpio-controller@c00 {
> +			#gpio-cells = <2>;
> +			compatible = "fsl,mpc8347-gpio",
> "fsl,mpc8349-gpio";

"fsl,mpc8378-gpio", "fsl,mpc8349-gpio".

[...]
> --- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> @@ -107,6 +107,24 @@
>  			reg = <0x200 0x100>;
>  		};
>  
> +		gpio1: gpio-controller@c00 {
> +			#gpio-cells = <2>;
> +			compatible = "fsl,mpc8347-gpio",
> "fsl,mpc8349-gpio";

"fsl,mpc8379-gpio", "fsl,mpc8349-gpio".

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
