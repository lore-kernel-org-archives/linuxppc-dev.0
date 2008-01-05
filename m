Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37A1FDDE41
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 18:22:57 +1100 (EST)
Subject: Re: [PATCH] Hwmon for Taco
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <477F1196.7000109@pikatech.com>
References: <477F1196.7000109@pikatech.com>
Content-Type: text/plain
Date: Sat, 05 Jan 2008 18:22:43 +1100
Message-Id: <1199517763.7291.47.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +module_exit(ad7414_exit);
> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
> +++ drivers/hwmon/taco-dtm.c	2008-01-05 00:06:21.000000000 -0500
> @@ -0,0 +1,78 @@
> +/*
> + *  drivers/hwmon/taco-dtm.c
> + *
> + *  Overview: On the Taco, the fpga controls the fan. This provides
> + *  the temperature to the fpga.
> + *
> + *  Copyright (c) 2008 PIKA Technologies
> + *    Sean MacLennan <smaclennan@pikatech.com>
> + *
> + *  This program is free software; you can redistribute	 it and/or modify it
> + *  under  the terms of	 the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the	License, or (at your
> + *  option) any later version.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kthread.h>
> +#include <linux/io.h>
> +
> +
> +#define TACO_FPGA_BASE 0x80000000

That should be in the device-tree...

Cheers,
Ben.
