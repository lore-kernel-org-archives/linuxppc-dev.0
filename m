Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4A998DDFCD
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 20:27:15 +1000 (EST)
Message-ID: <470CA8BC.2060005@ru.mvista.com>
Date: Wed, 10 Oct 2007 14:26:04 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [RFC][POWERPC] Add arch/powerpc 4xx NDFC (NAND) support
References: <200710100832.13105.sr@denx.de>
In-Reply-To: <200710100832.13105.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
> index 36be75b..9b15482 100644
> --- a/arch/powerpc/boot/dts/sequoia.dts
> +++ b/arch/powerpc/boot/dts/sequoia.dts
> @@ -122,6 +122,38 @@
>  			interrupt-map-mask = <ffffffff>;
>  		};
>  
> +		ndfc@1d0000000, {
> +			device_type = "nand";
> +			compatible = "ibm,ndfc";
> +			reg = <1 d0000000 2000>;

I think this should be handled the way it's done for nor flash, since 
ndfc is relocatable within EBC address space.

Thanks,
Valentine.
