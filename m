Date: Sun, 6 Dec 1998 09:08:22 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: laures@hp1.esiea.fr, linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5&miscs
In-Reply-To: <3669CABC.411EC4DE@wanadoo.fr>
Message-ID: <Pine.LNX.4.05.9812060903130.954-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Dec 1998, Martin Costabel wrote:

> "G. Laurès" wrote:
> > 
> > Hi guys, I just discovered the pre-R5 directory @ dev.linuxppc.org.
> > 
> >  It does include the latest version of Bootx, but not ramdisk.image.gz as in
> > previous distributions (R4.1 for example). Note that this is also the case for R4.7.
> 
> What and where is R4.7?

Just another symmlink on dev.linuxppc.org pointing back to
/pub/users/fray/RedHat or there abouts.

> If I use XPmac, then it works in principle, but the colors are all
> messed up, most of the time nothing is readable. I say 'most of the
> time', because the weird colors are not always the same, they depend on
> the number of the console from which X is started. Also, if you touch
> the title bar of a window, the X server dies. This has been mentioned
> here, and it seems that someone already has a fix.

I believe this is similar to the problem of using Xpmac compat mode
normally, isn't it?

> If I use XF68_FBDev, then the colors are OK, but the keyboard and the
> mouse do not work correctly: The option (alt) keys do not work, and
> there is no simulation for mouse buttons 2 and 3.
> This is a problem that has been mentioned to the author (Geert U.)
> already some time ago, but since he doesn't have ADB devices any more,
> it is not clear whether this will be fixed soon.
>
> So for people with standard Apple keyboards and mice, there remains a
> serious problem.

Hmm.  Haven't used the XF68_FBDev's that i've built for a while, but they
did work fine here.  Right now I'm using Geert's server from 10something
run throught fix961212.  Make sure you have Xkb stuff turned off in the
XF86Config file.
 
> On the other hand, here is something positive: The compilers are working
> well with the new glibc. One example: Since I am using dhcp for the
> network connection (like you probably), I fetched the sources for
> dhcpcd-1.3.16 (the dhcpcd-0.70-2.ppc.rpm which comes with the R5beta is
> completely useless for linuxppc 2.1.1xx kernels). In linuxppc R4, the
> compilation used to be somewhat tricky, due to glibc problems. Here it
> works now without any problems; just one line with some CFLAGS in the
> Makefile had to be adapted. And the best thing is: it works! In my R4
> system, since a week or so, I always get timeouts from dhcp, so I had to
> use either an old 2.1.24 kernel or a fixed IP address. Now I can even
> chroot from the R4 system to the R5beta and run dhcpcd there and it
> connects! I suppose this has also something to do with the more recent
> networking packages, net-tools etc.

You can blame RedHat for shipping RawHide with a 2.1.1xx kernel and too
old a dhcpcd :)  Same thing w/ gtk+ there now.  It's real nice to have
more official type tools.  Most of the patches needed to port all this
stuff over was packages being too messily done before for either egcs or
glibc 2.1, and those tend to be minor fixes.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
