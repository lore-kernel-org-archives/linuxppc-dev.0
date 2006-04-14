Return-Path: <kenneth.w.chen@intel.com>
Received: from azsmga101-1.ch.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id B6178679EF
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 08:22:56 +1000 (EST)
Message-Id: <4t16i2$ma94t@orsmga001.jf.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Steven Rostedt'" <rostedt@goodmis.org>,
	"LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: [PATCH 00/05] robust per_cpu allocation for modules
Date: Fri, 14 Apr 2006 15:12:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
Cc: linux-mips@linux-mips.org, David Mosberger-Tang <davidm@hpl.hp.com>,
	linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, benedict.gaster@superh.com, bjornw@axis.com,
	Ingo Molnar <mingo@elte.hu>, grundler@parisc-linux.org,
	starvik@axis.com, Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	chris@zankel.net, "Luck, Tony" <tony.luck@intel.com>,
	Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt wrote on Friday, April 14, 2006 2:19 PM
> So the current solution has two flaws:
> 1. not robust. If we someday add more modules that together take up
>    more than 14K, we need to manually update the PERCPU_ENOUGH_ROOM.
> 2. waste of memory.  We have 14K of memory wasted per CPU. Remember
>    a 64 processor machine would be wasting 896K of memory!

If someone who has the money to own a 64-process machine, 896K of memory
is pocket change ;-)

- Ken
