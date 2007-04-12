Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2F6B0DDF41
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 16:25:51 +1000 (EST)
Date: Wed, 11 Apr 2007 23:25:45 -0700 (PDT)
Message-Id: <20070411.232545.45203999.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <1176357020.8061.123.camel@localhost.localdomain>
References: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<1176357020.8061.123.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 12 Apr 2007 15:50:20 +1000

> On Thu, 2007-04-12 at 15:34 +1000, Stephen Rothwell wrote:
> > This creates kernel/openfw.c (depending on CONFIG_OPENFW) and puts the
> > first trivially common bits from the prom.c files into it.
> 
> Is this the right place ?
> 
> I want to split flat DT from live DT in separate files, then we have
> of_device.c and of_platform.c that will need merging too, and possibly
> the filesystem... that's a lot to put in kernel/

We could make drivers/openfw/{device,platform}.c, maybe that would
work best?
