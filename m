Message-ID: <3923016A.6AB13AE8@ccrl.mot.com>
Date: Wed, 17 May 2000 15:30:34 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: more on e2fsck
References: <200005171655.SAA21603@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It was operator error ... in the MCONFIG.in I changed $CC to
powerpc-linux-gcc but $LD was still set to cc, so I changed
$LD to powerpc-linux-gcc and it worked. Must have been
screwing something up in the link stage.

Thanks for the help!
Steve


Wolfgang Denk wrote:

> In message <3922CB9E.873738B6@ccrl.mot.com> you wrote:
> >
> > is there possibly some disparity between the kernel's ext2 fs code and
> > what
> > mke2fs and e2fsck are doing? if anyone has any further thoughts on this
> > I would appreciate it.
>
> Maybe header files, endianess, or so?
>
> What is your build environment?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Quote from a recent meeting:   "We are going to continue having these
> meetings everyday until I find out why no work is getting done."

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
