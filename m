Message-ID: <20000825205230.8489.qmail@www0c.netaddress.usa.net>
Date: 25 Aug 00 15:52:30 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: Stefan Berndtsson <stefan@nocrew.org>, sprenger <sprenger@in.tum.de>
Subject: Re:  xf4 and lombard
CC: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> May I just ask.. how the heck did you get xf4 running on lombard? :)
>
> All I manage to get is a black screen and I can't do anything anymore.
> The machine is still running, so I can reboot it via network.
>
> It's a lombard/333 running 2.4.0-test6.
>
> xf4 is compiled from sources found on a link from the instructions
> at linuxppc.org and the rsynced version of the ati-driver, as of
> about 17.00 CET 2000-08-25.
>

I have it working. Here is my configuration.
1. Ben's latest precompiled kernel
2. franz's x rpms (from devel.linuxppc.org)
3. The ati moduled compiled from the linuxppc.org tree
4. I took the config file for the pismo at http://linuxppc.org/files/pub/xf4
and edited it for ati instead of r128.
5. I made sure my /etc/X11/X pointed to /usr/X11R6/bin/XFree86 and ran
startx.

voila mes amis!


-jeramy b smith


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
