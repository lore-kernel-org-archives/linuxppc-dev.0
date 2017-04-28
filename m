Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDwQL1bPNzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 23:58:34 +1000 (AEST)
Date: Fri, 28 Apr 2017 15:58:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-ID: <20170428135810.gljrbuwgrypu5jkn@hirez.programming.kicks-ass.net>
References: <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
 <20170428090226.qqoe6qbewjeo57kd@hirez.programming.kicks-ass.net>
 <20170428134423.GB3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170428134423.GB3452@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 28, 2017 at 03:44:23PM +0200, Petr Mladek wrote:
> On Fri 2017-04-28 11:02:26, Peter Zijlstra wrote:
> > On Thu, Apr 27, 2017 at 03:38:19PM +0200, Petr Mladek wrote:
> > > Also we need to look for alternatives. There is a chance
> > > to create crashdump and get the ftrace messages from it.
> > > Also this might be scenario when we might need to suggest
> > > the early_printk() patchset from Peter Zijlstra.
> > 
> > I'd be happy to repost those. I still carry them in my tree.
> 
> You do not need to if they are still the same as
> https://lkml.kernel.org/r/20161018170830.405990950@infradead.org

More or less, I think I fixed an intermediate compile fail reported by
you and the 0-day thing and I wrote a few comments in the last patch.

They live here fwiw:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/tmp

> I rather do not promise anything but I would like to look at them
> within next few weeks (after the merge window).

Sure, I'll post them again during/after the merge window.
