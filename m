To: linuxppc-embedded@lists.linuxppc.org
Cc: u-boot-users@lists.sourceforge.net
Subject: hang up after start_here
MIME-Version: 1.0
Message-ID: <OFE8EA1A87.9A7B8A06-ONC1256D86.0028950A-C1256D86.002D5CE3@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Mon, 18 Aug 2003 09:54:51 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I'm designing a custom board build around a 405GPr processor. I'm in my
third prototype phase, and I've problem with one board which hang during
Linux booting.
I've debugged and found that the board hangs in start_here function and
doesn't reach the early_init function.

Because the problem appears on only one of my boards out of 16, I suspect
a hardware problem, and because it occurs just after mmu initialisation
and caches enabling, I suspect more especially sdram accesses.

I want to know if anybody has encountered a similar problem and if the
diagnostic was the same.

Kernel version is 2.4.18 from Montavista.

Thanks for help,

Laurent

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
