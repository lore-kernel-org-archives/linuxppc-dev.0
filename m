Message-ID: <3999BA6D.C7C249B0@pop.agri.ch>
Date: Tue, 15 Aug 2000 23:47:28 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>,
        Jack Howarth <howarth@bromo.med.uc.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: bk 2.4-test7 broken
References: <200008150304.UAA31773@bromo.med.uc.edu> <39992943.C267C4CB@wanadoo.fr> <399989FD.29EFBABA@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To answer myself...

Andreas Tobler wrote:

> On the wallstreet  I get as far as Jack does, but my screen is
> unreadable. On the 7200 (601-cpu) I enter the xmon just after arch:exit.
> The only thing I see here is this:
>
> vector: 700 at pc = c00061bc, lr = c0004bd4, msr = 81030, sp = c0208f10 [c0208e60]
> current = c0207020, pid = 0, comm = swapper.

A previous test on linux-pmac-devel(2.4.0-test5) was successful (until
to the adaptec...), so I tought the changes got in in bk too. Nop, a
reminder on a previous mail from Takashi I checked the time.c in
arch/ppc/kernel. The 'mftb' call is still there..... (which the 601
doesn't likes/understands)

So I think a merge between linuxcare-devel and bk isn't done up to now...

Andreas

BTW, on the wallstreet I see the boot log ok when I booted with
BootX.app. So I suppose it's depending on the registers....

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
