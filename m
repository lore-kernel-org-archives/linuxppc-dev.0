From: jtm@smoothsmoothie.com
Date: Mon, 23 Apr 2001 11:03:02 -0500
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 and RTLinux
Message-ID: <20010423110302.C21223@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried sending this to the RTL mailing list, but there appears to
be a pretty long delay in posting, so I thought I'd ask here, too.

Does RTLinux run on the MPC8260? I thought it should, but can't get
it to work.

I've tried a couple different kernel versions, but no luck. I tried 2.4.0
from kernel.org, but it wouldn't compile at all. I can run a 2.4.1 without
the RTLinux modules. If I apply the patch, to 2.4.1, I get several failures,
and it looks like the powerpc changes are already in the kernel. I can still
build the kernel, however.

With 2.4.1, when I try to build the modules I get this error:
	rtlinux-3.0/include/rtlinux_signal.h:67: `NR_IRQS' undeclared here (not in a function)

If I define NR_IRQS to be 256, it compiles OK.

So I can boot the kernel, and when I do a 'insmod rtl.o', I get:
	RTLinux Extensions Loaded (http://www.fsmlabs.com/)
	Kernel panic: request IRQ

I've also tried a bitkeeper kernel with no better luck.

I saw in an old mailing list posting that XMON or KGDB needs to be
enabled on the powerpc to get RTLinux to work, but the kernel won't
build with either enabled.

So am I doing something wrong, or does RTLinux not work on the 8260?

Thanks.


--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
