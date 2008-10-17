Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E26FCDDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 19:55:35 +1100 (EST)
Date: Fri, 17 Oct 2008 10:55:07 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] [RESEND] i2c-cpm: Suppress autoprobing for devices
Message-ID: <20081017105507.5579267b@hyperion.delvare>
In-Reply-To: <20081016191200.GB13629@pengutronix.de>
References: <20081016111300.GC3432@pengutronix.de>
	<20081016191200.GB13629@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfram,

On Thu, 16 Oct 2008 21:12:00 +0200, Wolfram Sang wrote:
> Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also remove
> automatic probing for this i2c controller. Might need updates to dts files
> using it.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Jochen Friedrich <jochen@scram.de>
> ---
> Resend with cc to i2c.
> 
>  drivers/i2c/busses/i2c-cpm.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: linux-2.6/drivers/i2c/busses/i2c-cpm.c
> ===================================================================
> --- linux-2.6.orig/drivers/i2c/busses/i2c-cpm.c
> +++ linux-2.6/drivers/i2c/busses/i2c-cpm.c
> @@ -423,7 +423,6 @@ static const struct i2c_adapter cpm_ops 
>  	.owner		= THIS_MODULE,
>  	.name		= "i2c-cpm",
>  	.algo		= &cpm_i2c_algo,
> -	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
>  };
>  
>  static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)

Acked-by: Jean Delvare <khali@linux-fr.org>

I guess you do _not_ want me to push this patch upstream now and it
better goes through the powerpc tree to allow a synchronization with
dts file changes?

If I'm wrong and you want me to take this patch in my tree then please
tell me.

-- 
Jean Delvare
