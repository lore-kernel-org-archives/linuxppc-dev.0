Message-ID: <39FD42BF.3623CD9D@noos.fr>
Date: Mon, 30 Oct 2000 10:43:27 +0100
From: Guillaume Laures <guillaume.laures@noos.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keyboard trouble with XF 4.0.1
References: <200010292159.WAA02769@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> Hi Guillaume,
>
> On  29 Oct, this message from Guillaume Laures echoed through cyberspace:
> >  - fr-mac.kmap.gz: a map to use at console (place in
> > /usr/lib/kbd/keymaps/mac/ and run kbdconfig)
>
> I'll have a look, but as long as I stay in ADB keycodes, my console
> works ok. I have yet to check why this is so ;-)

Installed initscripts-5.35-1a ?
It will switch you to linux keycodes in conole, I guess by sending a 1 in the
appropriate location in /proc

> > Basically both are last Marc Shapiros's production, with various enhancements
> > (not much...) and with keycodes # completely redesigned regarding the new
> > input layer.
> > Note: you'd _rather_ use linux keycodes if you setup this...
>
> Any solution for MOL? It doesn't work for me with Linux keycodes...

I didn't used mol for a while, have enough to do in the linux side...

>
> That's the way I'm going as well: just reverse engineer the stuff.
> Change somthing and see what happens ;-) So far I've successfully made X
> load some XKB stuff, but the result is totally messed up keys. Maybe
> some old xmodmap setting is getting in my way...

XKBModel = macintosh_old may be useful to you...

>
>
> > And an advice: if you plan to move from XFree 4.0 to 4.0.1, have a clean
> > linuxppc install not far (other partition) to recover things once your
> > keyboard is completely screwed...
>
> Hehehehe.... For this sort of thing, I always first make backups of
> config files (my xdm directory has been deleted only once by an RPM
> install...), then I keep the old RPMs handy, and then I have a second
> machine to telnet into the DUU (Device Under Upgrade ;-).

I made regularly a complete .tbz of all my stuff, since upgrading a rpm may be
easy & messy, but downgrading is really a pain.


--
GoM


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
