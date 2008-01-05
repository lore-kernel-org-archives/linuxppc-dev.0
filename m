Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A513ADDF02
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 05:39:18 +1100 (EST)
Message-ID: <477FCED5.6080005@pikatech.com>
Date: Sat, 05 Jan 2008 13:39:17 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Hwmon for Taco
References: <477F1196.7000109@pikatech.com> <1199517763.7291.47.camel@pasglop>
In-Reply-To: <1199517763.7291.47.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> +module_exit(ad7414_exit);
>> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
>> +++ drivers/hwmon/taco-dtm.c	2008-01-05 00:06:21.000000000 -0500
>> @@ -0,0 +1,78 @@
>> +/*
>> + *  drivers/hwmon/taco-dtm.c
>> + *
>> + *  Overview: On the Taco, the fpga controls the fan. This provides
>> + *  the temperature to the fpga.
>> + *
>> + *  Copyright (c) 2008 PIKA Technologies
>> + *    Sean MacLennan <smaclennan@pikatech.com>
>> + *
>> + *  This program is free software; you can redistribute	 it and/or modify it
>> + *  under  the terms of	 the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the	License, or (at your
>> + *  option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kthread.h>
>> +#include <linux/io.h>
>> +
>> +
>> +#define TACO_FPGA_BASE 0x80000000
>>     
>
> That should be in the device-tree...
>
> Cheers,
> Ben.
>
>
>   
It is in the device tree, I just forgot to update the driver to use it. 
Thanks.

Cheers,
    Sean
