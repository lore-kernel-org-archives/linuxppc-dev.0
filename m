Date: Mon, 23 Aug 1999 16:16:23 -0400
From: brad allison <jackal@aol.net>
To: rshaw@inficad.com
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        puetzk@iastate.edu
Subject: Re: BootX enhancement request
In-Reply-To: <37C16FFE.84ACEA73@motorola.com>
Message-ID: <Pine.SGI.4.00.9908231613030.7470-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Mon, 23 Aug 1999, Robert Shaw wrote:

> Brad,
> 
> Once again, you DO NOT NEED TO DO THIS! The B&W G3 now has video support.
> 
> If you've downloaded the latest kernel from my web-site, you can specify the
> video mode you want from the kernel arguments of BootX. Add the following to you
> kernel arguments:
> 
> video=aty128fb:vmode:17,cmode:32
> 
> That will give you 1024x768 @ 75Hz, w/32bpp. Piece of cake, no init'ing, no
> rebooting, no running Xautoconfig.
> 

I think you missed my point.  Don't get me wrong, that's cool to know.
But I was thinking more along the lines of a drop down menu to set the
resolution from BootX rather than cryptic kernel arguements.

It seems the 2.2.10 kernel will not sync to the video settings at all
without the kernel arguements.

> The FAQ page at my site (http://www.inficad.com/~rshaw/g3_faq.shtml) 
> also has the
> reproduction of the vmode settings that are available. They work, and
> no running of Xautoconfig is needed.

Well i think putting Xautoconfig in the rc.local file is still a good
idea.

-b


> 
> 
> brad allison wrote:
> 
> > I'm not sure how hard/not hard this would be to do, but right now in order
> > to change resolutions I have to boot into MacOS, set my resolution, launch
> > BootX, boot into init 3, run Xautoconfig, boot into init 5.
> >
> > That's a lot of work to just change the resolution for X.
> >
> > It would be nice if you could set the resolution and color from BootX on
> > boot up.
> >
> > If there's a easier way to change pixel depth and resolution from inside X
> > please let me know....
> >
> > -b
> >
> > --
> > AOL SAPI                                        703.265.0908     AIM:jackal242
> > http://jackal.fudge.org        `I was never more certain of how far away I was
> > from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca
> 

--
AOL SAPI 		                        703.265.0908     AIM:jackal242
http://jackal.fudge.org        `I was never more certain of how far away I was
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
