Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C5D6DDDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 08:23:12 +1000 (EST)
Date: Wed, 18 Jul 2007 15:23:10 -0700 (PDT)
Message-Id: <20070718.152310.124381122.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: [RFC 0/3] lro: Generic Large Receive Offload for TCP traffic
	(IPv6)
From: David Miller <davem@davemloft.net>
In-Reply-To: <200707181501.00163.ossthema@de.ibm.com>
References: <20070715091253.GA15790@infradead.org>
	<20070715.024015.126137834.davem@davemloft.net>
	<200707181501.00163.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, meder@de.ibm.com,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Wed, 18 Jul 2007 15:00:59 +0200

> Hi,
> 
> I suggest we keep the interface open for IPv6 support by adding 
> an additional parameter but first just get IPv4 support only 
> into the kernel. IPv6 support can then incrementially be added.
> Would that be ok?

I guess so.
