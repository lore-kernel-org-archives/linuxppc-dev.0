Date: Wed, 27 Dec 2000 19:15:35 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers with MESH SCSI
In-Reply-To: <19341120115827.19132@192.168.1.2>
Message-ID: <Pine.LNX.4.05.10012271914190.27676-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Dec 2000, Benjamin Herrenschmidt wrote:
> >Note that there can be other problems with the mesh as well: I remember
> I once
> >had some early 2.3.x kernels that could not init the mesh when cold-booted,
> >only when warm-booted. So I had to boot an older kernel first each time I had
> >powered down my box :-)
>
> There were issues with powering up the MESH on some powerbooks that were
> fixed some time ago, but maybe your issue is unrelated.

Yes, since I don't have a Powerbook, but a LongTrail.

> Looking at Darwin's MESH driver, they have a whole bunch of workarounds
> for known issues (either with common device protocol errors, or MESH
> internal races).

I still see the

    mesh: halt_dma: data_ptr=-256 (nb=20736, ms=c06ff278)

(i.e. the DMA ptr shows it did 256 bytes too much), but I never noticed any
file corruption during the 3.5 years I've been using this machine. Let's call
it a harmless hardware bug.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
