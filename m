Date: Sat, 27 Sep 2003 14:40:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Breaking MESH on non-pmac
In-Reply-To: <1064664723.631.47.camel@gaston>
Message-ID: <Pine.GSO.4.21.0309271439300.6768-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 27 Sep 2003, Benjamin Herrenschmidt wrote:
> There will be some work needed if anybody still owns one of
> these CHRPs with a MESH SCSI controller.

Woops...

> Basically, I'm switching the driver to macio-based probing
> (new driver model).
>
> For MESH to be probed on those CHRPs, one will have to either
> hack the driver to add an alternate probe mecanism (ugh !), or
> better, add hydra to the list of known macio chips and make the
> macio device stuff work on CHRPs, which shouldn't be too difficult
> (though it may be weird to have CHRP use pmac_feature.h...)

Time to move one of my SCSI devices from the sym875 to the MESH chain...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
