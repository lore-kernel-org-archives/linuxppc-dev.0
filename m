Message-ID: <39733BC1.D0CC97E1@mvista.com>
Date: Mon, 17 Jul 2000 10:00:49 -0700
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: oliver.amft@ch.abb.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GLibC cross compile for ppc-linux
References: <4125691F.0034CFC3.00@mail1.ch.abb.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been cross-compiling glibc-2.1.3 for ppc 7xx and 8xx for a while
now.  I've yet to see any problems like that.  What if your host OS,
(i.e. RedHat, debian etc? and it's version.)  And what are you
targeting?

--Mark

oliver.amft@ch.abb.com wrote:
>
> Hi all,
>
> i'm trying to build the glibc 2.1.3 on a i686-linux machine for a powerpc-linux
> embedded target. The make command works fine (...no errors) but somehow "make
> check" stops in the "stdlib tests" part when it is invoking the "isomac" command
> for the first time (after compiling it):
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
