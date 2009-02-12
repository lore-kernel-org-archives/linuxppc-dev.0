Return-Path: <fweisbec@gmail.com>
Received: from mail-bw0-f168.google.com (mail-bw0-f168.google.com
	[209.85.218.168]) by ozlabs.org (Postfix) with ESMTP id C348BDDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 03:47:25 +1100 (EST)
Received: by bwz12 with SMTP id 12so2038231bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 08:47:24 -0800 (PST)
Date: Thu, 12 Feb 2009 17:47:21 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/7][RFC] function graph tracer port to PowerPC
Message-ID: <20090212164720.GA4868@nowhere>
References: <20090212011051.265346435@goodmis.org>
	<20090212015503.GA4697@nowhere>
	<alpine.DEB.1.10.0902121131150.15469@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0902121131150.15469@gandalf.stny.rr.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 11:31:44AM -0500, Steven Rostedt wrote:
> 
> On Thu, 12 Feb 2009, Frederic Weisbecker wrote:
> 
> > On Wed, Feb 11, 2009 at 08:10:51PM -0500, Steven Rostedt wrote:
> > > 
> > > The following set of patches are RFC and not for inclusion
> > > (unless everyone is fine with them as is).
> > > 
> > > This is the port to PowerPC of the function graph tracer that was written
> > > by Frederic Weisbecker for the x86 architecture.  It is broken up
> > > into a series of logical steps.
> > > 
> > > 1) get generic code ready for other archs
> > > 2) get PowerPC 64-bit working with just static function tracing
> > > 3) get PowerPC 64-bit working with dynamic function tracing
> > > 4) get PowerPC 32-bit working with just static function tracing
> > > 5) get PowerPC 32-bit working with dynamic function tracing
> > > 
> > > (with some clean ups in between)
> > > 
> > 
> > 
> > Thanks a lot Steven!
> > I'm sad to not having a Power Pc to test it...
> 
> BTW, Can I count that as an Acked-by: for the first patch. Since the first 
> patch does modify your code.
> 
> -- Steve
> 


Yes of course, I knew most of it was architecture independant but I delayed
this TODO for future ports, and you've done it.

Thanks.

Just a micro detail: the ftrace_push/pop_return_trace are parts of
the core of the entry/return probe, something that could be used
by other users than the function graph tracer itself.

Perhaps it would be better to put them in kernel/trace/ftrace.c
What do you think?

Anyway, Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
