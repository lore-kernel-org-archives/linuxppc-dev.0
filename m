Message-Id: <200202050524.OAA13555@mail.highway.ne.jp>
Date: Tue, 5 Feb 2002 14:21:27 +0900 (JST)
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: two aty128 frame buffers?
To: jronne@ics.uci.edu
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020204154626.C28199@reepicheep.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  4 Feb, Jeffery von Ronne wrote:
>
> Does anyone know how hard it would be to hack aty128fb to support a
> second Rage 128?  Or am I better off trying to get the X server to talk
> directly to the second card?
>
> I have two PCI Rage 128's in my G4, which I'd like to use in a
> dual-headed Xinerama set up.
>
> So far I've only been able to get the X server (4.1.0 and 4.2.0) to
> work through framebuffer driven cards (X's ati/r128 drivers with aty128fb
> and X's fbdev with offb).
>
> When I've tried to tell X to talk directly to the unmanaged video card it
> complains about some unresolved drm symbols (they're different for 4.1
> and 4.2, for 4.1 its:  "Symbol drmScatterGAtherAlooc from module
> /usr/X11R6/lib/modules/drivers/r128_drv.o").  I've tried with and without
> drm supporting kernels.
>
> Does anyone have any suggestions?

Add drm in Section Module

Section "Module"
	Load  "drm"
EndSection

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
