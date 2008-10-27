Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DF721DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 06:49:45 +1100 (EST)
Date: Mon, 27 Oct 2008 12:49:22 -0700 (PDT)
Message-Id: <20081027.124922.116478297.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: David Miller <davem@davemloft.net>
In-Reply-To: <B6F01D86-7B36-40E8-9440-CA371B08B1C8@kernel.crashing.org>
References: <4905FC15.3020702@nortel.com>
	<20081027.112823.178324048.davem@davemloft.net>
	<B6F01D86-7B36-40E8-9440-CA371B08B1C8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kevdig@hypersurf.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 27 Oct 2008 14:43:29 -0500

> I haven't been following the netdev patches, but what about HW that does flow separation w/o multiple interrupts?
> 
> We (Freescale) are working on such a device:
> 
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?fastpreview=1&code=P4080

It could probably tie into the software based flow seperation support.
