Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A5F50DDF37
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 15:41:06 +1000 (EST)
Date: Wed, 11 Apr 2007 22:41:06 -0700 (PDT)
Message-Id: <20070411.224106.18600196.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070412153424.bf3957f4.sfr@canb.auug.org.au>
References: <20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 12 Apr 2007 15:34:24 +1000

> This creates kernel/openfw.c (depending on CONFIG_OPENFW) and puts the
> first trivially common bits from the prom.c files into it.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

This looks great to me.

Signed-off-by: David S. Miller <davem@davemloft.net>
