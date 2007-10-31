Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 697AEDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 23:24:35 +1100 (EST)
Message-ID: <472873B9.5040702@ru.mvista.com>
Date: Wed, 31 Oct 2007 15:23:21 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/4] PowerPC: 440GRx Rainier board support.
References: <20071030164511.GA21973@ru.mvista.com>	<20071030165739.GA22126@ru.mvista.com>
	<20071031141149.a1c85909.sfr@canb.auug.org.au>
In-Reply-To: <20071031141149.a1c85909.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Tue, 30 Oct 2007 19:57:39 +0300 Valentine Barshak <vbarshak@ru.mvista.com> wrote:
>> +++ linux-2.6/arch/powerpc/platforms/44x/rainier.c	2007-10-30 18:00:15.000000000 +0300
>> +#include <linux/init.h>
>> +#include <asm/machdep.h>
>> +#include <asm/prom.h>
>> +#include <asm/udbg.h>
>> +#include <asm/time.h>
>> +#include <asm/uic.h>
>> +#include <asm/of_platform.h>
> 
> You want <linux/of_platform.h>
> 
Oops, apparently this got here from the old sequoia.c
Will correct both.
Thanks,
Valentine.
