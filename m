Message-ID: <39092A73.DD18F3B9@student.ethz.ch>
Date: Fri, 28 Apr 2000 08:06:43 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004280042.RAA18722@pop3.ucdavis.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"W. Taylor Holliday" wrote:
>
> >> How should I set up the config to do that?
> >
> > Section "Device"
> >  Identifier  "FBDev"
> >  Driver      "fbdev"
> >  Option      "fbdev" "/dev/fb1"
> > # This one may improve performance for some systems, try!
> > #    Option     "ShadowFB"      "off"
> > # This option increases speed at the expense of RAM. Your choice
> > #    Option     "BackingStore"
> > EndSection
>
> Well, that didn't work. Basically the server started running, but nothing
> showed up on my second monitor. Suggestions?

Sorry, I forgot to say you still have to give it the bus ID *blush*


> p.s. hey but it beats crashing the kernel :-)

:)


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
