Date: Wed, 22 Nov 2000 12:33:17 +0100
From: Michel Dänzer <daenzerm@student.ethz.ch>
Subject: Re: controlfb problem (on XFree86-4.0.1 off the penguinppc.org
 development tree)
To: mlan@cpu.lu
Cc: jens_tingleff@yahoo.com, linuxppc-dev@lists.linuxppc.org,
        ajoshi@unixbox.com
Message-id: <3A1BAEFD.2964C5AA@student.ethz.ch>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <200011212143.WAA00749@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> On  21 Nov, this message from Jens Tingleff echoed through cyberspace:
> >> That problem I fixed for me with a patch you can find here:
> >>
> >> http://www.cpu.lu/~mlan/linux/dev/xf4.html
> >>
> >
> > Actually, I did roll this patch into my modifications. Could it be that
> > the development tree on penguinppc.org doesn't have these patches at
> > the moment?
>
> That could be; I never got any positive feedback of any patch that fixes
> this problem getting close enough to official XFree to be swallowed ;-)
>
> The patch I'm using isn't clean enough for that... and it might even not
> work for all resolutions/depths; never tried...

AFAICS everything except the very last chunk (is it important?) of your patch
has been integrated in one form or another into XFree86 CVS as a patch of mine
(the one I asked you to test, Michel) was accepted. Have you looked at the
XFree86 CVS lately?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
