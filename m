Message-ID: <386B6101.BDCEC7B3@pop.agri.ch>
Date: Thu, 30 Dec 1999 14:41:32 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: asm-m68k/setup.h in setup.h
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I'm playing with buildkernel from http://www.pobox.com/~wstearns/buildkernel/
That is a 'program' which should make it easy to build a kernel. I have
to find out......

Now this script removes all other archs from the kernel tree. Especially
the asm-m68k in the include directory.
When building the kernel it fails because asm-m68k/setup.h is not available.
I saw that asm-ppc/setup.h includes this file. 
In asm-ppc/setup.h m68k_num_memory and m68k_memory are defined. These
two are declared extern in asm-m68k. 
Are there other things needed from asm-m68k/setup.h?

I could build a kernel with the buildkernel script. I had to copy the
asm-m68k into the include directory.

Does it make lot of work to isolate the ppc tree? Or is there no need/
no wish to do that?
BTW, this is done on a 2214pre17 kernel. So if there are further changes
in 2.3???

Thanks
Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
