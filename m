Date: Sat, 27 Oct 2001 20:52:04 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GeForce on PPC == _no work_
In-Reply-To: <Pine.BSF.4.32.0110271946440.10582-100000@shell.unixbox.com>
Message-ID: <Pine.LNX.4.33.0110272042380.15992-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 27 Oct 2001, Ani Joshi wrote:

> Well, the problem is you are using a fp with the ADC port.  This isn't
> supported as there is no documentation on how I am supposed to powerup and
> run the DVI port.  On ppc, rivafb only supports the VGA port right now
> unless some secret docs are leaked out of nvidia, same goes with X.

:set whiny-bitch-mode=1

Well, FIX IT!

:set whiny-bitch-mode=0

But seriously. Then the real question is, who to beat... err, talk to
about this. Obviously replacing the video card is an undesirable option at
best, since that will involve replacing the monitor _and_ video card just
to run X. Double-plus-ungood. Maybe if I get the mode settings in
riva/fbdev.c right, maybe I could get video working there? Since it was
sorta working before. I might, of course, be all wet, but I think the
values I was using were part of the problem. I tried to use 24bpp mode,
and it may just not have liked the fact that I probably didn't setup the
color bitfields right. I'll play with that some more. fbdev may be my only
option for now, if I can get rivafb to play ball.

Think talking to Mark Vojkovich (since he _does_ work for nVidia now)
might make any headway? fbdev, if I can get it working, would be a start.
However, it's (of course) going to be painfully slow too, compared to
accelerated 2D.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
