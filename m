Date: Sun, 6 Dec 1998 23:07:46 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: linuxppc-user@lists.linuxppc.org
cc: linuxppc-dev@lists.linuxppc.org
Subject: pre-R5 and XFree86-3.3.3
Message-ID: <Pine.LNX.4.05.9812062303340.1031-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok.  Assuming everything is setup like it should be, sometime between now
and two days from now, two sets of XFree86-3.3.3 rpms should show up on
dev.linuxppc.org for pre-R5 (ie glibc 2.0.10x).  XFree86-3.3.3-*-10a is
3.3.3 with the patches for the non-accel Xpmac and FBDev.  -10b (building
now) has Xpmac_mga from 981122 and Geerts accel patch from 981204-2.   I'm
not sure how but I believe there's an option to turn off accel in Xpmac if
needed, and adding option noaccel (Geert?) to your XF86Config will turn
off accel in the FBDev server.  The reason of course for the delay is
mirroring it all over. :)

Of course if I'm wrong about the setup then it may take a bit longers for
'em to show up.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
