Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id F0761DDED7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 00:02:09 +1100 (EST)
Date: Wed, 4 Feb 2009 08:02:07 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: next-20090204 build break : ftrace
In-Reply-To: <498972A7.4090609@in.ibm.com>
Message-ID: <alpine.DEB.1.10.0902040801430.1476@gandalf.stny.rr.com>
References: <498972A7.4090609@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




On Wed, 4 Feb 2009, Sachin P. Sant wrote:

> Hi Stephen,
> 
> 20090204 randconfig build on powerpc fails with :
> 
>  CC      arch/powerpc/kernel/ftrace.o
> arch/powerpc/kernel/ftrace.c: In function __ftrace_make_nop:
> arch/powerpc/kernel/ftrace.c:204: error: dereferencing pointer to incomplete
> type
> arch/powerpc/kernel/ftrace.c: In function __ftrace_make_call:
> arch/powerpc/kernel/ftrace.c:400: error: dereferencing pointer to incomplete
> type
> arch/powerpc/kernel/ftrace.c:400: error: dereferencing pointer to incomplete
> type
> arch/powerpc/kernel/ftrace.c:400: error: dereferencing pointer to incomplete
> type
> arch/powerpc/kernel/ftrace.c:407: error: dereferencing pointer to incomplete
> type
> make[1]: *** [arch/powerpc/kernel/ftrace.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
> 
> config attached.
> 

Thanks, I'll give it a try later today on my PPC64 box.

-- Steve
