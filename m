Message-Id: <200007131433.QAA23929@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: BDM for Linux Kernel Debugging - MMU Support available
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Thu, 13 Jul 2000 16:33:09 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody,

so far, a BDM debugger was of no much use for Linux kernel debugging:
once the MMU is turned on (pretty early during kernel initialization)
the BDM debugger is confronted with virtual  addresses,  and  so  far
they just barfed.

This has changed:

* Frank Przybylski has  added  software-tablewalk  code  to  his  GDB
  extensions   for   the   MPCBDM   "Do-it-yourself"   debugger,  see
  http://www.vas-gmbh.de/software/mpcbdm/

* Abatron has implemented MMU support in recent firmware versions for
  their BDI box (see  http://www.abatron.ch/BDI/bdimain.html);  AFAIK
  they  are  the  first tool provider that offers commercial MMU sup-
  port, and what's even more interesting: they provide it  especially
  with  Linux  in  their  mind. [Right now available for MPC8xx CPUs,
  with PPC6xx/7XX (including MPC82xx) in the works.]

So we now have both a "free" and a "professional"  solution  for  BDM
based  Linux  kernel  debugging, both interfacing with GDB (or DDD if
you like) and allowing to debug kernel code (single stepping,  break-
points,  etc.)  and/or  inspect kernel data... From what I've seen so
far, both solutions provide the same features, and  work  with  about
the same speed - and with the same results.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
 The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
