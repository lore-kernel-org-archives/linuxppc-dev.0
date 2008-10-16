Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id C1849DE2BD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 05:53:00 +1100 (EST)
Date: Thu, 16 Oct 2008 14:42:52 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
In-Reply-To: <20081016183529.GB29739@yoda.jdub.homelinux.org>
Message-ID: <alpine.DEB.1.10.0810161441200.11042@gandalf.stny.rr.com>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161421530.11042@gandalf.stny.rr.com>
	<20081016183529.GB29739@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 16 Oct 2008, Josh Boyer wrote:
> >
> >My powerbook does not boot with ftrace enabled. I'm currently debugging 
> >it. When I get it working, you'll see patches.
> 
> Well, that's why I asked.  You sent 2 patches out over a month ago that
> don't appear to have shown up in any Linus or PowerPC tree.

OK, I'll see if those patches fixes my problem.

> 
> >They will be to linux-tip though, and not for the current mainline (unless 
> >the code in linux-tip gets merged).
> 
> If linux-tip is some x86 topic branch, I think that's the wrong place for
> fixes that are needed on non-x86 arches.

linux-tip has been used by more that x86 specific changes. It's where we 
have been developing ftrace itself.

My original port to PPC first landed into linux-tip.

-- Steve
