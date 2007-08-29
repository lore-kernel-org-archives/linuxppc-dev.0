Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1082EDDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 18:29:19 +1000 (EST)
Date: Wed, 29 Aug 2007 01:29:16 -0700 (PDT)
Message-Id: <20070829.012916.02298847.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <46D51BD7.6040904@de.ibm.com>
References: <200708281319.03903.ossthema@de.ibm.com>
	<20070828.132152.38706038.davem@davemloft.net>
	<46D51BD7.6040904@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, jchapman@katalix.com, raisch@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akepner@sgi.com, meder@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Wed, 29 Aug 2007 09:10:15 +0200

> In the end I want to reduce the CPU utilization. And one way
> to do that is LRO which also works only well if there are more
> then just a very few packets to aggregate. So at least our
> driver (eHEA) would benefit from a mix of timer based polling
> and plain NAPI (depending on load situations).
> 
> If there is no need for a generic mechanism for this kind of
> network adapters, then we can just leave this to each device
> driver.

No objections from me either way, if something works then
fine.

Let's come back to this once you have a tested sample implementation
that does what you want, ok?
