Message-ID: <398EAE77.EEB275AC@student.ethz.ch>
Date: Mon, 07 Aug 2000 14:41:27 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Multi-head on Pismo
References: <854304.3174574500@[209.147.134.131]>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Wojtulewicz wrote:
>
> I've been playing around recently trying to get multi-head support on my
> Pismo laptop to work.  This is using the built-in VGA port along with the
> LCD.  I have a few questions/comments.  Currently, I'm using XF86 4.0.1
> with the r128 driver and kernel 2.2.17pre10-ben2.
>
> I have tried simply modifying the ServerLayout in the XF86Config file, but
> this will not work (I don't think) since both the VGA port and the LCD are
> run off the same Rage128 chip.  All examples I have seen of using Xinerama
> to do this have used 2 sepearte cards.  I'm using the command 'startx --
> +xinerama' to start X.
>
> When the machine boots, a message pops up on the external message as
> follows:
>
> ...ok
> Copying OF device tree...done
> Initing fake screen
> Calling quiesce
>
> then the screen goes black and remains that way for the session.  What does
> this mean?
>
> (Possible OT) Another thing I noticed while poking around in the device
> tree is that there are two ATY,RageM3p entries under
> /proc/device-tree/pci/ATY,RageM3pParent.  They are pA and pB.  What do
> these two have to do with each other?
>
> Has anyone else out there worked on this, and (hopefully) gotten it to work
> right?  Thanks for any help you can give.

AFAIK dualhead isn't properly supported by either XFree86 nor aty128fb yet.
The only possibility might be to set things up in MacOS, then boot using BootX
'without video driver' and then use offb.


Michel


--
People who are wrong the most are wrong the loudest.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
