Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56584DDF51
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 17:00:48 +1000 (EST)
In-Reply-To: <20070411.232545.45203999.davem@davemloft.net>
References: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<1176357020.8061.123.camel@localhost.localdomain>
	<20070411.232545.45203999.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <17cfcd2e089f7154354fe6c4c1cadf3c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start split out of common open firmware code
Date: Thu, 12 Apr 2007 09:00:45 +0200
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> This creates kernel/openfw.c (depending on CONFIG_OPENFW) and puts 
>>> the
>>> first trivially common bits from the prom.c files into it.
>>
>> Is this the right place ?
>>
>> I want to split flat DT from live DT in separate files, then we have
>> of_device.c and of_platform.c that will need merging too, and possibly
>> the filesystem... that's a lot to put in kernel/
>
> We could make drivers/openfw/{device,platform}.c, maybe that would
> work best?

drivers/ is the wrong place to put this IMHO.  Why not
use kernel/openfirmware/*.[ch] ?


Segher
