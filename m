Date: Mon, 7 Dec 1998 16:42:43 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Martin Costabel <costabel@lie.univ-rennes1.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5&miscs
In-Reply-To: <199812071057.KAA07174@lie.univ-rennes1.fr.maths>
Message-ID: <Pine.LNX.4.05.9812071636130.1031-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Martin Costabel wrote:

> Tom Rini <tmrini@ntplx.net> wrote on Sun, 6 Dec 1998:
> 
> > On Sun, 6 Dec 1998, Martin Costabel wrote:
> 
> >> If I use XPmac, then it works in principle, but the colors are all
> >> messed up, most of the time nothing is readable. I say 'most of the
> >> time', because the weird colors are not always the same, they depend on
> >> the number of the console from which X is started. Also, if you touch
> >> the title bar of a window, the X server dies. This has been mentioned
> >> here, and it seems that someone already has a fix.
> >
> > I believe this is similar to the problem of using Xpmac compat mode
> > normally, isn't it?
> 
> If by 'normally', you mean linuxppc R4, then no, this is not similar. For me,
> Xpmac on R4 works perfectly (I helped writing the valkyriefb driver, after all,
> to make sure that this is so). On pre-R5 *with the same kernel* and the same
> boot procedure, the colors are crazy. 
> And they depend not only on the number of the console from which X
> is started, but also on the time of the day or whatever. Almost every time I
> startx, I get different colors. The windows that should be black on pale yellow
> in my config, for example, are sometimes yellow on green, sometimes dark blue onvery dark blue, sometimes green on black and so on. You get the picture.

Hmmm.  What XFree86 rpm is up there?  I've only got 3.3.2.23-22 installed
right now, but I'm also grabbing 3.3.3-10b.  Could you try 10b (Xpmac and
FBDev) when they show up?

> I tried to run the Xpmac from R4, fixed by fix961212, but it dies saying it 
> cannot define the default font path and doesn't find the font 'fixed'. But
> this is exactly the same font path that Xpmac from pre-R5 finds without
> problems. Weird. 

Nope, expected.  There's some oddity with X servers and X11R6<->XFree86 it
seems.  I -think-.  Might just be problems trying to read the fonts of
course..

> >> If I use XF68_FBDev, then the colors are OK, but the keyboard and the
> >> mouse do not work correctly: The option (alt) keys do not work, and
> >> there is no simulation for mouse buttons 2 and 3.
> >> This is a problem that has been mentioned to the author (Geert U.)
> >> already some time ago, but since he doesn't have ADB devices any more,
> >> it is not clear whether this will be fixed soon.
> >>
> >> So for people with standard Apple keyboards and mice, there remains a
> >> serious problem.
> >
> > Hmm.  Haven't used the XF68_FBDev's that i've built for a while, but they
> > did work fine here.  Right now I'm using Geert's server from 10something
> > run throught fix961212.  Make sure you have Xkb stuff turned off in the
> > XF86Config file.
>  
> The 2 servers from Geert's that I tried didn't want to run on pre-R5. I don't 
> quite know why, because they dump 2 pages of messages on the screen, only the
> second of which is visible. This is a help file. I guess the real errors are
> mentioned on the first, invisible, page. Not very helpful.

Hmm.  Possibly a problem running it on valkfb?  Geert?

> This problem with the non-functioning option keys seems to be the same in
> R4 and pre-R5. And I am pretty sure that the problem is relatively recent.
> I think it was not there at a time when kernel versions were around 
> 2.1.115-121 or so. I don't know how to test this.

Well, I'm outta ideas here.   I've compiled a few FBDevs and they've
worked fine under pre-R5.   I'm using 2.1.131 from kernel.org right now,
but have had no problem with 2.1.121 or greater or so from vger.  Does
anyone else see this problem?

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
