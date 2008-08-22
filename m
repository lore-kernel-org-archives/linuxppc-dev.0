Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E1011DE139
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 14:21:40 +1000 (EST)
Date: Thu, 21 Aug 2008 21:21:39 -0700 (PDT)
Message-Id: <20080821.212139.41529744.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3]: Sparc OF I2C support v2.
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, paulus@samba.org, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ok, I've integrated the feedback I got from various reviewers and for
now I'm going to handle the sparc vs. powerpc aspects with a helper
asm/of_i2c.h header file that implements the address fetching.

I think for the time being this is the best solution.  If the
semantics converge, we can merge the logic back into the generic code.

Signed-off-by: David S. Miller <davem@davemloft.net>
