Message-ID: <3D084D1F.95AFFCBB@icn.siemens.de>
Date: Thu, 13 Jun 2002 09:43:27 +0200
From: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Accessing the user stack inside system call service routine
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I want to access/record the user stack within the system call
service routine sys_sigsuspend() (arch/ppc/signal.c),
in order to debug hanging threads.

The user register context is passed to sys_sigsuspend() via
the 'struct pt_regs *regs' argument.

In this way I can obtain the stack pointer r1
(via regs->gpr[1]) and catch the PPC EABI stack frames.

But I see all zeros behind 'regs->gpr[1]' instead of proper
stack frames. What is wrong ?

How can I access the user stack within a
system call service routine (sys_XXX) ?

Thank you for help,


Steffen

--


--------------------------------------------------------------

Steffen Rumler
ICN ON PNE SB 4
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
