Date: Wed, 9 Aug 2000 16:24:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000808174157.21374@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10008091621490.416-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Benjamin Herrenschmidt wrote:
>  - The first one, well hidden in kernel/time.c (generic code) is the call
> to warp_time(). This is an awful hack that seem to be done because PCs
> apparently also set the RTC to local time. This hack will cause the

It depends: Linux-only PCs are encouraged to run the RTC in UTC, while you
have to run the RTC in local time if you want Linux to coexist with some other
OSses, e.g. those from Redmond.

Which one is used is specified in user space. On Debian (I'm using 2.1 on an
isa32 box right here), I have the lines

    # Set GMT="-u" if your system clock is set to GMT, and GMT="" if not.
    GMT="-u"

in /etc/default/rcS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
