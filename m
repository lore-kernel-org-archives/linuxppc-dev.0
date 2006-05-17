Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id 2C08C67A63
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 01:50:55 +1000 (EST)
Date: Wed, 17 May 2006 08:49:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.58.0605171104100.13160@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0605170846190.13337@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
	<Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0605171104100.13160@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benedict.gaster@superh.com, sam@ravnborg.org, bjornw@axis.com,
	kenneth.w.chen@intel.com, Ingo Molnar <mingo@elte.hu>,
	kiran@scalex86.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	grundler@parisc-linux.org, arnd@arndb.de,
	Rusty Russell <rusty@rustcorp.com.au>, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
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

On Wed, 17 May 2006, Steven Rostedt wrote:

> OK, now I'm just rambling. I don't know,  have any other ideas on making
> this more robust?  Or is this all in vain, and I should spend my evenings
> walking around this beautiful town of Karlsruhe ;)

Well I'd like to see a comprehensive solution including a fix for the 
problems with allocper_cpu() allocations (allocper_cpu has to allocate 
memory for potential processors... which could be a lot on 
some types of systems and its allocated somewhere not on the nodes of the 
processor since they may not yet be online).

Wish I could be back home in Germany to talk a walk with you. Are you 
coming to the OLS?
