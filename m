Message-ID: <366EDCA8.91BB1EFC@wanadoo.fr>
Date: Wed, 09 Dec 1998 21:25:12 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Takashi Oe <toe@unlinfo.unl.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev and option keys (was Re: XF68_FBDev under MkLinux? and
 Re:  pre-R5&miscs)
References: <Pine.LNX.3.96LJ1.1b7.981209125522.374A-100000@selq119.unl.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:
> 
> Hi,
> 
> On Wed, 9 Dec 1998, Martin Costabel wrote:
> 
> > There was, in fact, an error message that I neglected. It came from the
> > line
> >     xkb_symbols     { include "symbols/macintosh"  };
> > in /usr/X11/lib/X11/xkb/keymap/macintosh.
> > I did not know that this had to be changed.
> >
> > I think this is a bug, it should be "symbols/macintosh/us" in the
> > standard distribution, and it is now "symbols/macintosh/fr" for me, and
> > this makes my French keyboard work in XF68_FBDev just as it had been
> > working in XPmac all the time.
> 
> I wouldn't say it's a bug because Xpmac had no problem and your original
> installation was specifically talored to the likes of Xpmac in a way.

No, the specific tailoring consisted in calling Xpmac via
/usr/bin/X11/X -kbdtype "fr(extended)" and creating a file
xkb/symbols/macintosh/fr.

The line I called buggy is found in the XF68_FBDev rpm as well as in the
Xpmac rpm. So it seems to me that it has to be changed in any case in
order to make xkb work in XF68_FBdev. It is probably less important for
US keyboards, because they only use the shift key as modifier, i.e. on
one key you usually only have 2 symbols, whereas I have up to 4, so I
need the option key as modifier. With a US keyboard you can probably get
away with xkb disabled.

I also hope that R5 will include a good documentation for these things,
otherwise in a couple of weeks you will have users crying for help all
over the place.
 
> > My two other problems persist: No mouse buttons 2&3 in XF68_FBDev (and
> > no, adb_buttons=1 in the boot command line is no solution!), neither in
> 
[]
> With that, use the option.  For example, if you want to keycode 113 for
> the middle button and keycode 115 for the right button, then
>         adb_buttons=113,115
> should do.  This is according to the kernel source that I got a few days
> ago but I think there was a mention of this option's usage sometime ago in
> linux-pmac list.

I know about this, but I would hate to have to do this. I would prefer
not to give up two good keys for mouse button emulation. Plus, I prefer
to click my mouse button if I need a mouse click. Why can't the mouse
work in FBDev as in Xpmac? 

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
