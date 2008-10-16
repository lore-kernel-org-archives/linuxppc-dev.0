Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 721B5DDF2F
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 05:53:02 +1100 (EST)
Date: Thu, 16 Oct 2008 14:45:15 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
In-Reply-To: <20081016183529.GB29739@yoda.jdub.homelinux.org>
Message-ID: <alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
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
> 
> Well, that's why I asked.  You sent 2 patches out over a month ago that
> don't appear to have shown up in any Linus or PowerPC tree.

Oh, the patches I sent on here, are not to solve this issue. It was 
actually solving issues in linux-tip itself.

I'm still looking into the cause for ftrace not to boot on PPC.

-- Steve
