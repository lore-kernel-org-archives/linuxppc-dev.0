Message-ID: <20000207023248.17506.qmail@nwcst323.netaddress.usa.net>
Date: 6 Feb 00 20:32:48 CST
From: "William A.Gatliff" <bgat@usa.net>
To: diekema@bucks.si.com (diekema_jon), bgat@usa.net
Subject: Re: [Looking for the PPC gdb debug stubs]
CC: all@cideas.com, linuxppc-embedded@lists.linuxppc.org,
        gdb@sourceware.cygnus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon:

> In your 9/99 article in Embedded Systems Programming, you hint
> about the Power PC gdb debug stubs being in progress.  Can you
> provide with any details like:
>
> - Is the effort complete?

Actually, the "port" was my sending a copy of the SH-2 stub to someone who was
working on PPC.  They promised to port it and return, but I never heard back
from them.

> - If so, where can I find the PPC gdb debug stubs?

You can now find the complete SH-2 stub at www.sourceforge.net.  Do a search
for "gdbstubs".

It's a complete rewrite from the ESP days, designed for more portability.


If you're familiar with the PPC, then you could always do the port yourself.
eCos has a stub as well, and it shouldn't be too hard to meld it into my
sources.  I don't have any PPC hardware, though, so I'm understandably wary of
trying to offer much help with the hardware-specific stuff.  If I had the
hardware, though...

b.g.


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
