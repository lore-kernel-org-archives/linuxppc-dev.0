Date: Sun, 1 Oct 2000 19:05:31 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Michel Dänzer <daenzerm@student.ethz.ch>, R Shapiro <rshapiro@bbn.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <Pine.LNX.4.21.0009301631060.2538-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10010011902590.1560-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Did you try with a framebuffer (vesafb for instance) on x86, and the
> > UseFBDev option? Did anyone ever try?
>
> Yeap i tried it with aty128fb (long time ago), without busID set everything
> works you don't get anything in the screen, no panics/locks as in the ppc
> side.

Which isn't exactly the same because the problem only manifests with
conflicting PCI resources set up before the kernel starts. And that -so
far- only happened with some Mach64 based Macs.

aty128fb not having any problem doesn't prove atyfb can't have these
problems on Intel, too.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
