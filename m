Message-Id: <200002061619.BAA04129@mail.cc.tohoku.ac.jp>
MIME-Version: 1.0
Date: Mon, 07 Feb 2000 01:19:45 +0900
From: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: Your message of "Sun, 06 Feb 2000 15:15:32 +0100"
 	<389D8204.C51655F8@wanadoo.fr>
References: <389D8204.C51655F8@wanadoo.fr>
Subject: Re: Error report : make clgenfb on 2.2.14
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Return for :
From: Martin Costabel <costabel@wanadoo.fr>
on " Re: Error report : make clgenfb on 2.2.14 "
date: Sun, 06 Feb 2000 15:15:32 +0100 >>>

> Kazunori Aoshima wrote:
> >
> > Hi there,
> >
> > Error occured on last stage of kernel make.
> > Like this :
> >
> > drivers/char/char.a(vt.o): In function `vt_ioctl':
>
> > Environment:
> >         kernel-2.2.14
> > with
> >         clgenfb 1.9.4.4
> >         drivers/video/vga.h (from 2.3.40)
>
> Looks like you use CONFIG_FB_COMPAT_XPMAC=y and CONFIG_FB_OF off.
> Since these references are defined in drivers/video/offb.c,
> you will have to switch CONFIG_FB_OF on.

Thank you, Martin.

I set them on .config file.

CONFIG_FB_COMPAT_XPMAC=y
CONFIG_FB_OF=y
CONFIG_FB_CLGEN=y

After the configuration, compile through with no error.
Thank you very much.

But I set new kernel, kernel can not detect
framebuffer devices.  Why?

I should cut off VGA console option?
Or, I sould set some spetial options on it?
I do not clearly understand the options for "clgenfb".

"video=clgen" It is right? or wrong?

Best regards.
----------------------
Kaz Aoshima = Editor of the PReP station
Material deveropment, Faculty of engineering,
Tohoku University, Japan
E-mail:aoshimak@mail.cc.tohoku.ac.jp
#I would appreciate if you could give me suggestions
 for my impolite English expressions.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
