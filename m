Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98BC5DDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 01:11:08 +1000 (EST)
Message-ID: <464C6EBA.4000508@freescale.com>
Date: Thu, 17 May 2007 10:03:22 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [i2c] [PATCH 5/5] powerpc: Call of_register_i2c_devices() for
	fsl-i2c.
References: <20070517143911.GE29795@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070517143911.GE29795@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Call of_register_i2c_devices() to register I2C devices on
> the device tree under an fsl-i2c node.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index cad1757..0ab9603 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -340,6 +340,8 @@ static int __init fsl_i2c_of_init(void)
>  						    fsl_i2c_platform_data));
>  		if (ret)
>  			goto unreg;
> +
> +		of_register_i2c_devices(np, i);
>  	}
>  
>  	return 0;

Gah, that isn't the right patch -- I need to stop posting patches before 
noon. :-P

I have one somewhere that calls i2c_alloc_bus_number(), I'll post it 
when I find it.

-Scott
