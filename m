Message-ID: <384E9672.7632BAB9@amberdata.demon.co.uk>
Date: Wed, 08 Dec 1999 17:33:38 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: linuxppc-workstation@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ problems on IBM 850
References: <Pine.HPX.4.10.9911050931010.2724-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry to reply so late, but I went on holiday.

Gabriel Paubert wrote:
> 
> On Thu, 4 Nov 1999, Hollis R Blanchard wrote:
> 
[..]
> 
> Using interrupt 13 is strange, to say the least. It was reserved for FPU
> errors on x86 processors. In your case obviously the interrupts are
> expected (since you have a timeout) but have stayed masked for some
> reason. We have to find where this happens. Some code paths might have an
> unbalanced enable/disable_irq but I suspect that it will be hard to find.
> 

Umm. Possible data point which may help here - I cannot cause my machine
to do anything silly unless I hit two interrupt sources at the same
time. I can compile kernels on the IDE disk (irq 13) till the cows come
home if I don't have the ethernet enabled and don't play with the mouse
too much. If I enable the ethernet (irq 15 I think), or play with the
mouse a lot (irq 12), sooner or later I die. My (very uneducated) guess
is that it has something to do with getting two interrupts in a very
short space of time. I guess I should try thrashing one of the lower 8
interrupts (serial mouse I guess would do it) and see if that can cause
problems, or whether it is restricted to the second controller.

[..]

Cheers,

        David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
