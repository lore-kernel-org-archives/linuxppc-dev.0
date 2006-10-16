Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7AB967C09
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 08:58:18 +1000 (EST)
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0610161554580.6266@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0610161554580.6266@ld0175-tx32.am.freescale.net>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 08:58:10 +1000
Message-Id: <1161039490.7195.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +void of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
> +{
> +	r->start = r->end = irq_of_parse_and_map(dev, index);
> +	r->flags = IORESOURCE_IRQ;
> +}
> +

What about having that one in prom_parse.c ?

Ben.
