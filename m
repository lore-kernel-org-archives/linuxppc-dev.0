Date: Fri, 21 Jul 2000 01:18:16 -0700 (PDT)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200007210818.BAA36993@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: xf4 bug report
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Steffen Haeuser reported the following XFree86 4.0 bugs in linuxppc
in case anyone is interested in looking into these problems...

----------------------------------------------------------------------
Hi!

Despite the fact I cannot use LinuxPPC for release-version games currently I
am
keeping the LinuxPPC version (which is basically just a different makefile
than
the Linux-x86 version :) ) of the game I am currently working on on the latest
state.
On this I encountered some bugs in the V4 X Server. I guess you are interested
in
bugreports ? :)

1. VidModeExtension

If I have a 640x480 and a 1024x768 mode defined in XF86Config, after the call
of

XF86VidModeGetAllModeLines

I get those reported as

640x481
1024x769

If I just ignore this and switch to the mode anyways, I get a display which is
completely
garbaged, as if a wrong BytesPerRow is used. This only happens in 640x480
though,
in 1024x768 this works fine.

Next is: When I do a XGetVisualInfo for a different depth like the current
screen
this fails (as I understand it it should not fail, and if a image with the
different
depth is then created, the XShmPutImage should convert for the X Server V
4.0).

Asides from that I did not find any bugs - yet :)

Of course these issues are minor issues for myselves... the big issue is the
3D
Acceleration for me :) ...

Steffen
----------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
