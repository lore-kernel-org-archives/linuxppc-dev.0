Message-ID: <396A4D77.F79AEADE@pop.agri.ch>
Date: Tue, 11 Jul 2000 00:26:07 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
References: <Pine.LNX.3.96LJ1.1b7.1000710164335.14195C-100000@ofey.inetnebr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:
>
> On Mon, 10 Jul 2000, Benjamin Herrenschmidt wrote:
>
> > >
> > >It doesn't compile per se, in pmac_backlight.c asm/pmu.h & asm/adb.h
> > >should be linux/pmu.h & linux/adb.h. This isn't a tragedy.
> >
> > That's strange, it did compile for me without I push. Looks like bk
> > didn't push the latest version, or something got screwed up... I'll check
> > that tonight.
>
> Why is pmac_backlight.c compiled in for CONFIG_ALL_PPC?  Isn't it
> PowerBook only thing?

I have both a PB and an old 'pm7200' and I build against both.

> > >How can I help?
> >
> > Well, you can check disabling that (and the call that sets up this BAT in
> > head.S) but don't forget, if you do that, to also declare
> > bootx_text_mapped to 0 before leaving prom.c
>
> 601's BAT doesn't have G bit.  Maybe that's the problem?

Don't know, but here on the quick it wasn't the solving hint. Tomorrow..?

Regards,
Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
