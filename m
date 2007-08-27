Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CDA05DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 06:37:23 +1000 (EST)
Date: Mon, 27 Aug 2007 13:37:21 -0700 (PDT)
Message-Id: <20070827.133721.59473971.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <200708271147.01890.ossthema@de.ibm.com>
References: <46D1D634.7060007@katalix.com>
	<20070826.185815.93042514.davem@davemloft.net>
	<200708271147.01890.ossthema@de.ibm.com>
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
Date: Mon, 27 Aug 2007 11:47:01 +0200

> So the question is simply: Do we want drivers that need (benefit
> from) a timer based polling support to implement their own timers
> each, or should there be a generic support?

I'm trying to figure out how an hrtimer implementation would
even work.

Would you start the timer from the chip interrupt handler?  If so,
that's taking two steps backwards as you've already taken all of the
overhead of running the interrupt handler.
