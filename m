Message-ID: <39082033.38C75676@student.ethz.ch>
Date: Thu, 27 Apr 2000 13:10:43 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004261945.MAA03263@pop3.ucdavis.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"W. Taylor Holliday" wrote:

> > The only solutions for now (beyond fixing the code) is to use
> > the unaccelerated fbdev driver for /dev/fb1,
>
> How should I set up the config to do that?

Section "Device"
	Identifier  "FBDev"
	Driver      "fbdev"
	Option      "fbdev" "/dev/fb1"
# This one may improve performance for some systems, try!
#    Option     "ShadowFB"      "off"
# This option increases speed at the expense of RAM. Your choice
#    Option     "BackingStore"
EndSection


And use this device section for the second screen.


Michel


PS: I still think it should work with the r128 driver if it support the
"fbdev" option...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
