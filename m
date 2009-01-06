Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A3471DE398
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 13:06:06 +1100 (EST)
Date: Tue, 6 Jan 2009 05:06:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [spi-devel-general] [PATCH v5] spi: Add PPC4xx SPI driver
Message-ID: <20090106020603.GA14074@oksana.dev.rtsoft.ru>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1227628088-10849-1-git-send-email-sr@denx.de>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stefan,

On Tue, Nov 25, 2008 at 04:48:08PM +0100, Stefan Roese wrote:
> This adds a SPI driver for the SPI controller found in the IBM/AMCC
> 4xx PowerPC's.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
[...]
> +static unsigned int of_num_gpios(struct device_node *node)
> +{
> +	unsigned int num = 0;
> +
> +	while (gpio_is_valid(of_get_gpio(node, num)))
> +		num++;
> +	return num;
> +}

FYI, as of commit 749820928a2fd47ff536773d869d2c3f8038b7d1 ("of/gpio:
Implement of_gpio_count()") you can use of_gpio_count() from
linux/of_gpio.h.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
