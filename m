Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D552DE073
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 04:57:46 +1000 (EST)
Message-ID: <4828935D.1090807@freescale.com>
Date: Mon, 12 May 2008 13:58:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
In-Reply-To: <20080512185206.GA25818@polina.dev.rtsoft.ru>
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
> +	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
> +#ifdef CONFIG_PPC_86xx
> +	if (!enabled) {
> +		dev_info(&dev->dev, "could not be enabled by software\n");
> +		ret = -ENOSYS;
> +		goto err_unmap;
> +	}
> +#endif

What happens on an 83xx+86xx multiplatform kernel?

-Scott
