Message-ID: <39CCBADE.2A59D37A@student.ethz.ch>
Date: Sat, 23 Sep 2000 16:14:54 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Henry Worth <haworth@ncal.verio.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux keycodes and left cursor on Pismo
References: <Pine.SOL.4.10.10009221556010.17778-100000@ncal.verio.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth schrieb:
>
> Michel Ddnzer <daenzerm@student.ethz.ch> wrote:
>
> >After switching to Linux keycodes (and Debian's i386 us keymap), the left
> >cursor key doesn't generate a keycode anymore. Interestingly, it works in
> >X with Xkb, but not without.
> >
> >Anyone else sees this?
>
> Check the dev and user archives, I think this has been discussed a
> few times since the new input layer backport went in.

I'll do that. I checked Franz's pages on the input layer on PPC and didn't
find anything there.


> However, invoking xmon once X (at least Xpmac 10) is running
> will result in a microscopic xmon text session replicated 4 times
> across the screen (even if you switch back to a text VT first).

This also happens with XFree86, it's because xmon assumes an 8 bit display - I
guess you are running X in 32 bpp? :)


> Martin Costabel wrote:
> >
> > F13 (keycode 0x69) works for me as MagicSysRq (ADB keyboard, kernels
> > 2.2.x or 2.4.0-x).
>
> Ah, well no F13 or equiv. combo on a Pismo. Grepping through
> the sources it doesn't appear there is any bootparm or /proc
> entry to change it...

Would be handy though.

> So changing it to 0x6f in /arc/ppc/kernel/pmac_setup.c and rebuilding it
> should give you F12 instead.

I use that for the right mouse button emu, will it work nonetheless?

Thanks for the tip!


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
