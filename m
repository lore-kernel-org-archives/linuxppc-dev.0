Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 39B91DDEEB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 03:58:16 +1100 (EST)
Date: Thu, 12 Feb 2009 11:58:14 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 0/7][RFC] function graph tracer port to PowerPC
In-Reply-To: <20090212164720.GA4868@nowhere>
Message-ID: <alpine.DEB.1.10.0902121157120.15469@gandalf.stny.rr.com>
References: <20090212011051.265346435@goodmis.org>
	<20090212015503.GA4697@nowhere>
	<alpine.DEB.1.10.0902121131150.15469@gandalf.stny.rr.com>
	<20090212164720.GA4868@nowhere>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


On Thu, 12 Feb 2009, Frederic Weisbecker wrote:
> 
> 
> Yes of course, I knew most of it was architecture independant but I delayed
> this TODO for future ports, and you've done it.
> 
> Thanks.
> 
> Just a micro detail: the ftrace_push/pop_return_trace are parts of
> the core of the entry/return probe, something that could be used
> by other users than the function graph tracer itself.
> 
> Perhaps it would be better to put them in kernel/trace/ftrace.c
> What do you think?

I'll go with your above method. We'll move it when it comes to that ;-)

> 
> Anyway, Acked-by: Frederic Weisbecker <fweisbec@gmail.com>

Thanks!

I'll update my repo.

-- Steve
