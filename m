Message-ID: <3A79F062.43CF3B34@relog.ch>
Date: Fri, 02 Feb 2001 00:25:22 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Steven Hanley <sjh@wibble.net>
CC: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: agpgart? or how to use dri?
References: <20010201184806.A5957@chiru.svana.org> <19341227050123.16989@mailhost.mipsys.com> <20010202095306.A7859@chiru.svana.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steven Hanley wrote:

> > Don't enable either AGP or DRI in your
> > kernel, and build the kernel r128 DRM module from XFree sources.
>
> I didnt, but as mentioned when I dont have AGP gart enabled in the kernel
> make in the kernel module directory in the X Free source tree only makes
> tdfx, it fdoesnt do r128 or anything else.

Have you tried make -f Makefile.linux ? And are you sure that it is picking up
the right kernel headers?


> > I slightly hacked my own to build since I lack the glide libs necessary
> > for the 3dfx stuff to compile.
>
> what does glide have to do with this? isnt that only used with tdfx?

Exactly, that's why you have to disable it in host.def or you get errors
during the build.


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
