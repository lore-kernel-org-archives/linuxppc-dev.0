Date: Tue, 15 Jul 2003 17:49:45 -0400
From: Kent Borg <kentborg@borg.org>
To: Jean-Denis Boyer <jdboyer@m5t.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ptrace Problem
Message-ID: <20030715174945.G12505@borg.org>
References: <AB5AF73EAF23304EA1B932174137CED70303AE@m5tmail.m5t.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AB5AF73EAF23304EA1B932174137CED70303AE@m5tmail.m5t.com>; from jdboyer@m5t.com on Tue, Jul 15, 2003 at 12:30:26PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 15, 2003 at 12:30:26PM -0400, Jean-Denis Boyer wrote:

> Which chip is it?

An unreleased 603-ish core with other stuff added.

> Is it correctly recognized by the kernel
> (arch/ppc/kernel/cputable.c)?

I long ago added an entry to cputable.c, and am using it.  I'll look
at those specifics again though.  Good tip.  ...and I just made a
change that might help...  and that didn't help

> This is a silly question, but, did you try to unplug the BDI-2000
> before running gdbserver? Just in case it stops on some exceptions...

If I understood correctly: use Abatron to download my code, make sure
things are running, them pull that power, and things still run.
Attempt to do gdb/gdbserver and it malfunctions in the same way--or at
least I think so, I don't have an Abatron hooked up.

> Do you use a somewhat recent version of glibc, and was it built
> against a somewhat recent version of kernel? Can you also tell us
> the version of binutils and gcc ? Not all the combinations are
> reliable ;-)

Looking at likely source tarballs we have sitting around it seems very
likely that binutils were built from 2.13.2.1, and glibc 2.3.2.  (How
can I be sure?)

gcc reports 3.2.2.

Are those a compatible set?


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
