Message-ID: <37D853D5.54331958@ctam.com.au>
Date: Fri, 10 Sep 1999 10:41:58 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: glibc for mpc860
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Dan Malek wrote:

> > Any chance you could put your libc-1.99 (or a pointer to it) up at
> > ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/ ?

> It's been there a long time....libc-1.99-8xx.somthing_or_other.
> It's compiled with the -mcpu=860 flag, has the cache line stuff
> patched (so you can run copyback on the 8xx), and has the floating
> point assembler instructions removed.  It was built from
> glibc-0.961212-1o, and is a tar image.

What is the latest glibc that supports the MPC860 processor and where
can I get it.  I dowloaded the latest glibc (2.1.1) from a GNU mirror
and it compiled fine with my egcs-1.1.2 powerpc-linux cross-compiler.  I
tried adding the -mcpu=860 option and it barfed.  Problems with floating
point instructions as far as I can tell.  I assume that the glibc
developers do not consider targets without a floating point processor as
a non-priority (I wish the MPC860 had an FPU).  It looks like others
have ported/modified some glibc sources to work with the -mcpu=860
option.  What version is it and where can I get it.  Are the modified
glibc sources available as an archive and/or are there patches for any
other glibc sources.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
