Date: Mon, 8 Mar 1999 16:17:59 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Sean Harding <sharding@oregon.uoregon.edu>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: platinumfb problems
In-Reply-To: <Pine.SGI.4.10.9903081220250.11304-100000@gutenberg.uoregon.edu>
Message-ID: <Pine.LNX.3.96L.990308160733.20767A-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Mar 1999, Sean Harding wrote:

> On Mon, 8 Mar 1999, Hollis R Blanchard wrote:
> 
> > Using the cmdline "root=/dev/sdb5 video=platinumfb:vmode:17,cmode:8" (from
> > /proc/cmdline), Linux starts in screwed up palette mode, which would seem to
> > indicate 16bit color (I'm running X great in 8bit, but trying to use 16bit
> > makes for an annoying palette).
> > 
> > It seems that with platinumfb, 16bit color is wrong in both console and X.
> > 'vmode 17 8' in console and 'startx -- -depth 8' make the colors sane again.
> 
> Are you using XF68fbdev or Xpmac? I'm still using Xpmac, and after some
> modifications to platinumfb.c, I can run in 16bpp with no problems.
> 24/32bpp has the right palette in X, but has funny colors in text mode and
> an annoying line going across the screen...

Xpmac. I haven't heard of any benefit for XF68, only config file nightmares.
If there was an Xconfigurator (I'm still using R4), I'd at least consider
it...

Are the changes you made to platinumfb.c general fixes, or specific hacks? I
heard someone else talking about a funny line, too (LinuxPPC@associate.com, I
believe).

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
