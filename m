Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D9C57DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 16:26:19 +1100 (EST)
Date: Tue, 19 Feb 2008 21:26:55 -0800 (PST)
Message-Id: <20080219.212655.173468988.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] [LMB]: Fix lmb_add_region if region should be added at
	the head
From: David Miller <davem@davemloft.net>
In-Reply-To: <7A7ECF09-E547-4C04-A388-C3E8755478DD@kernel.crashing.org>
References: <Pine.LNX.4.64.0802192227170.2215@blarg.am.freescale.net>
	<20080219.204525.193731674.davem@davemloft.net>
	<7A7ECF09-E547-4C04-A388-C3E8755478DD@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 19 Feb 2008 23:16:18 -0600

> The for loop above the code I added will move all the existing slots  
> up one.  Its just the tail cleanup we are missing.

Aha, I see how this works now, thanks!

I'll add this to my LMB tree.
