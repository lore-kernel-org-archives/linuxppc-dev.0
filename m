Subject: Question about modules
From: Ibon Gotxi Garcia <igotxi@jazzfree.com>
To: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1046424964.385.3.camel@muse>
Mime-Version: 1.0
Date: 28 Feb 2003 09:36:04 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to write a simple module for an 8xx board using the SMC2.
Everything works, till I try to insmod it: I get m8xx_cpm_alloc and
m8xx_cpm_hostalloc as unresolved symbols.

I think that arch/ppc/8xx_io/commproc.c is properly compiled (I can see
both symbols on vmlinux), but somehow the build process strips them off
as they are unused (i cannot see them in /proc/ksyms in the target). Is
that right? Any clue to solve it? (having them in the target kernel
without modifying the original sources)

Many regards.
ibon

--
Ibon Gotxi Garcia <igotxi@jazzfree.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
