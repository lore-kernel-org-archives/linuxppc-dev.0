Message-ID: <19981205231203.A1422@merelda.uiuc.edu>
Date: Sat, 5 Dec 1998 23:12:03 -0600
From: anthony tong <atong@uiuc.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
References: <Pine.LNX.4.02.9812052310580.864-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.02.9812052310580.864-100000@cassiopeia.home>; from Geert Uytterhoeven on Sat, Dec 05, 1998 at 11:20:33PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven (Sat, Dec 05, 1998 at 11:20:33PM +0100):
>   2. Adopt XF68_FBdev so it can use the MkLinux video mode ioctl stuff. This
>      requires no kernel changes. In XF68_FBDev, the video ioctl and mmap stuff
>      has to be changed slightly.
> 
> I think the second solution is the least amount of work.

Agreed.

> Another thing is keyboard and mouse (ADB) handling. Xpmac uses the plain
> /dev/adb device, while XF68_FBDev takes the standard Linux keyboard input and
> uses the adbmouse driver. I assume keyboard won't be a problem. But the mouse
> requires the adbmouse driver.

Mark Hatle ported /dev/adbmouse to mklinux last february. It wasn't
available in DR3 but I believe that it's available in the GENERIC
mklinux kernels.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
