Message-Id: <4.2.2.20000121163838.05255ad0@mail.munich.netsurf.de>
Date: Fri, 21 Jan 2000 16:47:33 +0100
To: Gabriel Paubert <paubert@iram.es>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10001202357570.18916-100000@gra-ux1.iram.es>
References: <00012023473100.01038@enzo.bigblue.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 01:05 21.01.00 , Gabriel Paubert wrote:



>On Thu, 20 Jan 2000, Franz Sirl wrote:
>
> > It depends a little bit on the usage of the asm's if the memory (either
> > global or local) clobber is needed or not. If you use them for
> read/writes to HW
> > registers needing ordering (which is very likely here since we talk about
> > graphics HW), the compiler can only decide on the memory usage defined
> by the
> > clobbers/memory inputs on how to order the inlines (volatile has no
> effect on
> > this).
>
>Do you mean that a volatile memory reference can be reordered wit an asm
>volatile statement ? I thought theat this was not possible.
>
> >From GCC's documentation:
>
>    "You can prevent an `asm' instruction from being deleted, moved
>significantly, or combined, by writing the keyword `volatile' after the
>`asm'."
>
>You might disagree, but I consider that moving across a volatile memory
>reference is a _significant_ move, a very significant one.

asm volatile doesn't declare any volatile memory references! What makes you
think it does?
There was a lengthy discussion about this with Richard Henderson on the
gcc/egcs lists a while ago. The result was a rewrite of
linux/include/asm-ppc/io.h in the kernel to it's current state.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
