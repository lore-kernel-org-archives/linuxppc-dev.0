Date: Mon, 7 Dec 1998 09:50:14 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Tom Rini <tmrini@ntplx.net>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5 and XFree86-3.3.3
In-Reply-To: <Pine.LNX.4.05.9812062303340.1031-100000@pc.wackyland.com>
Message-ID: <Pine.LNX.4.03.9812070948510.31794-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Dec 1998, Tom Rini wrote:
> Ok.  Assuming everything is setup like it should be, sometime between now
> and two days from now, two sets of XFree86-3.3.3 rpms should show up on
> dev.linuxppc.org for pre-R5 (ie glibc 2.0.10x).  XFree86-3.3.3-*-10a is
> 3.3.3 with the patches for the non-accel Xpmac and FBDev.  -10b (building

Great!

> now) has Xpmac_mga from 981122 and Geerts accel patch from 981204-2.   I'm
> not sure how but I believe there's an option to turn off accel in Xpmac if
> needed, and adding option noaccel (Geert?) to your XF86Config will turn
> off accel in the FBDev server.  The reason of course for the delay is
> mirroring it all over. :)

Yes, add `option "no_accel"' to `Section "Device"' to disable acceleration. The
X server will tell you it disabled acceleration, so you get feedback.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
