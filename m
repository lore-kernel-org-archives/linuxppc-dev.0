Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 61F3FDDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 06:27:33 +1000 (EST)
Date: Fri, 18 May 2007 13:27:34 -0700 (PDT)
Message-Id: <20070518.132734.34602464.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <32E780BE-58B7-4303-AA49-1852C4C7EB50@kernel.crashing.org>
References: <464DB800.40702@genesi-usa.com> <1179499713.12981.75.camel@chaos>
	<32E780BE-58B7-4303-AA49-1852C4C7EB50@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 18 May 2007 11:31:19 -0500

> I asked this earlier, but figured you might have a better insight.   
> Is their value in having 'drivers' for more than one clock source?   
> I'd say most (of not all) the PPC SoCs have timers on the system side  
> that we could provide drivers for, I'm just not sure if that does  
> anything for anyone.

I'm in a similar situation on sparc64, so I'm interested in
this as well :-)
