Date: Mon, 31 Jul 2000 23:43:29 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Martin Costabel <costabel@wanadoo.fr>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <00073123123600.00771@enzo.bigblue.local>
Message-ID: <Pine.LNX.4.10.10007312320320.14968-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > - USB mouse works as before both in X and for gpm when I link
> > /dev/usbmouse to /dev/input/mouse2. OK so far.
>
> Why not link it to /dev/input/mice? That's what's intended. Actually link
> /dev/mouse to /dev/input/mice and use /dev/mouse everywhere.

Because that breaks the X config for 2.2.15? (2.2.17 has a few other
shortcomings so I don't plan to use it permanently right now.) I'll sure
try using only /dev/input/mice later, just to see if the buttons 4 and 5
for the mouse wheel still work that way.

> > conditionals. Even the old way of mouse button emulation via /dev/adbmouse
> > still works, so why the #ifndef CONFIG_INPUT_MOUSEDEV to remove a fully
> > functional feature that doesn't even interfere with the new input layer
> > for all I can see?
>
> Well, that wasn't the goal here, I wanted a single gpm and X config for all
> mice, and I wanted as much old cruft removed as possible for the
> CONFIG_NEW_INPUT_LAYER case, it has been there for far too long. And who,
> except developers, want's to use old 2.2 kernels if the new kernel works?

Who wants to use new 2.2 kernels if they do things like freeze for no
apparent reason, or wake up from sleep with the display remaining off? I
can't remember a crash with 2.2.15, while 2.2.17 doesn't seem as stable.
At least while I work on fixing 2.2.17 related problems I'd like to fall
back on 2.2.15 for real work.

Removing old cruft is all fine and dandy - for 2.4, IMHO. Please note that
I've not said the new input layer shouldn't be introduced in 2.2, just
that things working before shouldn't break (like adbmouse with the input
layer, or USB without). But perhaps I've just been lucky with previous
2.2.x experimental versions that didn't break.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
