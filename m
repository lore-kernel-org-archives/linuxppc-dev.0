Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6880FDDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 19:24:08 +1000 (EST)
Date: Thu, 24 Apr 2008 02:24:04 -0700 (PDT)
Message-Id: <20080424.022404.151729194.davem@davemloft.net>
To: johannes@sipsolutions.net
Subject: Re: cpu_clock confusion
From: David Miller <davem@davemloft.net>
In-Reply-To: <1209028912.3357.52.camel@johannes.berg>
References: <1207240450.3797.22.camel@johannes.berg>
	<20080404144641.GA15844@elte.hu>
	<1209028912.3357.52.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, benh@ozlabs.org, linuxppc-dev@ozlabs.org,
	arndb@de.ibm.com, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 24 Apr 2008 11:21:52 +0200

> Hmm. Why is that whole cpu_clock stuff in place anyway? powerpc has
> perfectly synchronised time across processors with dirt cheap access to
> it as well, so why build all this code that only messes it up on top of
> it?

Same on sparc64.  These changes add more bugs than they fix.
