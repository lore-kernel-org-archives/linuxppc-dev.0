Date: Wed, 16 Jul 2003 10:26:57 -0400
From: Kent Borg <kentborg@borg.org>
To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ptrace Problem
Message-ID: <20030716102657.D20719@borg.org>
References: <AB5AF73EAF23304EA1B932174137CED70303AE@m5tmail.m5t.com> <20030715174945.G12505@borg.org> <1058351871.31114.26.camel@spawn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1058351871.31114.26.camel@spawn>; from kenneth.johansson@etx.ericsson.se on Wed, Jul 16, 2003 at 12:37:51PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 16, 2003 at 12:37:51PM +0200, Kenneth Johansson wrote:
>
> On Tue, 2003-07-15 at 23:49, Kent Borg wrote:
>
> > Looking at likely source tarballs we have sitting around it seems very
> > likely that binutils were built from 2.13.2.1, and glibc 2.3.2.  (How
> > can I be sure?)
>
> binutils binaries usually respond with the version when given -V on the
> command line.

Oh!  I thought that was a version of an individual component, but
lordy, nm and objdump both give the same number and it matches the tar
I had guessed we had used.

> libc can be checked with objdump -x and checking the Version
> definitions.

It lists a series of numbers ranging from 2.0 to 2.2.2.

> This should not be a problem gdb dose all the work using ptrace.

Indeed, gdb didn't drag me down into any libraries.

> Regarding your gdb problems have you tried with a kernel without bdi2000
> support in the kernel.

No, but I will now.


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
