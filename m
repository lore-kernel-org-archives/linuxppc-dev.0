Date: Fri, 15 Nov 2002 13:48:22 -0600
From: "William A. Gatliff" <bgat@billgatliff.com>
To: sjk <jack.sun@bmrtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver and gdb cross debug?
Message-ID: <20021115134822.A5906@saturn.billgatliff.com>
Reply-To: bgat@billgatliff.com
References: <200210260458.g9Q4wpq15745@ftp1.mvista.com> <3DCF5E9B.406F7565@bmrtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DCF5E9B.406F7565@bmrtech.com>; from jack.sun@bmrtech.com on Mon, Nov 11, 2002 at 03:39:07PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jikun:

On Mon, Nov 11, 2002 at 03:39:07PM +0800, sjk wrote:
> I am porting Linux on EP405 board. So I use gdbserver and gdb to debug
> applications,but only the first
> breakpoint could be stopped.Then if i press 'step', the program will
> execute to end straightforwardly . Any other breakpoints could not break
> the execution.

Have you compiled the application in question with optimizations?  Gdb
isn't so good at debugging optimized code.  Compile with -g -O0 if you
intend to debug.

b.g.
--
Bill Gatliff
Do you do embedded GNU?  I do!
See http://billgatliff.com for details.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
