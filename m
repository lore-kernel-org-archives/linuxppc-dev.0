To: Andreas Plaickner <apxx@gmx.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Card, RTAI on PowerPC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Feb 2003 11:19:43 +0100."
             <13881.1044613183@www65.gmx.net>
Date: Fri, 07 Feb 2003 14:59:36 +0100
Message-Id: <20030207135941.61A3CC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <13881.1044613183@www65.gmx.net> you wrote:
>
> Now I wanted to patch this kernel to run RTAI on the Board.

In this  case  you  should  post  your  question  /  problem  on  the
rtai@rtai.org mailing list instead.

> Testing if the pach works with --dry-run I received the following:
>
> patch --dry-run -b -z.PRE_RTAI -p1 < ../patch-denx-linux-2.4-D2002-09-26
>
> patching file arch/ppc/8xx_io/commproc.c
> patching file arch/ppc/8xx_io/Config.in
> patching file arch/ppc/8xx_io/enet.c
> patching file arch/ppc/8xx_io/lwmon_spi.c
> Hunk #1 FAILED at 79.
> Hunk #2 succeeded at 133 (offset 21 lines).
> Hunk #3 FAILED at 587.
> Hunk #4 FAILED at 681.
> 3 out of 4 hunks FAILED -- saving rejects to file

Seems you are using the wrong kernel  source  tree;  the  patch  name
"D2002-09-26"  suggests  that  you  should use the kernel source tree
version from date 2002-09-26.

> Then I read that it is necessary to download the tree with revision date
> 2002-09-26. I did this one and created a kernel-image without rtai
> like before, and I copied it to the board and this time the following
> happened:
>
>
> Serial driver version 5.05a (2001-03-20) with no serial options enabled
> Oops: kernel access of bad area, sig: 11
> NIP: C00B91CC XER: 8000007F LR: C00BD810 SP: C0209DC0 REGS: c0209d10 TRAP:
> 0300

Obviously you have mis-configured your kernel. You try  to  access  a
non-existent device (standard serial port?).

> What I would need is a combination of the source trees. The ideal would be
> if i could patch the
> kernel linux-2.4 from anonymous ftp on DENX as my PCMCIA card works with it.
> Does
> anyone have any suggestions what I could do to be able to patch this kernel?

Just follow the instructions in ftp://ftp.denx.de/pub/RTAI/README

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
An age is called Dark not because  the  light  fails  to  shine,  but
because people refuse to see it.           -- James Michener, "Space"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
