Message-ID: <3A55E402.DA790B96@iiic.ethz.ch>
Date: Fri, 05 Jan 2001 16:10:58 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problems when recompiling dmasound modules
References: <200101041317.NAA24882@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> > so they rely on `make oldconfig' and `make dep' instead...
>
> vi Makefile, change EXTRAVERSION to append -ids (my usual kinda practice)...
>
> make oldconfig dep vmlinux modules
>
>  - builds dmasound_core & dmasound_awacs
>
> make_install creates a new /lib/modules/2.4.0-test13-pre3-ids and the
> modules appear to be installed...
>
> so... it seems to work for me.

The problem only shows up when I boot the new kernel and try to insmod the
dmasound modules, have you tried that?


If make dep is always needed after make oldconfig that may be the problem as I
also rely on make oldconfig telling me if I have to do that. (real men, you
know ;)


I'll report back when I've had the chance to test that.

Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
