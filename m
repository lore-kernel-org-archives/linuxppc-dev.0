Message-Id: <200007302032.VAA26494@hyperion.valhalla.net>
Date: Sun, 30 Jul 2000 21:33:03 +0100
Subject: Re: LinuxPPC X Server
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michel Dnzer" <daenzerm@student.ethz.ch>
CC: SteffenH@hyperion-software.de, takashi oe <toe@unlserve.unl.edu>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Michel,

I *did* say I saw very new to this...

on  Sun, Jul 30, 2000, Michel D‰nzer wrote:
> Iain Sandoe wrote:
[...]

> Before building, you should have copied xc/config/cf/{xf86site,host}.def
>
> Then edit the newly created host.def - you probably only want to build the
> server and drivers, and choose the drivers you want.

Oh-oh.

This was a step missing from the instructions :-(

Maybe I complied a lot more than necessary (and hence the time)...

Would I need to build all the apps once (so that they are compatible?).

After that, I suppose, I just rebuild the driver when the rsync changes...

> For DRI, you may have to edit even more files in config/cf/, AFAIK DRI is only
> built on i386 by default.

Do I also need to enable different support in the kernel?
(e.g. /dev/agpart support ?)
(there's been a fair amount about different fb stuff flying around...)
(I have ATI{mach64,r128}/IMSTT support enabled by default - since these are
the cards I have).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
