Date: Thu, 21 Dec 2000 17:30:30 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers with MESH SCSI
In-Reply-To: <19341115030509.14383@192.168.1.10>
Message-ID: <Pine.LNX.4.05.10012211729150.623-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Dec 2000, Benjamin Herrenschmidt wrote:
> I need some feedback about the following change to the MESH driver. Does
> it fix previously non-working configurations ? Does it break currently
> working configurations ?

Doesn't make a difference for me. This is on a CHRP LongTrail with Apple Hydra
Mac I/O and one disk on the MESH chain:

    Host: scsi1 Channel: 00 Id: 05 Lun: 00
      Vendor: QUANTUM  Model: FIREBALL_TM3200S Rev: 300X
      Type:   Direct-Access                    ANSI SCSI revision: 02

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
