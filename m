From: Benjamin Herrenschmidt <bh40@calva.net>
To: <toa@pop.agri.ch>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0-test3
Date: Mon, 10 Jul 2000 18:05:13 +0200
Message-Id: <20000710160513.21541@mailhost.mipsys.com>
In-Reply-To: <3969E6B8.D0AE0169@pop.agri.ch>
References: <3969E6B8.D0AE0169@pop.agri.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>It doesn't compile per se, in pmac_backlight.c asm/pmu.h & asm/adb.h
>should be linux/pmu.h & linux/adb.h. This isn't a tragedy.

That's strange, it did compile for me without I push. Looks like bk
didn't push the latest version, or something got screwed up... I'll check
that tonight.

>More problems I get on booting on a wallstreet I. A panic occurs in
>combination with mesh. Have to figure out. I removed mesh and 53c94 from
>the kernel and now it boots.
>
>A patched 7200 fails completely to boot, it stops on displaying
>'booting....'. This kernel is patched with mftb patch from Takashi,
>pci-resource & serial-console patch from Michel. (Otherwise a 7200 would
>not boot)
>
>In the sccstool I read in prom.c Calc BAT..... this may cause trouble if
>the framebuffer is really badly aligned.......
>TODO: Check 601 case...
>
>How can I help?

Well, you can check disabling that (and the call that sets up this BAT in
head.S) but don't forget, if you do that, to also declare
bootx_text_mapped to 0 before leaving prom.c


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
