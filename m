Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id B303CDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:24:47 +1100 (EST)
Date: Thu, 20 Nov 2008 14:24:45 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/5] powerpc: dynamic ftrace port
In-Reply-To: <20081120191650.GD3955@elte.hu>
Message-ID: <alpine.DEB.1.10.0811201423010.3378@gandalf.stny.rr.com>
References: <20081120190948.057007623@goodmis.org>
	<20081120191650.GD3955@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Nov 2008, Ingo Molnar wrote:
> > 
> > There is one exception and that is for the first patch. The first patch
> > is actually a fix for the irqsoff latency tracer which is already
> > in mainline for PowerPC.
> > 

> > Steven Rostedt (5):
> >       powerpc: ftrace, do not latency trace idle

> 
> Now lets hope it looks good to Paul too and we can get his Acked-by
> :-)
> 

Hmm, that first patch is really a bug fix. I wonder if we should push to 
get that into 28?  It has a low impact, but it fixes a bug that is in 
current mainline.

-- Steve
