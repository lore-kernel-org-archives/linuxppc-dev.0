Message-ID: <3927EB13.C668710E@mandrakesoft.com>
Date: Sun, 21 May 2000 09:56:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
CC: jeramy b smith <ultrapenguin@netscape.net>,
        Debian-PowerPC <debian-powerpc@lists.debian.org>,
        Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pauls 2.2.15 does not boot a 7200
References: <20000521121729.8813.qmail@www0x.netaddress.usa.net> <20000521042643.J7243@plato.local.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Benson wrote:
>
> On Sun, May 21, 2000 at 07:17:29AM -0500, jeramy b smith wrote:
> > I rsynced up to 15 from pre20 and compiled the kernel. Boots just fine using
> > bootx on the 7200 I stole from work on Friday.
>
> as i have mentioned bootx is not an option, there is no macos (and no
> space for it)
>
> > Using the novideo option as well as video=platinumfb
>
> ill try forcing the video to that so we can at least see if the kernel
> is giving any hints as to why it fails to boot.
>
> > I can try to OF boot this 7200 but I don't want to develop a migraine this
> > weekend.
>
> bah OF booting is not that hard ;-)

I've always had trouble getting a kernel going on the 7200.

I believe my solution was a stripped-down kernel, something like
removing the VGA console was key IIRC.

	Jeff



--
Jeff Garzik              | Liberty is always dangerous, but
Building 1024            | it is the safest thing we have.
MandrakeSoft, Inc.       |      -- Harry Emerson Fosdick

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
