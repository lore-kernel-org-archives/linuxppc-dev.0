Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B61DCDDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 05:35:56 +1100 (EST)
Message-Id: <D6E6BC8F-1BDE-4752-950C-FBD609FD4EFD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080122183141.GB17036@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] adder875: Fix flash bus-width and remove duplicate
	__initdata.
Date: Tue, 22 Jan 2008 12:33:30 -0600
References: <20080122183141.GB17036@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 12:31 PM, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/dts/adder875-redboot.dts |    2 +-
> arch/powerpc/boot/dts/adder875-uboot.dts   |    2 +-
> arch/powerpc/platforms/8xx/adder875.c      |    2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts b/arch/ 
> powerpc/boot/dts/adder875-redboot.dts
> index 8f7a79f..930bfb3 100644
> --- a/arch/powerpc/boot/dts/adder875-redboot.dts
> +++ b/arch/powerpc/boot/dts/adder875-redboot.dts
> @@ -62,7 +62,7 @@
> 		flash@0,0 {
> 			compatible = "cfi-flash";
> 			reg = <0 0 0x800000>;
> -			bank-width = <4>;
> +			bank-width = <2>;
> 			device-width = <2>;
> 		};
> 	};

I'm assuming the bank-width was just wrong before?

- k
