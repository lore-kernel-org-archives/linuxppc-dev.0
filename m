Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1FEACDDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 08:30:27 +1000 (EST)
Date: Fri, 14 Sep 2007 15:30:25 -0700 (PDT)
Message-Id: <20070914.153025.41635808.davem@davemloft.net>
To: akpm@linux-foundation.org
Subject: Re: Define termios_1 functions for powerpc, s390, avr32 and frv
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070914151253.d7943119.akpm@linux-foundation.org>
References: <20070913035506.b599e84f.akpm@linux-foundation.org>
	<20070914.113324.104043149.davem@davemloft.net>
	<20070914151253.d7943119.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mikey@neuling.org, hskinnemoen@atmel.com, torvalds@linux-foundation.org,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org, paulus@samba.org,
	alan@redhat.com, jdi@l4x.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 14 Sep 2007 15:12:53 -0700

> That fixes sparc, but I think other architectures are still broken.  And if
> we use Tony's ifdef patch to fix the other architectures, that makes the
> above sparc-fix patch unneeded.
> 
> argh.

I don't care if we use Tony's fix or mine, both are fine.

What I do care about is that I spent 24 hours on trains and
planes, only to find more than a day later that Sparc still
didn't build.
