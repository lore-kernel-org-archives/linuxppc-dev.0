Return-Path: <dalang@cs.ubc.ca>
Received: from mail-relay1.cs.ubc.ca (mail-relay1.cs.ubc.ca [142.103.6.79])
	by ozlabs.org (Postfix) with ESMTP id 2263368862
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2005 01:27:43 +1100 (EST)
Date: Fri, 2 Dec 2005 06:27:38 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: "Redondo Garcia, Roberto" <rredondo@indra.es>
In-Reply-To: <6A28467355D2AD478D1F51C479415AE77B47E9@MADTORMAIL.indra.es>
Message-ID: <Pine.LNX.4.60.0512020612540.4326@tin.icics.ubc.ca>
References: <6A28467355D2AD478D1F51C479415AE77B47E9@MADTORMAIL.indra.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: back trace when a SIGSEGV
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

SIGSEGV (also known as a "segmentation fault" or "segfault") usually means 
your program is doing something wrong like trying to dereference a null 
pointer.  (ie, int* x = NULL; *x = 42;).  To track this down, you can use 
"gdb" (the gnu debugger) - gnu.org.  Another option is "valgrind" - 
valgrind.org - there is a PowerPC port (thanks, Paul!).

However, this mailing list is for _development_ of the linux _kernel_ on 
PowerPC.  Your question is not about kernel development so it doesn't 
belong here.  (Unless you are sure that your program is correct and 
somehow the kernel is unfairly giving you a segfault - which doesn't seem 
to be the case, based on your message.)  Find a mailing list or message 
board about userspace programming and ask your question there.

Also, you should learn how to write a bug report.  Go to google.com, type 
in "how to write a bug report", and read the first ten results.  (For 
example: What program are you running?  Something you wrote?  What OS are 
you using?  Why do you think the SIGSEGV is something caused by someone 
else's code and not your own?  Why does it matter how long the program 
runs before it crashes?  Why didn't you type "debug" into google and see 
what came up?  (GDB is number 6!  Come on, get with it!))

Happy debugging!
dustin.

> hello,
> I have a program that when it has been several hours running, it has a
> problem and falls and it produces a SIGSEGV.  I would like to know to
> how debug this error, because I do not have ulimit for generate core
> dump o examine a back trace.
>
> thanks
