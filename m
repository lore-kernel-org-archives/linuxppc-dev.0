Message-ID: <3DD845D7.5C98736B@bmrtech.com>
Date: Mon, 18 Nov 2002 09:43:51 +0800
From: sjk <jack.sun@bmrtech.com>
Reply-To: jack.sun@bmrtech.com
MIME-Version: 1.0
To: bgat@billgatliff.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver and gdb cross debug?
References: <200210260458.g9Q4wpq15745@ftp1.mvista.com> <3DCF5E9B.406F7565@bmrtech.com> <20021115134822.A5906@saturn.billgatliff.com>
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"William A. Gatliff" wrote:

> Jikun:
>
> On Mon, Nov 11, 2002 at 03:39:07PM +0800, sjk wrote:
> > I am porting Linux on EP405 board. So I use gdbserver and gdb to debug
> > applications,but only the first
> > breakpoint could be stopped.Then if i press 'step', the program will
> > execute to end straightforwardly . Any other breakpoints could not break
> > the execution.
>
> Have you compiled the application in question with optimizations?  Gdb
> isn't so good at debugging optimized code.  Compile with -g -O0 if you
> intend to debug.

I tried to compile hello.c as following:

ppc_405-gcc -g -O0 -o hello hello.c

Then set up the connection of gdbserver and ppc_405-gdb. The program could not
be debugged step by step either.
Is it possible that there is bug in ptrace.c or traps.c


Thanks a lot

Jikun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
