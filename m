Date: Sat, 23 Dec 2000 15:35:31 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Wolfgang Haeuptli <whaeuptli@bluewin.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers with MESH SCSI
In-Reply-To: <19341116104947.29047@192.168.1.2>
Message-ID: <Pine.LNX.4.05.10012231533220.12626-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Dec 2000, Benjamin Herrenschmidt wrote:
> >Well, would have been a nice christmas present... BUT STILL:
> >(after applying the new mesh_init() to scsi/mesh.c)
> >
> >mesh: target 6 aborted
> >
> >which means that my UMAX Astra 1200S Scanner still does not work under
> >linuxppc...
>
> Can you try increasing the udelay() calls in mesh_init() to see if it
> helps ? There maybe something else going on, but it's worth trying.

Note that there can be other problems with the mesh as well: I remember I once
had some early 2.3.x kernels that could not init the mesh when cold-booted,
only when warm-booted. So I had to boot an older kernel first each time I had
powered down my box :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
