Date: Mon, 4 Feb 2002 15:46:26 -0800
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: two aty128 frame buffers?
Message-ID: <20020204154626.C28199@reepicheep.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know how hard it would be to hack aty128fb to support a
second Rage 128?  Or am I better off trying to get the X server to talk
directly to the second card?

I have two PCI Rage 128's in my G4, which I'd like to use in a
dual-headed Xinerama set up.

So far I've only been able to get the X server (4.1.0 and 4.2.0) to
work through framebuffer driven cards (X's ati/r128 drivers with aty128fb
and X's fbdev with offb).

When I've tried to tell X to talk directly to the unmanaged video card it
complains about some unresolved drm symbols (they're different for 4.1
and 4.2, for 4.1 its:  "Symbol drmScatterGAtherAlooc from module
/usr/X11R6/lib/modules/drivers/r128_drv.o").  I've tried with and without
drm supporting kernels.

Does anyone have any suggestions?

Thanks,
--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student
Information and Computer Science
University of California, Irvine


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
