Date: Thu, 22 Jun 2000 16:24:58 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: "Mark S. Mathews" <mark@absoval.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <Pine.LNX.3.96.1000622154358.10852D-100000@tristar.cc.absoval.com>
Message-ID: <Pine.LNX.4.21.0006221621450.31776-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Mark!

>    if ( (off+len-1) < off )
> 	return EINVAL;

It's done this way in Linux-2.2.14 :-)

> It works on the G3?  Perhaps the compiler/processor difference is getting
> you into some of the 64-bit register goofiness or a slightly different
> code sequence that does something different w/ the overflow flag.  Just
> guessing here.

Absolutely no "64-bit register goofiness" :-)))

Pavel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
