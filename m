Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4FF09DE19E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 02:15:31 +1000 (EST)
Message-ID: <4829BED8.4050704@freescale.com>
Date: Tue, 13 May 2008 11:16:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/6] [POWERPC] 86xx: mpc8610_hpcd: add watchdog node
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
	<20080513141511.GF15717@polina.dev.rtsoft.ru>
In-Reply-To: <20080513141511.GF15717@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> index 5030533..a7f3e0e 100644
> --- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> +++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> @@ -195,6 +195,12 @@
>  			fsl,has-rstcr;
>  		};
>  
> +		wdt@e4000 {
> +			device_type = "watchdog";
> +			compatible = "fsl,mpc8610-wdt";
> +			reg = <0xe4000 0x100>;
> +		};
> +

We don't need the device_type anymore.

-Scott
