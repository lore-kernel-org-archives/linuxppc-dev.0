Date: Thu, 14 Jan 1999 15:46:51 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Renaud Dreyer <rdreyer@math.berkeley.edu>
cc: satadru pramanik <satadru@umich.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Accelerated XF68 on PowerMac 7300? 
In-Reply-To: <199901142035.MAA03142@fhloston>
Message-ID: <Pine.LNX.4.05.9901141546030.15415-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Jan 1999, Renaud Dreyer wrote:

> > On Thu, 14 Jan 1999, satadru pramanik wrote:
> > 
> > > Ditto for a 7600/132!
> > 
> > The main problem with accel'ed X for any of the internal videos is docs on
> > howto accel it... :)
> 
> So then can I assume that the acceleration will not work on my 7300, no matter
> what?

The internal video won't be.

> I was thinking of eventually a graphic card for my 7300, with some kind
> of 3D support. Which one would support acceleration? Thanks,

Right now there's an accel'ed X for ati cards and IMS cards.  Drop one of
those in, run X on that and it'll be acclerated.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
