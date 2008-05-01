Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC35EDDE10
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 11:30:27 +1000 (EST)
Message-Id: <D069945D-A47A-4782-91B5-F3D4209F6003@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080501111817.e0d19258.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] [POWERPC] devres: Add devm_ioremap_flags()
Date: Wed, 30 Apr 2008 20:29:56 -0500
References: <Pine.LNX.4.64.0804301106010.22992@blarg.am.freescale.net>
	<20080501111817.e0d19258.sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, htejun@gmail.com,
	Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Emilian.Medve@Freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 8:18 PM, Stephen Rothwell wrote:
> On Wed, 30 Apr 2008 11:08:51 -0500 (CDT) Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> +++ b/arch/powerpc/lib/devres.c
>> @@ -0,0 +1,33 @@
>> +#include <linux/device.h>	/* devres_*(), devm_ioremap_release() */
>> +#include <linux/io.h>		/* ioremap_flags() */
>> +#include <linux/module.h>	/* EXPORT_SYMBOL() */
>
> This file needs a copyright notice and license ...

agreed.  will add.

- k
