Mime-Version: 1.0
Message-Id: <v04220800b4f3a7681988@[10.0.0.42]>
In-Reply-To: <8x8zzmvi3j.fsf@s63.informatik.uni-bremen.de>
References: <8x8zzmvi3j.fsf@s63.informatik.uni-bremen.de>
Date: Tue, 14 Mar 2000 00:35:49 -0800
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
        linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Does a Cinema Display work with Linux?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:29 PM +0100 3/13/00, Holger Bettag wrote:
>Hi people,
>
>I have this crazy idea of wasting all my savings on a G4 PowerMac with a
>Cinema Display. Can I hope for this setup to work under Linux (or rather X11)?
>
>I suspect that Macs bundled with a Cinema Display possibly come with a
>different graphics card (than other G4 Macs),

Apple is only shipping one type of card right now, regardless of
display.  It's a Rage 128 Pro AGP board with both a VGA connector and
a digital flat panel connector on the back.

>  or that at least the graphics
>hardware has to be programmed completely differently.

It probably does need to have some different programming, yes.

>Can anybody give me a hint as to what I can expect? (I don't think I'd be
>qualified to extend Linux or XFree with support for this LCD, so I won't
>just buy it and worry later.)

You can probably at least assume that you'll be able to use it
unaccelerated at its native resolution via offb.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
