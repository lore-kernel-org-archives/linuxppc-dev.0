Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 5936EDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 13:29:22 +1100 (EST)
Date: Mon, 17 Nov 2008 21:29:20 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
In-Reply-To: <alpine.DEB.1.10.0811171557370.26123@gandalf.stny.rr.com>
Message-ID: <alpine.DEB.1.10.0811172128380.26123@gandalf.stny.rr.com>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0811171557370.26123@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 17 Nov 2008, Steven Rostedt wrote:
> 
> On Mon, 17 Nov 2008, Steven Rostedt wrote:
> > 
> > Note, I was using a default config that had CONFIG_IRQSTACKS off and
> > CONFIG_PPC_64K_PAGES on.
> 
> Here's my stack after boot up with CONFIG_IRQSTACKS set. Seems that 
> softirqs still use the same stack as the process.
> 

By-the-way, my box has been running stable ever since I switched to 
CONFIG_IRQSTACKS.

-- Steve
