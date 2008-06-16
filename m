Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4FECDDF2B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 07:41:28 +1000 (EST)
Message-ID: <4856DCD1.50402@freescale.com>
Date: Mon, 16 Jun 2008 16:36:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] 85xx: publish of device for cds platforms
References: <20080616213134.GA22354@blade.az.mvista.com>
In-Reply-To: <20080616213134.GA22354@blade.az.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Jiang wrote:
> +static struct of_device_id __initdata of_bus_ids[] = {
> +	{ .type = "soc", },
> +	{ .compatible = "soc", },
> +	{},
> +};

Also add .compatible = "simple-bus".

-Scott
