Message-ID: <3C437912.61CB9423@attbi.com>
Date: Mon, 14 Jan 2002 16:34:27 -0800
From: C S Rosenmund <gnuman@attbi.com>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: A few questions on older Macintosh Powerbooks
References: <Pine.LNX.4.33.0201141334110.8470-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using that binary image myself, while trying to roll my own. I can
get the box to boot, and do most things with the 2.4.5 sources I have,
but any real loading and the MMU problem crops up. what I need is the
patches to make my hardware work:

PCMCIA (so I can use my NIC and get on the net)
MMU so I do not have to keep going back to a different kernel to try
other options when building the kernel)
and Media Bay (so I can use the CDROM as a software and data transfer
device. . .)

I'm not timid at all about building a kernel, nor about using patches to
fix the broken code, but I need to know where to *find* them

Michael Schmitz wrote:
>
> > Would someone tell me what the latest monolithic kernel and patch
> > available for a NuBus PPC would be and where they can be found? I'm
> > working with the 2.4.5 sources (and the patch-2.4.5-Nubus patch), and it
> > works *almost*. . .
>
> I'm using 2.4.6-pre3 from the SF site on a 6100 here, and it seems to work
> fine. nubus-pmac.sourceforge.net should be the site to look at.
>
>         Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
