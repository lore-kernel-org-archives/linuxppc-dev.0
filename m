Date: Mon, 15 May 2000 15:23:51 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: current bk tree
In-Reply-To: <Pine.GSO.4.10.10005150925400.4996-100000@dandelion.sonytel.be>
Message-ID: <Pine.GSO.4.10.10005151523050.4996-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 15 May 2000, Geert Uytterhoeven wrote:
> I managed to compile the current bk tree (+ a few fixes I just checked in) and
> boot it on my LongTrail. Comments:
>
>   - The MESH driver doesn't detect any disks anymore, which is bad.
>
>   - The kernel still detects 3 serial ports:
>
>       ttyS00 at 0x03f8 (irq = 4) is a 16550A
>       ttyS01 at 0x02f8 (irq = 3) is a 16550A
>       ttyS02 at 0x03e8 (irq = 4) is a 16450
>
>     The last one is bogus. This problem has been there seen quite a while, but
>     seems to be harmless.

Forgot one:

    - `cat /proc/ppc_htab' is a solid and alternative way to cause a hard
      reboot in exactly 180 seconds.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
