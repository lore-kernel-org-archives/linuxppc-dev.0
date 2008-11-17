Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 92E39DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 02:43:57 +1100 (EST)
Date: Mon, 17 Nov 2008 10:43:55 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] ftrace, PPC: do not latency trace idle
In-Reply-To: <18720.59484.266300.486911@drongo.ozlabs.ibm.com>
Message-ID: <alpine.DEB.1.10.0811171042280.2919@gandalf.stny.rr.com>
References: <20081116212428.938752312@goodmis.org>
	<20081116212515.093117788@goodmis.org>
	<18720.59484.266300.486911@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 17 Nov 2008, Paul Mackerras wrote:

> Steven Rostedt writes:
> 
> > When idle is called, interrupts are disabled, but the idle function
> > will still wake up on an interrupt. The problem is that the interrupt
> > disabled latency tracer will take this call to idle as a latency.
> > 
> > This patch disables the latency tracing when going into idle.
> 
> Patch looks OK, but what is the connection with ftrace?

Ah, that patch has been sitting on my box for some time. It has to deal 
with the latency tracer and not the dynamic tracing part of ftrace. I 
added it because it is PPC ftrace related and to get it off my box. But 
this is not have anything to do with the rest of the patches.

-- Steve
