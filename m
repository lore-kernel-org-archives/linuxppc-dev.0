Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6990CDDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 07:56:03 +1000 (EST)
Date: Mon, 27 Aug 2007 14:56:00 -0700 (PDT)
Message-Id: <20070827.145600.102570576.davem@davemloft.net>
To: jchapman@katalix.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <46D34517.4010505@katalix.com>
References: <46D2F301.7050105@katalix.com>
	<20070827.140251.95055210.davem@davemloft.net>
	<46D34517.4010505@katalix.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, akepner@sgi.com,
	meder@de.ibm.com, ossthema@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: James Chapman <jchapman@katalix.com>
Date: Mon, 27 Aug 2007 22:41:43 +0100

> I don't recall saying anything in previous posts about this. Are you 
> confusing my posts with Jan-Bernd's?

Yes, my bad.

> Jan-Bernd has been talking about using hrtimers to _reschedule_
> NAPI. My posts are suggesting an alternative mechanism that keeps
> NAPI active (with interrupts disabled) for a jiffy or two after it
> would otherwise have gone idle in order to avoid too many interrupts
> when the packet rate is such that NAPI thrashes between poll-on and
> poll-off.

So in this scheme what runs ->poll() to process incoming packets?
The hrtimer?
