Message-ID: <399989FD.29EFBABA@pop.agri.ch>
Date: Tue, 15 Aug 2000 20:20:48 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: Jack Howarth <howarth@bromo.med.uc.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: bk 2.4-test7 broken
References: <200008150304.UAA31773@bromo.med.uc.edu> <39992943.C267C4CB@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
>
> Hi,
>
> I too would like to know if somebody has this kernel running.

Up to now NO.

>
> This one has been included in the bitkeeper kernel in the meantime.
> On the other hand, the corresponding changeset introduced another bug by
> changing the type of the function find_via_cuda() from void to int, but
> only its declaration in the header file include/linux/cuda.h and not its
> definition in drivers/macintosh/via-cuda.c. Doesn't compile.

Changed the int also in via-cuda.c -> It compiles with warnings.

> > The third problem is more serious. The resulting kernel gets stuck in
> > the Freeing unused kernel memory stage. This is similar to the problem
> > Geert mentioned earlier on the mailing list.
>
> Mine gets stuck after saying "arch: exit" and before switching from the
> prom console to the fb console (no penguin).

On the wallstreet  I get as far as Jack does, but my screen is
unreadable. On the 7200 (601-cpu) I enter the xmon just after arch:exit.
The only thing I see here is this:

vector: 700 at pc = c00061bc, lr = c0004bd4, msr = 81030, sp = c0208f10 [c0208e60]
current = c0207020, pid = 0, comm = swapper.

No key input works..... (also ctrl apple power doesn't maybe due to my
usb & adb combination?)


Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
