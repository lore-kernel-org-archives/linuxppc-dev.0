Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E1509DDF33
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 08:42:15 +1000 (EST)
Date: Mon, 30 Apr 2007 15:42:15 -0700 (PDT)
Message-Id: <20070430.154215.97292561.davem@davemloft.net>
To: mark@mtfhpc.demon.co.uk
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0704302329390.3178@mtfhpc.demon.co.uk>
References: <20070430145414.88fda272.akpm@linux-foundation.org>
	<20070430.150407.07642146.davem@davemloft.net>
	<Pine.LNX.4.61.0704302329390.3178@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mm@kvack.org, wli@holomorphy.com, linuxppc-dev@ozlabs.org,
	andrea@suse.de, sparclinux@vger.kernel.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 30 Apr 2007 23:33:13 +0100 (BST)

> Is this just sun4c or does it affect other sparc32 architectures.

Only sun4c.

srmmu's update_mmu_cache() is basically a NOP.
