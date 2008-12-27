Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 0107BDDE1F
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Dec 2008 06:32:27 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Sat, 27 Dec 2008 11:32:25 -0800
References: <1227628088-10849-1-git-send-email-sr@denx.de>
In-Reply-To: <1227628088-10849-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812271132.25468.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also:

> +static struct of_platform_driver spi_ppc4xx_of_driver = {
> +       .owner = THIS_MODULE,
> +       .name = DRIVER_NAME,

I'd hope the PPC folk eliminate this duplication soonish.
Those fields are obvious duplicates of the driver model
fields...


> +       .match_table = spi_ppc4xx_of_match,
> +       .probe = spi_ppc4xx_of_probe,
> +       .remove = __exit_p(spi_ppc4xx_of_remove),
> +       .driver = {
> +               .name = DRIVER_NAME,
> +               .owner = THIS_MODULE,
> +       },
> +};
