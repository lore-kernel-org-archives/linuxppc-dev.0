Return-Path: <minyard@acm.org>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.85])
	by ozlabs.org (Postfix) with ESMTP id CCD832BEA0
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2004 10:03:50 +1100 (EST)
Message-ID: <41AF9E25.2080109@acm.org>
Date: Thu, 02 Dec 2004 16:58:45 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <41AF7DFC.9040009@acm.org>
	<20041202222349.GE14005@smtp.west.cox.net>
	<20041202154901.B20211@home.com>
In-Reply-To: <20041202154901.B20211@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I'll test gdb on classic and an ebony that I have.  I assume that gdb 
has a built-in test suite?

-Corey

Matt Porter wrote:

>On Thu, Dec 02, 2004 at 03:23:50PM -0700, Tom Rini wrote:
>  
>
>>On Thu, Dec 02, 2004 at 02:41:32PM -0600, Corey Minyard wrote:
>>
>>    
>>
>>>Hello all,
>>>
>>>I have attached a patch with the implementation of the debug_setcontext 
>>>system call.  The syscall has been reserved for a while and I've posted 
>>>this before.  So I've ported to the newest kernel and here it is again.
>>>
>>>This syscall allows signal handlers to perform debug functions.  It 
>>>allows the signal handler to turn on single-stepping, for instance, and 
>>>the thread will get a trap after executing the next instruction.  It can 
>>>also (on supported PPC processors) turn on branch tracing and get a trap 
>>>after the next branch instruction is executed.  This is useful for 
>>>in-application debugging.
>>>      
>>>
>>I asked Corey off-list, and this is vs 2.6.10-rc2-mm3.
>>I propose (and will update the patch tracker
>>(http://ozlabs.org/ppc32-patches/, I don't recall if/how well it was
>>advertised)) that so long as KGDB still works (I'll even go test it on
>>classic) as well as GDB testsuite (this is a 'touchy' area, so I'd like
>>to well-test changes) is still 'OK', pushing this into 2.6.11.
>>    
>>
>
>I don't see a problem so long as both the 40x||booke and classic paths
>are tested with gdb and kgdb. I don't want to fix the former path again.
>
>-Matt
>  
>
