Message-ID: <39FC731C.8EA030BD@wanadoo.fr>
Date: Sun, 29 Oct 2000 19:57:32 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keyboard trouble with XF 4.0.1
References: <200010291647.RAA01482@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> Hi all,
>
> On  22 Oct, this message from Martin Costabel echoed through cyberspace:

> > I am using the same keymaps as I have for years with the "old" input
> > layer.
>
> And which ones are those? Where did you get them from?

It's been so long, I don't remember where I got mine from originally,
but at the following 2 addresses you should find all you need: Etienne
Herlent maintains the FAQ of news://fr.comp.os.unix.mac and some related
material, see
http://perso.easynet.fr/~eherlent/linuxmac.html, and there are infos in
http://www.linux-france.org/article/materiel/mac/
They even have put all necessary changes and files into an RPM.

> > The only problem are those 2 swapped keys "@#" vs "<>".
>
> For the record, with ADB keycodes, all keys are OK in MOL _except_ those
> two swapped keys. I wonder whether swapping them is such a good idea...
>
> > In keycodes/macintosh, besides the usual definition of keycode 18, the
>                                                          ^^^^^^^^^^
> Which one is this?

This is (or used to be) the key to the left of "1", above TAB.

> > Otherwise, in keymap/macintosh:
> >
> > -    xkb_symbols                { include "macintosh/us(extended)" };
> > +    xkb_symbols                { include "macintosh/fr" };
>
> I have no macintosh/fr file. Where did you get yours from?
>
> > In XF86Config, I have
> >
> > #    Option "XkbDisable"
> >     Option "XkbRules"   "xfree86"
> >     Option "XkbModel"   "macintosh_old"
> >     Option "XkbLayout"  "fr"
> >     Option "XkbCompat"  ""
>
> I still don't see how those Xkb options relate to anything in the files
> below /usr/lib/X11/xkb. Anybody can explain this?

I can't explain, I just use it and it works.

Anyway, with the new LinuxPPC distribution that is leaving its egg right
now, we shall all soon be converted to linux keycodes, I guss :-)

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
