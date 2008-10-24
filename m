Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4AB9BDDDEA
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:18:38 +1100 (EST)
Date: Fri, 24 Oct 2008 16:18:13 -0700 (PDT)
Message-Id: <20081024.161813.193686281.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: David Miller <davem@davemloft.net>
In-Reply-To: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, maxk@qualcomm.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 24 Oct 2008 10:57:38 -0500

> Commit 18404756765c713a0be4eb1082920c04822ce588 introduced a regression
> on a subset of SMP based PPC systems whose interrupt controller only
> allow setting an irq to a single processor.  The previous behavior
> was only CPU0 was initially setup to get interrupts.  Revert back
> to that behavior.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

I really don't remember getting all of my interrupts only on cpu 0
on sparc64 before any of these changes.  I therefore find all of
this quite mysterious. :-)
