Message-ID: <3984708A.D2D39371@student.ethz.ch>
Date: Sun, 30 Jul 2000 20:14:35 +0200
From: Michel D	nzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: SteffenH@hyperion-software.de, takashi oe <toe@unlserve.unl.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
References: <200007301959.UAA25203@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> >>And yes, there have been reports of people trying it (one yesterday - said
> >>it was quicker in some places & slower in others...)

He didn't provide any numbers though. For all chipsets which have an
accelerated driver in X 4, it's almost certainly faster than anything else -
and also for the others it should be faster than X 3.3.x .


> > Did these sources you have compiled include the DRI Drivers ?
>
> Don't know - I did a make "World" so I guess that should have built everything?

See my remark at the end.


> > You told it took 1 day to do... so there were big problems/source code changes to do
> > ? Or what caused this ?
>
> No problems, no changes, it's just *BIG* :-)

Before building, you should have copied xc/config/cf/{xf86site,host}.def

Then edit the newly created host.def - you probably only want to build the
server and drivers, and choose the drivers you want.

For DRI, you may have to edit even more files in config/cf/, AFAIK DRI is only
built on i386 by default.


Michel


--
#include <stdsig.h>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
