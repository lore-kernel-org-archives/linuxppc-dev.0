Message-ID: <39C4C5C4.6186D08A@student.ethz.ch>
Date: Sun, 17 Sep 2000 15:23:16 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Thomas Graichen <graichen@innominate.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 4.0 auf imac dv
References: <news2mail-8psnl8$1gb$5@mate.bln.innominate.de> <news2mail-8pvund$d4i$1@mate.bln.innominate.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Graichen schrieb:
>
> Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de> wrote:
>
> > does anyone here have XFree86 4 running suscessfully on a imac dv (or
> > blueberry which should be basically the same)? - i ask because i tried
> > the DRI test server from michael daenzer and get problems with the
> > screen: it shows only the left half and also shows this half again
> > on the right side - the mousecursor is moving fine over the full
> > screen btw.
>
> > some more details about the setup: latest paulus kernel, XF86Config
> > standard for a r128 card (the card is an 8mb r128 rl) - if you need
> > any more information please let me know ...
>
> > so has anyone else seen this too or has it working on a similar
> > machine ... i just wanted to know this before i start looking
> > deeper
>
> ok - it works with an own built tree of XFree86 4.0.1 plus the
> ppc additions mentioned at linuxppc.org
>
> question: is all the r128 ppc dri stuff in that tree (rsync
> penguinppc.org::xfree86-pmac) too or are there any extra patches
> required to get it working?

No, the DRI stuff isn't in there yet. However, someone here (sorry I don't
remember the name) has merged DRI and xfree86-pmac 2D driver code, using
r128_drv.o from that with my DRI binaries should work for you.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
