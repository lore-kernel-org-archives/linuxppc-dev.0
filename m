Subject: gdb from mbxroot.full.tgz complains: Not a typewriter
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Thu, 17 Feb 2000 11:59:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000217005917.4338F1B580@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using mbxroot.full.tgz to develop/test a linuxppc-embedded application on
an Embedded Planet CLLF board, and I'm having some trouble running its gdb
on the target. (I'm not using gdbserver here). When I run my program under
gdb, and it stops at a breakpoint, I get the warning:

    [tcsetpgrp failed in terminal_inferior: Not a typewriter]

after this, gdb no longer accepts my keyboard input.

My guess is that the problem is caused by the kernel simply spawning a shell
without starting init, and is probably the same thing that stops CTRL-C working
on the console shell. My question then, is this: what's the simplest way to
make a shell on the console act like a normal shell on a host machine?

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
