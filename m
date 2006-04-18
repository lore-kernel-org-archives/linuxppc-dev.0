Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-02.nyroc.rr.com (ms-smtp-02.nyroc.rr.com [24.24.2.56])
	by ozlabs.org (Postfix) with ESMTP id 7D92F679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 11:51:29 +1000 (EST)
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0604171647330.31773@schroedinger.engr.sgi.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
	<20060417220238.GD3945@localhost.localdomain>
	<Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
	<Pine.LNX.4.64.0604171647330.31773@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 21:51:23 -0400
Message-Id: <1145325083.17085.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Ravikiran G Thirumalai <kiran@scalex86.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	starvik@axis.com, Linus Torvalds <torvalds@osdl.org>,
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

On Mon, 2006-04-17 at 16:48 -0700, Christoph Lameter wrote:
> On Mon, 17 Apr 2006, Steven Rostedt wrote:
> 
> > So now we can focus on a better solution.
> 
> Could you have a look at Kiran's work?
> 
> Maybe one result of your work could be that the existing indirection
> for alloc_percpu could be avoided?

Sure,  I'll spend some time looking at what others have done and see
what I can put together.  I'm also very busy on other stuff at the
moment, so this will be something I do more on the side.  Don't think
there's a rush here, but I stated in a previous post, I probably wont
have something out for a month or two.

-- Steve
