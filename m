To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Multi-boot advice.
References: <200007052323.AAA07099@hyperion.valhalla.net>
	<20000705193003.A4238@frontiernet.net>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 06 Jul 2000 11:37:06 +0200
In-Reply-To: Dan Foster's message of Wed, 5 Jul 2000 19:30:03 -0400
Message-ID: <8xaefv1tx9.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Foster <dsf@gblx.net> writes:

>
>
> Hot Diggety! Iain Sandoe was rumored to have wrote:
> >
> > Hi all,
> >
> > I've just got a G4/500 - and I want to configure it to boot:
>
> Me too :) I haven't gotten LinuxPPC 2000 to boot the 2.2.15pre3 kernel yet,
> so haven't installed that one yet, but MacOS 9 and MacOS X works good.
>
> > I think I read that I must put the Linux boot partition before the
> > MacOS - X one?
> > Does it matter which partition is the MacOS-9 one?
>
> According to the OS X docs, I believe it says MacOS 9 must be installed
> first, so presumably first partition or so. MacOS X can go anywhere, as
> I think is also true for LinuxPPC.
>
I recommend installing MacOS X before you install Linux, because the MacOS X
installer can subdivide a single OS X partition into root, swap, and usr
partitions. This changes the numbers of all partitions beyond, potentially
confusing an already installed Linux.

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
