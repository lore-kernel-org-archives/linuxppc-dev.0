Message-ID: <20000315112234.24452.qmail@web107.yahoomail.com>
Date: Wed, 15 Mar 2000 03:22:34 -0800 (PST)
From: Michel Danzer <mdaenzer@yahoo.com>
Reply-To: michdaen@iiic.ethz.ch
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Alan Hourihane <alanh@fairlite.demon.co.uk>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> wrote:

> > > I'll get back to poking around in there as soon as I can figure out how
> > > to see the kernel messages (i.e. how to switch back to the text console
> > > fast enough, or never let the X server switch to VT 7 in the first
> > > place).
> >
> > A remote machine might be handy...
>
> That's what I'm using already. But the kernel messages that otherwise
> appear on the text screen won't get redirected to a remote machine.
> Nothing ever ends up in the syslog, anyway. I guess the klogd/syslogd
> combo is too slow in this case.

Can't you use kgdb?


> > BTW I've just discovered that the fbdev driver sets the weight explicitly
> > to {0,0,0}... now I'm (really ;) confused.
>
> So was I.

Wonder what the intention and effect(s) are. Alan?


> > > I guess it all boils down to PCI messups.
> >
> > How do you come to this conclusion? Why should it influence ioctls?
>
> Because these ioctls will, ultimately, write to the card again? If the X
> server actually messes with the PCI bridges, the card might no longer be
> mapped?

Can the X server mess with atyfb's mappings?


> I admit that I understand next to nothing about PCI, or how the X server
> uses PCI. Makes it a bit harder to spot the flaky code :-)

Same goes for me :-/


> Anyway, the X server appears to complete screen init OK but I never
> actually get to see the cross hatch pattern.

Not very astonishing without the FBIOPUTSCREEN ioctl, is it?

What _do_ you see if anything?


Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
