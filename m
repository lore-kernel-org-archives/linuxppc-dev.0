Message-ID: <3874B709.86897215@pop.agri.ch>
Date: Thu, 06 Jan 2000 16:38:49 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: jlquinn@us.ibm.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Building 2.3.35?
References: <8525685E.0054AAAB.00@D51MTA03.pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




jlquinn@us.ibm.com wrote:
> 
> I tried to build the standard 2.3.35 kernel without success.  Does anyone
> know what's going on?
> 
> I'm building a kernel for powermac only and having problems with irq_offset
> not being a member of
> struct hw_interrupt_info(?).  In particular, arch/ppc/kernel/open_pic.c
> doesn't build in this kernel.  The struct is defined in include/linux/irq.h
> and doesn't have this field.  Also, to my uninformed eye, pmacs don't even
> require open_pic.c
> 
> In 2.2.13, irq_offset is a member of struct hw_interrupt_info, which is
> declared in arch/ppc/kernel/local_irq.h.  So obviously this struct was
> deemed to be useful to other architectures but in the meantime, this field
> was removed.
> 
> I've tried to untangle this enough to build, but haven't succeeded so far.

The problem is known and Cort replied me yesterday that he is working on
that. He said maybe in the next one or two versions it should be fixed.
AFAIK the latest working 2.3.X kernel was the 2.3.29 from
linuxcare.com.au.
All other higher kernel I got to build but not to boot.

Have you other experiences?

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
