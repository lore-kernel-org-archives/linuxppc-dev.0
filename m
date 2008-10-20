Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 63370DDF83
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 04:53:13 +1100 (EST)
Date: Mon, 20 Oct 2008 13:53:11 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: =?ISO-8859-15?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
In-Reply-To: <c62985530810201042v4b3eed0ah62de285c64b2c0ba@mail.gmail.com>
Message-ID: <alpine.DEB.1.10.0810201351130.5336@gandalf.stny.rr.com>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161421530.11042@gandalf.stny.rr.com>
	<20081016183529.GB29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
	<20081016150106.6ddf7e46@zod.rchland.ibm.com>
	<alpine.DEB.1.10.0810201222570.3760@gandalf.stny.rr.com>
	<20081020170808.GB7249@yoda.jdub.homelinux.org>
	<c62985530810201042v4b3eed0ah62de285c64b2c0ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 20 Oct 2008, Fr?d?ric Weisbecker wrote:

> There are other arch that support ftrace as well like sh or sparc64
> (I'm currently working on
> an implementation for mips).
> So the choice would be better between waiting for a fix or disable
> dynamic ftrace
> on Kconfig only for PowerPC.

Hi Frederic,

I believe MIPS has the same issues as PPC. Doesn't it use a trampoline 
too?  I want to make the generic code handle trampolines a bit better. 
This is one of the problems with developing in x86. It avoids a lot of the 
issues that other archs might have.

-- Steve
