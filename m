Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Daniel Berlin <dan@cgsoftware.com>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Wed, 14 Nov 2001 15:15:26 -0500
References: <Pine.LNX.4.33.0111141402190.22060-100000@www.cgsoftware.com>
In-Reply-To: <Pine.LNX.4.33.0111141402190.22060-100000@www.cgsoftware.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <20011114201244.CRPO11133.tomts9-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Daniel,

> > My tree has both "DFP,EDID", and "LCD,DFP" so my code only looks for:
> >
> > DFP,EDID
> > LCD,EDID
> > and
> > EDID
> >
> > I will add "EDID1" also (and "EDID2") just to make sure nothing breaks
> > along the way.
> >
> > Ben is correct here, perhaps we should do our own I2C to grab our own
> > EDID block directly from the monitor and not play the "what name did
> > OF give it" game.
>
> The problem is that i can't seem to get this to work on the tibook2.
> Strangely, osx appears to do it.

What doesn't work... is it my radeonfb.c version that doesn't work for you
or is it that  OF storing EDID in the device tree is not working?

> I'll bet it's bios rom related or something.

If you run with my driver it will dump a lot of info to dmesg (printk)
that will tell us what EDID info was parsed, the timings, ... just about
everything I could look at to compare it against how things worked under
Mac OS 9.

> > I have not looked at the I2C code to see how complex it is.  Does
> > anyone have any working code or sample code I can look at?
>
> Yes, I do.
>
> At least, i have code that *should* work. I can't test it, of course.
>
> Want it?

Sure....please send it along.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
