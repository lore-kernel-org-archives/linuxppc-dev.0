Message-ID: <3ADB35C9.9113AC3A@denise.shiny.it>
Date: Mon, 16 Apr 2001 20:11:21 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot params
References: <20010416115854.9A1722F09A@apollo.valhalla.net> <20010416040553.J2127@plato.local.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > which is why something as important as the
> > > kernels should not live on HFS.
> >
> > OW machines don't have the choice.
>
> yes they do, its called quik.

Not a good choice. Often it happens you can't type anything in the
OF boot menu script, so you can't choose what OS start up (or at
least my 7300 with OF v1.0.5 had this problem). It also happens on
a 2nd-half-2000-series G4 where the ofboot script refuse to accept
keyboard input 80% of the times.

> > Yes, but I've not seen a report for months - the last IIRC were for 2.3.xx
> > kernels ...
>
> jeramy was mentioning some reports recently.

No problems here.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
