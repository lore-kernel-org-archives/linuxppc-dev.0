Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id B2827DE272
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 19:14:30 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: avorontsov@ru.mvista.com
Subject: Re: [spi-devel-general] [PATCH v5] spi: Add PPC4xx SPI driver
Date: Tue, 6 Jan 2009 09:14:19 +0100
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<20090106020603.GA14074@oksana.dev.rtsoft.ru>
In-Reply-To: <20090106020603.GA14074@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901060914.19435.sr@denx.de>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

On Tuesday 06 January 2009, Anton Vorontsov wrote:
> > This adds a SPI driver for the SPI controller found in the IBM/AMCC
> > 4xx PowerPC's.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> > Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > ---
>
> [...]
>
> > +static unsigned int of_num_gpios(struct device_node *node)
> > +{
> > +	unsigned int num = 0;
> > +
> > +	while (gpio_is_valid(of_get_gpio(node, num)))
> > +		num++;
> > +	return num;
> > +}
>
> FYI, as of commit 749820928a2fd47ff536773d869d2c3f8038b7d1 ("of/gpio:
> Implement of_gpio_count()") you can use of_gpio_count() from
> linux/of_gpio.h.

Thanks for the hint. I'll use it in the next version.

Best regards,
Stefan
