Message-ID: <381745F8.B3C225@jlc.net>
Date: Wed, 27 Oct 1999 14:35:36 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: hollis@andrew.cmu.edu
CC: Neil Russell <caret@c-side.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: RevD iMac USB errors (was Problems compiling ppc kernels)
References: <19991027030045.28758.qmail@kunk.jriver.com> <381674D5.15A925B5@andrew.cmu.edu> <19991026225703.G11654@lx.c-side.com> <3816973A.375F987D@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hollis@andrew.cmu.edu wrote:


> Those kernels should definately boot... are you downloading them from
> the Mac OS side? Linux apparently has some issues copying to HFS that
> can render kernels unbootable (this is from personal experience).
> 
> If those still don't work, try the kernel at
> ftp://ftp.linuxppc.org/kernels/BlueG3/v2.2.6/vmlinux-2.2.6-rev1.gz

Thanks for all of the information, but I still haven't found anything
that will boot on my iMac.  I am trying to catch the messages as they
scroll by :-).  The first one that seems suspicious is something
about "hub 0 timeout" trying to attach or initialize.  After that I
get continuous "USB-HUBM Cannot attach to port 0 of hub....." and
"USBD: Transaction....endpoint 0, timed out".

Hacking code now.......I have the 2.2.5 kernel patched up to 2.2.6
with the other keyboard and usb patches as described on johnb's
imaclinux.net pages, as my starting point.  Should I be using something
else?


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
