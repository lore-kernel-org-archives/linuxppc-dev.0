Date: Wed, 9 Dec 1998 13:06:43 -0600 (CST)
From: Takashi Oe <toe@unlinfo.unl.edu>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev and option keys (was Re: XF68_FBDev under MkLinux? and Re:  pre-R5&miscs)
In-Reply-To: <366E47E0.24DD93F4@wanadoo.fr>
Message-ID: <Pine.LNX.3.96LJ1.1b7.981209125522.374A-100000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Wed, 9 Dec 1998, Martin Costabel wrote:

> There was, in fact, an error message that I neglected. It came from the
> line
>     xkb_symbols     { include "symbols/macintosh"  };
> in /usr/X11/lib/X11/xkb/keymap/macintosh.
> I did not know that this had to be changed. 
> 
> I think this is a bug, it should be "symbols/macintosh/us" in the
> standard distribution, and it is now "symbols/macintosh/fr" for me, and
> this makes my French keyboard work in XF68_FBDev just as it had been
> working in XPmac all the time. 

I wouldn't say it's a bug because Xpmac had no problem and your original
installation was specifically talored to the likes of Xpmac in a way.
But, anyway, I'm glad to know you can finally use the option key.

> My two other problems persist: No mouse buttons 2&3 in XF68_FBDev (and
> no, adb_buttons=1 in the boot command line is no solution!), neither in

Ok, in console (not in X), try "showkey".  This will show you the keycode
and such for the console mode.  Pick a key or two that you like to use to
emulate the middle and right buttons and find their keycodes in console.
With that, use the option.  For example, if you want to keycode 113 for
the middle button and keycode 115 for the right button, then
	adb_buttons=113,115
should do.  This is according to the kernel source that I got a few days
ago but I think there was a mention of this option's usage sometime ago in
linux-pmac list.

> R4 nor in pre-R5; and mixed-up color palette in XPmac in pre-R5. The
> latter problem would, of course, lose its importance if the former were
> solved.

I have no clue about the palette problem.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
