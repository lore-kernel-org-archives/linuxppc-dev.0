Message-ID: <39D85AD0.D2B28422@student.ethz.ch>
Date: Mon, 02 Oct 2000 11:52:16 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
References: <Pine.LNX.4.10.10010011902590.1560-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > Did you try with a framebuffer (vesafb for instance) on x86, and the
> > > UseFBDev option? Did anyone ever try?
> >
> > Yeap i tried it with aty128fb (long time ago), without busID set
> > everything works you don't get anything in the screen, no panics/locks as
> > in the ppc side.
>
> Which isn't exactly the same because the problem only manifests with
> conflicting PCI resources set up before the kernel starts. And that -so
> far- only happened with some Mach64 based Macs.
>
> aty128fb not having any problem doesn't prove atyfb can't have these
> problems on Intel, too.

AFAIK Kostas was talking about the problem that if you don't specify the bus
ID when using an fbdev driver, X disables the graphics chip because no driver
claims it. And he wondered why this locks the machine on PPC while it only
makes the server fail on i386. Right, Kostas?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
