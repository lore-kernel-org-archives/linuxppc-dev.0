Message-ID: <20000315094454.921.qmail@web106.yahoomail.com>
Date: Wed, 15 Mar 2000 01:44:54 -0800 (PST)
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

> > > Possibly; I've also seen the X server convert XFree mode lines into
> > > fbdev timings, thereby overwriting the 565 with 000. Doesn't hurt for
16
> > > bits, only for 32 bits.
> >
> > Doesn't hurt for probing, but maybe for the ioctl?
>
> The ioctl has been disabled long time ago.

I meant when you hadn't disabled it. It hung there at the time, right? Now a
hang in an ioctl is a kernel bug, or am I missing something?


> I'll get back to poking around in there as soon as I can figure out how to
> see the kernel messages (i.e. how to switch back to the text console fast
> enough, or never let the X server switch to VT 7 in the first place).

A remote machine might be handy...


> Now I can't get beyond xf86HandleColormaps(). Another ioctl that barfs on
> me, perhaps.

Well possible, FBIOPUTCMAP in fbdevHWLoadPalette.

I don't understand the code there...

BTW I've just discovered that the fbdev driver sets the weight explicitly to
{0,0,0}... now I'm (really ;) confused.


> I guess it all boils down to PCI messups.

How do you come to this conclusion? Why should it influence ioctls?


Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
