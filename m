Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 13F5BDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 19:43:44 +1100 (EST)
Date: Fri, 20 Feb 2009 00:43:26 -0800 (PST)
Message-Id: <20090220.004326.246398596.davem@davemloft.net>
To: tklein@de.ibm.com
Subject: Re: [PATCH] ehea: Fix memory hotplug handling
From: David Miller <davem@davemloft.net>
In-Reply-To: <200902191232.12152.tklein@de.ibm.com>
References: <200902191232.12152.tklein@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jeff@garzik.org, themann@de.ibm.com, netdev@vger.kernel.org,
	hering2@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Thomas Klein <tklein@de.ibm.com>
Date: Thu, 19 Feb 2009 12:32:11 +0100

> Added missing set_bit() to disable data transfer when a memchange
> notification is handled
>
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>

Applied to net-next-2.6

But this was a real pain because you never tell me what
tree your changes are destined for.

I assumed since you said "bug fix" you want this in
net-2.6, but of course this patch doesn't apply there
since the driver version is different in that tree.

You can save me all of that trial-and-error wasted time
if you simply say "net-next-2.6" or "net-2.6" either
in the "[PATCH ...]" part of your subject or in the
message body itself.

Thanks.
