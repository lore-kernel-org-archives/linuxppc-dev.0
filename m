Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49C79DE336
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 12:22:00 +1000 (EST)
Message-Id: <DE6DE6FC-5C49-41B6-A866-BBB496F67E72@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: cbouatmailru@gmail.com
In-Reply-To: <20080417224106.GA22438@zarina>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Date: Thu, 17 Apr 2008 21:21:40 -0500
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192904.GD28286@polina.dev.rtsoft.ru>
	<A46A6C3E-E5A7-48FB-9B13-475D442F53EC@kernel.crashing.org>
	<20080417224106.GA22438@zarina>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2008, at 5:41 PM, Anton Vorontsov wrote:
> On Thu, Apr 17, 2008 at 05:35:53PM -0500, Kumar Gala wrote:
>>> index a3f9c3f..a4a195a 100644
>>> --- a/arch/powerpc/sysdev/qe_lib/qe_io.c
>>> +++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
>>> @@ -20,7 +20,8 @@
>>> #include <linux/errno.h>
>>> #include <linux/module.h>
>>> #include <linux/ioport.h>
>>> -
>>> +#include <linux/spinlock.h>
>>> +#include <linux/of_gpio.h>
>>> #include <asm/io.h>
>>> #include <asm/qe.h>
>>> #include <asm/prom.h>
>>> @@ -214,6 +215,140 @@ int par_io_of_config(struct device_node *np)
>>> }
>>> EXPORT_SYMBOL(par_io_of_config);
>>
>> can we split this out into a new file since its pretty much a driver.
>
> No problem. Would you prefer this to go under drivers/gpio/ ?


Yes that would be better.  We actively worked on pull drivers out of  
arch/ppc back in the day.

- k
