Date: Wed, 14 Nov 2001 14:04:46 -0500 (EST)
From: Daniel Berlin <dan@cgsoftware.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: DFP support for kernel radeonfb.c added
In-Reply-To: <20011114182613.TIGV16532.tomts17-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.33.0111141402190.22060-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Nov 2001, Kevin B. Hendricks wrote:

>
> Hi Daniel,
>
> On November 14, 2001 01:20, Daniel Berlin wrote:
> > Just a note, on the tibook rev b, the EDID is in EDID1 for the LCD.
> > No idea if it'll make an EDID2/EDID if you plug in an external monitor.
>
> Arrgghh!  Okay, I guess knowing the name of the OF EDID block is not going
> to be easy!
>
> My tree has both "DFP,EDID", and "LCD,DFP" so my code only looks for:
>
> DFP,EDID
> LCD,EDID
> and
> EDID
>
> I will add "EDID1" also (and "EDID2") just to make sure nothing breaks
> along the way.
>
> Ben is correct here, perhaps we should do our own I2C to grab our own EDID
> block directly from the monitor and not play the "what name did OF give
> it" game.
The problem is that i can't seem to get this to work on the tibook2.
Strangely, osx appears to do it.

I'll bet it's bios rom related or something.
> I have not looked at the I2C code to see how complex it is.  Does anyone
> have any working code or sample code I can look at?
Yes, I do.

At least, i have code that *should* work. I can't test it, of course.

Want it?
>
> Thanks,
>
> Kevin
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
