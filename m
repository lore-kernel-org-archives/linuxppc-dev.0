From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel configuration option for debugging the kernel (using bdi 2000)
Date: Wed, 4 Jun 2003 15:32:58 -0400
Message-ID: <001f01c32ad0$1ae03010$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <AB5AF73EAF23304EA1B932174137CED702FB8F@m5tmail.m5t.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 I started using bdi2000 with gdb.
I run gdb on Pentium PC.
The target is Sandpoint X3 with Altimus MPC755 processor board.
I found some flags in "kernel hacking" menu.
Which should I turn on?
   Magic SysRq key, Include kgdb kernel debugger, Include xmon kernel
debugger, Include BDI-2000 user context switcher, ...

 I switched from Codewarrior to GDB recently.
I'm not good at remote debugging with GDB.
I'll appreciate your help.

 Dong-In


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
