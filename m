Message-ID: <3A563AB8.75D49D9A@iiic.ethz.ch>
Date: Fri, 05 Jan 2001 22:20:56 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problems when recompiling dmasound modules
References: <20010105170002.57A401BFD9@atlas.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> > If make dep is always needed after make oldconfig that may be the problem
> > as I also rely on make oldconfig telling me if I have to do that. (real
> > men, you know ;)
>
> I'd assumed it was necessary... I can't recall ever seeing the Makefile
> finish an oldconfig without saying "now do a make dep"...

Me neither probably... This was it. Thanks guys for bringing me on the right
track.


Michel, happily running 2.4.0 from bk


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
