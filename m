Message-ID: <396FE531.6A2CA8E5@uncc.edu>
Date: Sat, 15 Jul 2000 00:14:42 -0400
From: "William H. Schultz" <whschult@uncc.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Bug in kernel?
References: <200007140501.AAA07235@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all.  I believe I have just found a bug in the kernel.

Conditions:

8500 G3 266   Voodoo3    1280x1024
Compiling XFree86 v4.0.1   and  vmlinux v2.2.17pre11    and    vmlinux
v2.4.0test4
(and playing mp3's)  --  running on 2.4.0test2


I noticed after having left the computer at the terminal where XFree was
compiling, if I left the computer there for a while, the clock would be
wrong when I came back.  I didn't think anything of it until I realized
that the clock being wrong coincided with my music skipping, which also
coincided with the extremely long screen update times caused by the
heavy text on the screen and the slow voodoo3 driver.

I'm no kernel expert, but I know that the accuracy of the clock should
not be affected by how fast the video card can update the screen.

here's how dramatic the effect can be:

In a mater of two minutes, I was able to make the clock lose 12
seconds.  Letting it run while I watched a TV show, I was able to make
the clock lose 10 minutes.

This may not be a security risk--I'm not a security expert--but I have
seen servers deny requests to clients because the clock was too far off.


I just wish I knew enough about linux to also be able to post a fix with
this message.


Hank

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
