Content-Type: text/plain;
  charset="iso-8859-1"
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Bill Fink <billfink@mindspring.com>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Runtime Altivec detection
Date: Fri, 7 Mar 2003 20:11:53 -0600
References: <20030307210257.7b094f55.billfink@mindspring.com>
In-Reply-To: <20030307210257.7b094f55.billfink@mindspring.com>
MIME-Version: 1.0
Message-Id: <200303072011.54069.hollis@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday 07 March 2003 08:02 pm, Bill Fink wrote:
>
> Here is the code xine uses to do run time Altivec detection
> (from xine-utils/cpu_accel.c):
>
> #if defined (ARCH_PPC) && defined (ENABLE_ALTIVEC)
> static sigjmp_buf jmpbuf;
> static volatile sig_atomic_t canjump = 0;
>
> static void sigill_handler (int sig)
[snip]

Compared to testing the CPU feature bits supplied by the kernel (for a long
time now; Ben could tell you exactly how long) this method seems *extremely*
messy. Please see my other posts (and Ben's) in this thread for details.

-Hollis
--
IBM Linux Technology Center

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
