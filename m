Date: Mon, 31 Jul 2000 19:38:26 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Martin Costabel <costabel@wanadoo.fr>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <4.3.2.7.2.20000731184833.00ce9900@mail.lauterbach.com>
Message-ID: <Pine.LNX.4.10.10007311926140.10200-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> At 18:40 31.07.00, Michael Schmitz wrote:
> > > I am fighting with the "new input layer" right now, although I don't
> > > quite understand why this thing is being inflicted upon innocent ADB
> > > users.
> >
> >My question exactly.
>
> But we are talking about developer trees (2.4 and benh) right now, or? I
> have no problem breaking things here for some time, as long as a working
> version ends up in the stable trees.

I have no problem with you breaking things in the developer trees either,
but I was talking about 2.2.17 which also appears to have the new input
stuff, and that's what bothers me. I already know I have to make a number
of changes to my system with 2.4 (devfs will probably be the first
stumbling block) but didn't expect major breakage with 2.2 kernels.

> >ADB keyboard and mouse work (and button emulation works as well) with
> >CONFIG_NEW_INPUT_LAYER not set. What doesn't work for me anymore is the
> >USB mouse. The 2.2.17 kernel (rsynced last Thursday) only compiled after I
> >added a #ifdef CONFIG_MOUSEDEV somewhere in mac_keyb.c as a consequence of
> >not having CONFIG_NEW_INPUT_LAYER defined. I'd look it up on the Lombard
> >but the box just crashed on me the second time in a row today. 2.2.17 sure
> >is exciting.
>
> I'll try myself without CONFIG_NEW_INPUT_LAYER set later. But I wonder why
> your USB mouse would no longer work. It certainly works for me in console
> and XF4. X or console? Xpmac (which rev?) or XFree? Did you link
> /dev/usbmouse to /dev/input/mice?

Neither gpm nor XFree (never used Xpmac) have the USB mouse working. I've
used /dev/input/mice, /dev/hidbp-mse-0, and the miscdev USB mouse device,
with various combinations of config options in the USB sections, to no
avail.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
