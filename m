Date: Wed, 19 May 1999 09:27:02 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Jerry Quinn <jquinn@nortelnetworks.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: OF booting news
In-Reply-To: <3742B7FE.9F30D222@americasm01.nt.com>
Message-ID: <Pine.SUN.4.02.9905190926070.19636-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 May 1999, Jerry Quinn wrote:

> Tom Rini wrote:
> > 
> > On Sat, 15 May 1999, Benjamin Herrenschmidt wrote:
> > 
> > > For those who haven't seen it yet, with Darwin 0.2, Apple release new
> > > pieces of source code, including the secondary loader, with sources, a
> > > working of control video driver, and more... That's interesting because
> > > we should now be able to make a great secondary booter with OS choosing
> > > capabilities. I don't have time to look into this now, but this could be
> > > a good replacement for BootX in the future.
> > 
> > It looks like most part of the MkL booter were canablized in this as well.
> > So it should be possible to do the following, with a little work:
> > On old (not New World) ROMs, choose between: MacOS, LinuxPPC, MkL (little
> > bit of work on their end?), possibly BeOS, *BSD, and and OSX.  On New
> > World, most of that is possible (some problem OF booting LPPC right now,
> > and No MacOS (w/o lots of work).)  All that's really missing from it right
> > now is some graphical part I think.  There's a routine to draw the OSX
> > logo tho. :)
> 
> Umm, any news about Platinum drivers?  Otherwise, a revised loader still
> wouldn't be very useful on 7200 class machines.

There were many of patches in there.  I wasn't aware the 7200 OF was
broken.  The source is the boot part of darwin, in SecondaryLoader, iirc.
Go check it out. :)

--
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
