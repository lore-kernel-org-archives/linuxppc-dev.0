Message-Id: <200004280051.RAA20647@pop3.ucdavis.edu>
Date: Thu, 27 Apr 2000 17:51:51 -0700
Subject: Re: XFree 4.0 dual monitor on AGP G4
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Michel D?nzer" <daenzerm@student.ethz.ch>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-7"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>  Yes it would work, there is a problem with the approach taken by
> fbdev/glint, the BusID info isn't used at all there for the choise
> of the device to be opened, without the fbdev option you always
> get /dev/fb0 which might not be what you want.

According to the XFree 4 documentation, the BusID determines the device, and
thus the framebuffer used, even in the case of fbdev. So I'm kinda confused.

> Here is a small patch (untested) that changes r128 to use the "fbdev"
> option instead of using BusID to get the fbdev device.
> If the BusID and fbdev options don't match bad things will happen
> so be carefull there.
> For people that don't have more than one r128 card the previous behaviour
> works better so don't use it...
>
>   Kostas
>

If I apply your patch and recompile, how should I modify the config file?
Get rid of all BusID's? Just for the second monitor?

- Taylor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
