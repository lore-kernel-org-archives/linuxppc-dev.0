Message-Id: <200010291647.RAA01482@piglet.grunz.lu>
Date: Sun, 29 Oct 2000 17:47:10 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Keyboard trouble with XF 4.0.1
To: costabel@wanadoo.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39F33A92.751C5F@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  22 Oct, this message from Martin Costabel echoed through cyberspace:
> I can tell you what is working for me. I have been using Franz's XF4
> RPMs for quite a while without major problems (some minor ones still
> persist, but since the RPMs are 3 months old, I won't repeat them here).
> I am not using, however, the "linux" keycodes. Only the ADB codes.

I went back now to ADB kezcodes as well, since MOL doesn't seem to work
with Linux keycodes.

> I am using the same keymaps as I have for years with the "old" input
> layer.

And which ones are those? Where did you get them from?

> The only problem are those 2 swapped keys "@#" vs "<>".

For the record, with ADB keycodes, all keys are OK in MOL _except_ those
two swapped keys. I wonder whether swapping them is such a good idea...

> In keycodes/macintosh, besides the usual definition of keycode 18, the
                                                         ^^^^^^^^^^
Which one is this?

> Otherwise, in keymap/macintosh:
>
> -    xkb_symbols                { include "macintosh/us(extended)" };
> +    xkb_symbols                { include "macintosh/fr" };

I have no macintosh/fr file. Where did you get yours from?

> In XF86Config, I have
>
> #    Option "XkbDisable"
>     Option "XkbRules"   "xfree86"
>     Option "XkbModel"   "macintosh_old"
>     Option "XkbLayout"  "fr"
>     Option "XkbCompat"  ""

I still don't see how those Xkb options relate to anything in the files
below /usr/lib/X11/xkb. Anybody can explain this?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
