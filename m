Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D333EDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 22:14:24 +1100 (EST)
Date: Thu, 19 Feb 2009 12:14:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [git pull] for both tip and powerpc
Message-ID: <20090219111410.GM2354@elte.hu>
References: <alpine.DEB.1.10.0902181408160.11411@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0902181408160.11411@gandalf.stny.rr.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo and Benjamin,
> 
> As discussed, I made a branch called mainline/function-graph-tracer 
> based off of Linus's commit:
> 
> commit d2f8d7ee1a9b4650b4e43325b321801264f7c37a
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Feb 13 15:31:30 2009 -0800
> 
>     Linux 2.6.29-rc5
> 
> 
> and cherry picked the below change. I added Ingo's Acked-by as well. If 
> both of you pull this change in (assuming both trees are already based 
> off of Linus's 2.6.29-rc5) then there should be no conflicts when this 
> gets merged back to Linus's tree.
> 
> I will not touch this branch again, until it is officially in mainline.
> 
> Please pull the latest mainline/function-graph tree, which can be found at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> mainline/function-graph
> 
> 
> Steven Rostedt (1):
>       tracing/function-graph-tracer: make arch generic push pop functions
> 
> ----
>  arch/x86/include/asm/ftrace.h        |   25 -----------
>  arch/x86/kernel/dumpstack.c          |    1 +
>  arch/x86/kernel/ftrace.c             |   75 +---------------------------------
>  include/linux/ftrace.h               |   24 +++++++++++
>  kernel/trace/trace_functions_graph.c |   75 ++++++++++++++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 99 deletions(-)

Pulled into tip:tracing/function-graph-tracer, thanks Steve!

	Ingo
