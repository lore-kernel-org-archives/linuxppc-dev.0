Date: Mon, 21 Jun 2004 10:47:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dieu Morales <dieumorales@yahoo.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Asiliantfb (Frame Buffer) Driver
In-Reply-To: <20040620204028.58544.qmail@web60402.mail.yahoo.com>
Message-ID: <Pine.GSO.4.58.0406211046060.6543@waterleaf.sonytel.be>
References: <20040620204028.58544.qmail@web60402.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 20 Jun 2004, Dieu Morales wrote:
> Greetings, I am working with the latest 2.6.7 kernel
> source on a ppc radstone PPC7A board and have included
> the CT69000 frame buffer to attempt to get a vga
> console.  However, when I set
> conswitchp = &dummy_con;
> the video initializes (monitor signal LED turns green
> from orange) and I get a green screen on the monitor.
> And when I set
> vgacon_remap_base = 0xfe000000;
> conswitchp = &vga_con;
> the video initializes (monitor signal LED turns green
> from orange)  and 50% of the time I get nothing on the
> monitor and the other 50% of the time I get what looks
> to be a screen saver that displays colors fading into
> one another (red->green->blue...) for about 10 sec
> like some kind of a video test. I placed
> vgacon_remap_base at the PCI0 I/O base, is this
> correct?
> I have added console=tty0 to the kernel command line
> and have not identified any other configuration items
> needed.  The serial console I/O which I am expecting
> to see on the monitor shows the driver initialized
> without errors.  Am I missing something in terms of
> configuration?  I have also noticed that when using
> vga_con no graphics card is detected in vgacon.c so
> goto no_vga and conswitchp = &dummy_con;
> Would this be related to the problem?

Does you firmware initialize the CT69000?
Asiliantfb may need an initialized CT69000.
Vgacon needs a graphics chip initialized to VGA mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
