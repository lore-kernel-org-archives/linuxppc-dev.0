Message-ID: <3AA60D9F.FEABC67A@dspace.de>
Date: Wed, 07 Mar 2001 11:29:51 +0100
From: Andreas Schreckenberg <ASchreckenberg@dspace.de>
Reply-To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to use fp unit in kernel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

i got a floating point unavialable exception, if i use
floating point instructions within a module
in the kernel. why ?
(kernel 2.4.0 on a PPC750 board)

the kernel is compiled with -msoft-float, and my
kernel module whithout this option.

If i compile the kernel without -msoft-float,
i cannot insert my module because some __xxxx
symbols cannot be resolved by the module linker.
(i linked my module static
again the math library libm.a, so sin(x) should
be available)

the kernel receives a trap 0x800 (fp unavailable)
prints a message:
floating point used in kernel (task=%p, pc=%x)\n
turns on the fp in the msr and exit.

what must i do ?
best thing whould be: everything in kernelmode
should use the fp unit ?
is that the best or not (performance) ?

What do the enable_kernel_fp() function ?
at which moment must this be invoked.

i would thank you for any help
Andreas
--
          Life's not fair. But the root password helps ! :-)
                   http://schrecky.home.pages.de
               Open minds. Open sources. Open future.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
