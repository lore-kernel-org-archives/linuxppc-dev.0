From: Benjamin Herrenschmidt <bh40@calva.net>
To: <cl.en@gmx.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: AirPort?
Date: Sat, 1 Jul 2000 11:30:54 +0200
Message-Id: <20000701093054.26086@192.168.1.10>
In-Reply-To: <20000630172404.C4526@olis.north.de>
References: <20000630172404.C4526@olis.north.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 30, 2000, Claus <cl.en@gmx.net> wrote:

> >: with iBooks/G4's? Because, see, I have one of each of those, and it'd be
> >: nice to be able to use the wireless networking under Linux, not just
MacOS
> >: X and MacOS 9. I know there is a driver for the PCMCIA WaveLan card that
> >: the AirPort is based on....
>
><http://www.roelle.com/wvlanPPC/index.html>

Unfortunately, this will probably not work out of the box.

The wvlan_cs driver expects a PCMCIA card (and uses the PCMCIA card
services to detect and get the card's config) but the Apple Airport card
is not really one, it's plugged on an Apple custom IO bus which is not
handled by the pcmcia tools at all.

There is also need to tweak some undocumented IO bits here or there to
get it working.

I'm working on a port of the wvlan_cs driver to the Airport card, I'll
post more news when it's done.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
