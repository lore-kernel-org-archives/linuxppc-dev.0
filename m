Message-Id: <200004280042.RAA18722@pop3.ucdavis.edu>
Date: Thu, 27 Apr 2000 17:42:33 -0700
Subject: Re: XFree 4.0 dual monitor on AGP G4
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: "Michel Ddnzer" <daenzerm@student.ethz.ch>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> How should I set up the config to do that?
>
> Section "Device"
>  Identifier  "FBDev"
>  Driver      "fbdev"
>  Option      "fbdev" "/dev/fb1"
> # This one may improve performance for some systems, try!
> #    Option     "ShadowFB"      "off"
> # This option increases speed at the expense of RAM. Your choice
> #    Option     "BackingStore"
> EndSection


Well, that didn't work. Basically the server started running, but nothing
showed up on my second monitor. Suggestions?

- Taylor

p.s. hey but it beats crashing the kernel :-)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
