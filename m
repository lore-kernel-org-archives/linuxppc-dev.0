Date: Sun, 6 Dec 1998 16:13:38 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
In-Reply-To: <366A3198.105944B9@wanadoo.fr>
Message-ID: <Pine.LNX.4.02.9812061549490.323-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Dec 1998, Martin Costabel wrote:
> Geert Uytterhoeven wrote:
> > Another thing is keyboard and mouse (ADB) handling. Xpmac uses the plain
> > /dev/adb device, while XF68_FBDev takes the standard Linux keyboard input and
> > uses the adbmouse driver. I assume keyboard won't be a problem. But the mouse
> > requires the adbmouse driver.
> 
> Did you fix the problem with the non-working option (alt) keys?
> In the XF68_FBDev of the new R5beta linuxppc, it is still there.
> For me (PM6400, standard Apple keyboard and 1-button mouse), XF68_FBDev
> is pretty much useless. 

What about the XF68_FBDev from XFree86 3.3.3?

> If you need more information to get to the bottom of this problem, just
> say what kind of tests to perform.

Problem is that I don't know anything about ADB, nor have ADB devices :-(

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
