Date: Fri, 12 Oct 2001 10:40:01 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
In-Reply-To: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.21.0110121023430.20566-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 12 Oct 2001, Paul Mackerras wrote:
> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:

    [...]

> Can others contribute entries to this list please?

CHRP LongTrail: arch/ppc/chrpboot/zImage loaded via OF (floppy, hard disk, CD,
...)

I _think_ this is arch/ppc/boot/images/zImage.chrp these days, but I really
have to verify (Tom? What about your LongTrail?).

Yesterday evening I just powered on my LongTrail again, after 43 days of
downtime due to marriage, honeymoon, moving, etc.  The rest of my home network
still has to be revived... I just hope no one broke LongTrail support during
the past few months :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
