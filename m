Date: Mon, 2 Oct 2000 15:24:40 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <39D85AD0.D2B28422@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10010021515110.13068-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Which isn't exactly the same because the problem only manifests with
> > conflicting PCI resources set up before the kernel starts. And that -so
> > far- only happened with some Mach64 based Macs.
> >
> > aty128fb not having any problem doesn't prove atyfb can't have these
> > problems on Intel, too.
>
> AFAIK Kostas was talking about the problem that if you don't specify the bus
> ID when using an fbdev driver, X disables the graphics chip because no driver
> claims it. And he wondered why this locks the machine on PPC while it only
> makes the server fail on i386. Right, Kostas?

My answer would be similar - with UseFBDev, the X server handles color
maps and mode switching via the kernel driver (at least for mach64,
didn't check r128). A failed PCI access in a kernel driver results in a
panic on PPC (machine check). It may be caught and handled by a signal on
x86 (simple bus error?).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
