Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5A738DDE44
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 14:18:04 +1000 (EST)
Date: Wed, 17 Oct 2007 21:18:00 -0700 (PDT)
Message-Id: <20071017.211800.82798845.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 1/2] [SPARC/64] Consolidate of_register_driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071017134123.cfe10b79.sfr@canb.auug.org.au>
References: <20071017134123.cfe10b79.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, wli@holomorphy.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Oct 2007 13:41:23 +1000

> Also of_unregister_driver.  These will be shortly also used by the
> PowerPC code.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I'll apply this and push it onward, thanks Stephen!
