Message-ID: <3A08BE08.6CD64925@denise.shiny.it>
Date: Tue, 07 Nov 2000 21:44:24 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Giuliano Pochini <pochini@shiny.it>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lots of problems
References: <XFMail.001103111328.pochini@shiny.it> <19340928070822.11693@192.168.1.2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >- all: G4 internal modem doesn't work. Suggestions ? I absolutely need it !!
>
> That's something I've not checked. Paul fixed some internal modem issues
> in macserial.c recently, I beleive those fixes are in the bk and rsync trees.

With bk 2.2 tree it doesn't work. By doing echo lhkljjhkl > /dev/ttyS0 SCC
interrupts
counters change, so it's not completely dead.... but, again, the G4 is not
mine, it's
the my friend's new computer after his Amiga1200. You can imagine how
difficult
is to explain things to him by phone :-)

> >- 2.4.0*: G4 ethernet goes at 100Mbps even if it's connected to a 10Mbps
> >hub. Is
> >there a way to force it to a lower speed ? Can the G3 eth go at 100MBps ?
>
> You need the latest gmac driver which is, again, in the trees mentioned above.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
