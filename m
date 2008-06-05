Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id A7F1DDDF91
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 21:27:36 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so289569ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 04:27:35 -0700 (PDT)
Date: Thu, 5 Jun 2008 06:27:26 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c-ibm_iic: Enable driver for all PPC4xx variants in
	arch/powerpc
Message-ID: <20080605062726.1bf39860@vader.jdub.homelinux.org>
In-Reply-To: <1212653453-26093-1-git-send-email-sr@denx.de>
References: <1212653453-26093-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu,  5 Jun 2008 10:10:53 +0200
Stefan Roese <sr@denx.de> wrote:

> This patch enables the IBM I2C driver for all PPC4xx variants by adding
> "ibm,iic" to the compatible list. This way all currently available
> arch/powerpc 4xx ports can make use of this driver without any changes.
> Additionally all "other" compatible entries are removed since they are
> not needed anymore.
> 
> Currently all 4xx PPC's have the same compatible I2C macro. If at some
> time an incompatibility is detected we can take care of this with an
> additional property.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
> ---
>  drivers/i2c/busses/i2c-ibm_iic.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index 3a364a7..ed73801 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -807,11 +807,7 @@ static int __devexit iic_remove(struct of_device *ofdev)
>  }
>  
>  static const struct of_device_id ibm_iic_match[] = {
> -	{ .compatible = "ibm,iic-405ex", },
> -	{ .compatible = "ibm,iic-405gp", },
> -	{ .compatible = "ibm,iic-440gp", },
> -	{ .compatible = "ibm,iic-440gpx", },
> -	{ .compatible = "ibm,iic-440grx", },
> +	{ .compatible = "ibm,iic", },
>  	{}
>  };
>  
