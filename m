Message-Id: <200010292159.WAA02769@piglet.grunz.lu>
Date: Sun, 29 Oct 2000 22:59:00 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Keyboard trouble with XF 4.0.1
To: guillaume.laures@noos.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39FC9932.6041E947@noos.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Guillaume,

On  29 Oct, this message from Guillaume Laures echoed through cyberspace:
>  - fr-mac.kmap.gz: a map to use at console (place in
> /usr/lib/kbd/keymaps/mac/ and run kbdconfig)

I'll have a look, but as long as I stay in ADB keycodes, my console
works ok. I have yet to check why this is so ;-)

>  - xf86_nil_fr.diff.gz: a diff to stuff I modified in the xkb directory. (do
> not try to apply it, but inspect it and see what should be included in the
> distribution, test it)

I'll have a look, thanks.

> Basically both are last Marc Shapiros's production, with various enhancements
> (not much...) and with keycodes # completely redesigned regarding the new
> input layer.
> Note: you'd _rather_ use linux keycodes if you setup this...

Any solution for MOL? It doesn't work for me with Linux keycodes...

>> I still don't see how those Xkb options relate to anything in the files
>> below /usr/lib/X11/xkb. Anybody can explain this?
>
> I've yet to find some doc about it, but starting to play with rules/xfree86
> made me learn what you can see in xf86_nil_fr.

That's the way I'm going as well: just reverse engineer the stuff.
Change somthing and see what happens ;-) So far I've successfully made X
load some XKB stuff, but the result is totally messed up keys. Maybe
some old xmodmap setting is getting in my way...

> And an advice: if you plan to move from XFree 4.0 to 4.0.1, have a clean
> linuxppc install not far (other partition) to recover things once your
> keyboard is completely screwed...

Hehehehe.... For this sort of thing, I always first make backups of
config files (my xdm directory has been deleted only once by an RPM
install...), then I keep the old RPMs handy, and then I have a second
machine to telnet into the DUU (Device Under Upgrade ;-).

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
