Date: Thu, 14 Jan 1999 19:48:13 -0600 (CST)
From: nathan ingersoll <ningerso@d.umn.edu>
To: Tom Rini <tmrini@ntplx.net>
cc: Renaud Dreyer <rdreyer@math.berkeley.edu>,
        satadru pramanik <satadru@umich.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Accelerated XF68 on PowerMac 7300? 
In-Reply-To: <Pine.LNX.4.05.9901141546030.15415-100000@pc.wackyland.com>
Message-ID: <Pine.SO4.4.02.9901141942490.29040-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've had quite a bit of problems with acceleration with my ATI Rage II.
When color is set for 8 bpp the screen is all white with a cursor, 16 bpp
seems to work, but there are window remnants left behind when dragging or
from menus. I only have 2 MB of SGRAM so I haven't tried higher
resolutions, if it would help fix the problem, I could experiment a bit
more. Non-accelerated, the X server works great. So I've pretty much
settled on what I have.

On Thu, 14 Jan 1999, Tom Rini wrote:

> 
> On Thu, 14 Jan 1999, Renaud Dreyer wrote:
> 
> > > On Thu, 14 Jan 1999, satadru pramanik wrote:
> > > 
> > > > Ditto for a 7600/132!
> > > 
> > > The main problem with accel'ed X for any of the internal videos is docs on
> > > howto accel it... :)
> > 
> > So then can I assume that the acceleration will not work on my 7300, no matter
> > what?
> 
> The internal video won't be.
> 
> > I was thinking of eventually a graphic card for my 7300, with some kind
> > of 3D support. Which one would support acceleration? Thanks,
> 
> Right now there's an accel'ed X for ati cards and IMS cards.  Drop one of
> those in, run X on that and it'll be acclerated.
> 
> ---
> Tom Rini (TR1265)
> http://dobbstown.yeti.edu/
> 
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
