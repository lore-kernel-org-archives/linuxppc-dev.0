From: jlquinn@us.ibm.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <8525685E.0054AAAB.00@D51MTA03.pok.ibm.com>
Date: Thu, 6 Jan 2000 10:25:15 -0500
Subject: Building 2.3.35?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried to build the standard 2.3.35 kernel without success.  Does anyone
know what's going on?

I'm building a kernel for powermac only and having problems with irq_offset
not being a member of
struct hw_interrupt_info(?).  In particular, arch/ppc/kernel/open_pic.c
doesn't build in this kernel.  The struct is defined in include/linux/irq.h
and doesn't have this field.  Also, to my uninformed eye, pmacs don't even
require open_pic.c

In 2.2.13, irq_offset is a member of struct hw_interrupt_info, which is
declared in arch/ppc/kernel/local_irq.h.  So obviously this struct was
deemed to be useful to other architectures but in the meantime, this field
was removed.

I've tried to untangle this enough to build, but haven't succeeded so far.

Thanks for any help,
Jerry Quinn
jlquinn@us.ibm.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
