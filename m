Message-ID: <399EA4CD.E9BB206D@wanadoo.fr>
Date: Sat, 19 Aug 2000 17:16:29 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4 hangs on 2.4 kernel (was: Re: Control fb problem on 8500)
References: <200008191415.QAA00716@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> On  19 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
> >>My XFree 4.0 goes into an infinite loop eating CPU time when I boot a
> >>2.4.0 kernel. Xpmac does work, but with the artifact described in my
> >>previous mail.
> >
> > I have this exact same problem with XF4 on my Pismo (r128) with any 2.4.
> > The X server dies in this infinite loop and a black screen. Theo only way
> > I found to get the screen back is to telnet into the box, kill -9 the X
> > server, and launch Xpmac. This seems to restore the console system into a
> > working state.
>
> Ahh, so that problem is not control-specific.

Just for the record: I have no such problem on my 6400 with valkyriefb
and Franz's XF4.0.1 RPMs.

> > I don't know what's up yet.
>
> Are you using the new input layer from bk? I'm not; I use Paul's devel
> tree, which doesn't include that part yet.

I am using both Paul's devel tree and the bk tree with the new input
layer (like right now). I usually use 8 bit color, sometimes 15 bit. I
had no luck with 16 bit, and more is not supported by my video card.

BTW, what's the story with the new input layer. It looks like
drivers/input has disappeared from Ben's tree?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
