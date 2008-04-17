Return-Path: <cbouatmailru@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by ozlabs.org (Postfix) with ESMTP id 0BBC5DE2AA
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 08:41:13 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so383812fkz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 15:41:12 -0700 (PDT)
Date: Fri, 18 Apr 2008 02:41:06 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080417224106.GA22438@zarina>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192904.GD28286@polina.dev.rtsoft.ru>
	<A46A6C3E-E5A7-48FB-9B13-475D442F53EC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <A46A6C3E-E5A7-48FB-9B13-475D442F53EC@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 05:35:53PM -0500, Kumar Gala wrote:
>> index a3f9c3f..a4a195a 100644
>> --- a/arch/powerpc/sysdev/qe_lib/qe_io.c
>> +++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
>> @@ -20,7 +20,8 @@
>> #include <linux/errno.h>
>> #include <linux/module.h>
>> #include <linux/ioport.h>
>> -
>> +#include <linux/spinlock.h>
>> +#include <linux/of_gpio.h>
>> #include <asm/io.h>
>> #include <asm/qe.h>
>> #include <asm/prom.h>
>> @@ -214,6 +215,140 @@ int par_io_of_config(struct device_node *np)
>> }
>> EXPORT_SYMBOL(par_io_of_config);
>
> can we split this out into a new file since its pretty much a driver.

No problem. Would you prefer this to go under drivers/gpio/ ?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
