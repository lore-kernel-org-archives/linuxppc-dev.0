Date: Fri, 23 May 2003 09:06:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel patch for gt64260_mpsc
Message-ID: <20030523160600.GK774@ip68-0-152-218.tc.ph.cox.net>
References: <3ECD5C96.60306@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ECD5C96.60306@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, May 22, 2003 at 04:26:14PM -0700, Mark A. Greer wrote:

> Patch that:
>
> - Adds early initialization of MPSC for kgdb and progress.
> - Creates polled getc routine for kgdb.
> - Creates polled getc routine for kgdb and progress (previously in
> arch/ppc/kernel/gt64260_common.c).
> - Adds MAGIC_SYSRQ support.

Doesn't apply cleanly:
$ patch -p1 < gt_mpsc.patch
Get file drivers/char/Config.in from SCCS with lock? [y]
drivers/char/Config.in 1.51 -> 1.52: 405 lines
patching file drivers/char/Config.in
Get file drivers/char/gt64260_mpsc.c from SCCS with lock? [y]
drivers/char/gt64260_mpsc.c 1.3 -> 1.4: 1907 lines
patching file drivers/char/gt64260_mpsc.c
Hunk #5 FAILED at 977.
Hunk #6 FAILED at 1003.
Hunk #15 succeeded at 1806 with fuzz 1.
2 out of 19 hunks FAILED -- saving rejects to file
drivers/char/gt64260_mpsc.c.rej
Get file include/asm-ppc/gt64260.h from SCCS with lock? [y]
include/asm-ppc/gt64260.h 1.16 -> 1.17: 361 lines
patching file include/asm-ppc/gt64260.h

And since the others rely on this, I'm stopping here.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
