Date: Sun, 6 Dec 1998 01:11:30 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
In-Reply-To: <Pine.LNX.4.02.9812052310580.864-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.05.9812060110210.954-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Dec 1998, Geert Uytterhoeven wrote:

> Another thing is keyboard and mouse (ADB) handling. Xpmac uses the plain
> /dev/adb device, while XF68_FBDev takes the standard Linux keyboard input and
> uses the adbmouse driver. I assume keyboard won't be a problem. But the mouse
> requires the adbmouse driver.

Well, globegate GENERIC kernels have the slightly-better then current
adbmouse driver from linuxpmac (does macx mice w/o problem).

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
