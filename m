Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id CFD652BE83
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2004 09:23:52 +1100 (EST)
Date: Thu, 2 Dec 2004 15:23:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
Message-ID: <20041202222349.GE14005@smtp.west.cox.net>
References: <41AF7DFC.9040009@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41AF7DFC.9040009@acm.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PPC debug setcontext  syscall implementation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 02, 2004 at 02:41:32PM -0600, Corey Minyard wrote:

> Hello all,
> 
> I have attached a patch with the implementation of the debug_setcontext 
> system call.  The syscall has been reserved for a while and I've posted 
> this before.  So I've ported to the newest kernel and here it is again.
> 
> This syscall allows signal handlers to perform debug functions.  It 
> allows the signal handler to turn on single-stepping, for instance, and 
> the thread will get a trap after executing the next instruction.  It can 
> also (on supported PPC processors) turn on branch tracing and get a trap 
> after the next branch instruction is executed.  This is useful for 
> in-application debugging.

I asked Corey off-list, and this is vs 2.6.10-rc2-mm3.
I propose (and will update the patch tracker
(http://ozlabs.org/ppc32-patches/, I don't recall if/how well it was
advertised)) that so long as KGDB still works (I'll even go test it on
classic) as well as GDB testsuite (this is a 'touchy' area, so I'd like
to well-test changes) is still 'OK', pushing this into 2.6.11.

-- 
Tom Rini
http://gate.crashing.org/~trini/
