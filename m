Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5866EDDDF9
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:35:27 +1000 (EST)
In-Reply-To: <20071004134115.cc099dd1.sfr@canb.auug.org.au>
References: <1191442173.21463.77.camel@ld0161-tx32>
	<20071004134115.cc099dd1.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <44FE7AFC-1883-49A1-A781-6D966653EDF4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add initial MPC8610 HPCD Platform files.
Date: Wed, 3 Oct 2007 23:35:18 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Xianghua Xiao <x.xiao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 10:41 PM, Stephen Rothwell wrote:

> On Wed, 03 Oct 2007 15:09:33 -0500 Jon Loeliger <jdl@freescale.com>  
> wrote:
>>
>> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
>> +#include <linux/stddef.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/kdev_t.h>
>> +#include <linux/delay.h>
>> +#include <linux/seq_file.h>
>> +
>> +#include <asm/system.h>
>> +#include <asm/time.h>
>> +#include <asm/machdep.h>
>> +#include <asm/pci-bridge.h>
>> +#include <asm/mpc86xx.h>
>> +#include <asm/prom.h>
>
> You should include linux/of.h as well to use the of_ accessor  
> functions.

added.

- k
