Date: Wed, 14 Nov 2001 15:19:07 -0500 (EST)
From: Daniel Berlin <dan@cgsoftware.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: DFP support for kernel radeonfb.c added
In-Reply-To: <20011114201244.CRPO11133.tomts9-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.33.0111141518370.25545-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Nov 2001, Kevin B. Hendricks wrote:

> Hi Daniel,
>
> > > My tree has both "DFP,EDID", and "LCD,DFP" so my code only looks for:
> > >
> > > DFP,EDID
> > > LCD,EDID
> > > and
> > > EDID
> > >
> > > I will add "EDID1" also (and "EDID2") just to make sure nothing breaks
> > > along the way.
> > >
> > > Ben is correct here, perhaps we should do our own I2C to grab our own
> > > EDID block directly from the monitor and not play the "what name did
> > > OF give it" game.
> >
> > The problem is that i can't seem to get this to work on the tibook2.
> > Strangely, osx appears to do it.
>
> What doesn't work... is it my radeonfb.c version that doesn't work for you
No, I mean using i2c to grab it.
> > > I have not looked at the I2C code to see how complex it is.  Does
> > > anyone have any working code or sample code I can look at?
> >
> > Yes, I do.
> >
> > At least, i have code that *should* work. I can't test it, of course.
> >
> > Want it?
>
> Sure....please send it along.
Give me a few minutes.

>
> Thanks,
>
> Kevin
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
