Message-ID: <366A3198.105944B9@wanadoo.fr>
Date: Sun, 06 Dec 1998 08:26:16 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
References: <Pine.LNX.4.02.9812052310580.864-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> 
[]
> Another thing is keyboard and mouse (ADB) handling. Xpmac uses the plain
> /dev/adb device, while XF68_FBDev takes the standard Linux keyboard input and
> uses the adbmouse driver. I assume keyboard won't be a problem. But the mouse
> requires the adbmouse driver.

Did you fix the problem with the non-working option (alt) keys?
In the XF68_FBDev of the new R5beta linuxppc, it is still there.
For me (PM6400, standard Apple keyboard and 1-button mouse), XF68_FBDev
is pretty much useless. 

If you need more information to get to the bottom of this problem, just
say what kind of tests to perform.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
