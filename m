Message-ID: <398E61C2.BF0ED1ED@student.ethz.ch>
Date: Mon, 07 Aug 2000 09:14:10 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: dri-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
References: <Pine.LNX.4.21.0008041831040.29474-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:

> > The remaining problems are:
> >
> > 16 bit doesn't work neither with fbdev (colors completely off - does
> > aty128fb still use 15 bit in fact?) nor without (at least the grey tones
> > are right there - wrong endianness?)
>
> Yes aty128fb still doesn't support 16 bit, you could run the r128 driver
> without fbdev to get 16 bits, but the code to switch the framebuffer to do
> byteswapping is missing so the colors will be wrong

Yep, that's the second thing I was referring to.

> (easy to add though).

Where and how?


> > About performance: It's much better than software rendering (at least for
> > big windows) of course, however not too fast with lots of polygons. AGP
> > GART would definitely be a good thing I guess (Ben: hint, hint :)
>
> Do you have any numbers from gears, glquake etc ??

The numbers are very varying and not too high yet. AGP GART should change
that.


Michel


--
                                Tax the rich.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
