Message-ID: <38239C25.D0392585@jlc.net>
Date: Fri, 05 Nov 1999 22:10:29 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: gdbserver ?
References: <199911051732.SAA29775@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:


> has anybody ever tried to build gdbserver for a PPC target?

I placed a tar image of just the gdbserver sub-directory on ppc.kernel.org.
It is in the embedded directory.  The binary is built for an R4 system.
The code is from a 4.17 version of gdb.  I believe all of the changes
are in low-linux.c.

It works with the latest kernels, and I also built an out-of-the-box
version of Cygnus Insight on a LinuxPPC 1999 host that worked fine with
it.

I hope someone that knows more about this than I can make these changes
look prettier and ensure it finds its way into a standard release.

Have fun.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
