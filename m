Message-ID: <3A721E68.6E85EB0E@iiic.ethz.ch>
Date: Sat, 27 Jan 2001 02:03:36 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Josh Huber <huber@alum.wpi.edu>
CC: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Graphics corruption with XF
References: <20010126133941.A7973@missioncriticallinux.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:

> X reports that it could only find 1 MB of video memory, when I'm
> pretty sure it's got 4 MB.  This of course severly limits my
> depth/resolution, and when paired with the rage 128 I'm currently
> using it's a little lacking.. :)

man XF86Config, look for VideoRam.


> The real problem is that there seem to be some issues with the ati
> driver with respect to this card.  The problem definately seem to be
> endian related and affect both graphics and text.
>
> Text is corrupted such that the characters are a mirror image of each
> other (swapped on the y-axis).  Graphics are fuzzy, and the cursor is
> definately corrupted.
>
> Has anyone had any luck with a combination like this?

Anyone who has must have fixed the ati driver ;)

I suppose it shouldn't be too hard to fix looking at the r128 or glint
drivers.

Oh, BTW - have you tried Ani's rsync tree?


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
