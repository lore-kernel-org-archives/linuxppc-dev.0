Message-Id: <200004261945.MAA03263@pop3.ucdavis.edu>
Date: Wed, 26 Apr 2000 12:45:00 -0700
Subject: Re: XFree 4.0 dual monitor on AGP G4
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, daenzerm@student.ethz.ch
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-7"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Kostas Gewrgiou wrote:
>  Unfortunately i don't think that it will work in this case,
> the second r128 will never be able to pick the right device
> (/dev/fb1 here) the BusID line is more or less ignored in the fbdev
> case so the second driver will open /dev/fb0 which will result
> in a kernel crash.

> The only solutions for now (beyond fixing the code) is to use
> the unaccelerated fbdev driver for /dev/fb1,

How should I set up the config to do that?

> not using fbdev
> in the r128 driver will also work but this will require a couple
> of changes in the r128 driver (info about what changes are needed
> were posted in this list a few months back)

So is there a patch? Or are u just referring to some discussion on the
subject?

btw - I applied all the patches at entropy.crashing.org/~howath before
compiling

thanks
- Taylor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
