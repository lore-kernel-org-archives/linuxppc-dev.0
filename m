Message-ID: <39770DCD.B7F1C6FE@ssl.co.uk>
Date: Thu, 20 Jul 2000 15:33:49 +0100
From: Sacha Varma <sacha@ssl.co.uk>
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI compatibility
References: <Pine.LNX.4.10.10007200653360.21977-100000@shell.unixbox.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks to all for the responses.

Ani Joshi wrote:
>
> On Wed, 19 Jul 2000, Sacha Varma wrote:
>
> > It's quite terse but states that PCI cards that need to be active on boot
> > (video cards) will generally not work, and cards that don't generally will.
> >
> > I'm just curious (I was wondering why there was no support for various nifty
> > non-AGP PC graphics cards, and also why the PC USB card I installed yesterday
> > works fine under MacOS) but
>
> Video cards do not need to be active 'on boot' (if you mean upon powerup)
> to work in linux.  If there is no OF rom you will ofcourse not see any
> display until Linux initializes the display.

So... does this mean that as far as hardware is concerned there is nothing to prevent me from using any old PCI graphics card in a (non-AGP?) mac so long as linux has drivers for it?

Where in the kernel source is the bit where it initialises the display (is this a per-host-architecture thing, per-video-chipset thing, or a generic PCI thing)?


> If you have problems with
> devices not 'talking' then try enabling IO and MEM access, as they were
> probably not turned on.

As I say, I'm just curious, I'm not having any problems, nor (clearly) do I know much about PCI! But where would one enable these?


--
sacha varma : system simulation ltd : +44 (0) 20 7836 7406

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
