Message-ID: <3ECE5D52.2090106@mvista.com>
Date: Fri, 23 May 2003 10:41:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel patch for gt64260_mpsc
References: <3ECD5C96.60306@mvista.com> <20030523160600.GK774@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030523160600.GK774@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

>On Thu, May 22, 2003 at 04:26:14PM -0700, Mark A. Greer wrote:
>
>
>
>>Patch that:
>>
>>- Adds early initialization of MPSC for kgdb and progress.
>>- Creates polled getc routine for kgdb.
>>- Creates polled getc routine for kgdb and progress (previously in
>>arch/ppc/kernel/gt64260_common.c).
>>- Adds MAGIC_SYSRQ support.
>>
>>
>
>Doesn't apply cleanly:
>$ patch -p1 < gt_mpsc.patch
>Get file drivers/char/Config.in from SCCS with lock? [y]
>drivers/char/Config.in 1.51 -> 1.52: 405 lines
>patching file drivers/char/Config.in
>Get file drivers/char/gt64260_mpsc.c from SCCS with lock? [y]
>drivers/char/gt64260_mpsc.c 1.3 -> 1.4: 1907 lines
>patching file drivers/char/gt64260_mpsc.c
>Hunk #5 FAILED at 977.
>Hunk #6 FAILED at 1003.
>Hunk #15 succeeded at 1806 with fuzz 1.
>2 out of 19 hunks FAILED -- saving rejects to file
>drivers/char/gt64260_mpsc.c.rej
>Get file include/asm-ppc/gt64260.h from SCCS with lock? [y]
>include/asm-ppc/gt64260.h 1.16 -> 1.17: 361 lines
>patching file include/asm-ppc/gt64260.h
>
>And since the others rely on this, I'm stopping here.
>
Hmm, interesting...  There were trailing blanks at the end of some lines
in that file which were  stripped out by majordomo so the patch didn't
match.  I'll have to remember that (and try to figure out why people put
blanks at the ends of lines).

FYI, I've resent that patches to trini directly and I expect that he
will apply them.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
