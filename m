Message-ID: <3969E6B8.D0AE0169@pop.agri.ch>
Date: Mon, 10 Jul 2000 17:07:39 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
References: <200007101156.MAA26609@hyperion.valhalla.net> <20000710121009.20193@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >Does anyone know of a source of 2.4.0-test3 that will build for PPC?
> >
> >I grabbed the bitkeeper 2_3 rsync last night - but it doesn't build...  and
> >linux-pmac-devel is currently at test1-ac21...
>
> Grab the bk tree again, I fixed the build yesterday evening (late)

It doesn't compile per se, in pmac_backlight.c asm/pmu.h & asm/adb.h
should be linux/pmu.h & linux/adb.h. This isn't a tragedy.

More problems I get on booting on a wallstreet I. A panic occurs in
combination with mesh. Have to figure out. I removed mesh and 53c94 from
the kernel and now it boots.

A patched 7200 fails completely to boot, it stops on displaying
'booting....'. This kernel is patched with mftb patch from Takashi,
pci-resource & serial-console patch from Michel. (Otherwise a 7200 would
not boot)

In the sccstool I read in prom.c Calc BAT..... this may cause trouble if
the framebuffer is really badly aligned.......
TODO: Check 601 case...

How can I help?


Regards,
Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
