Date: Tue, 24 Dec 2002 10:52:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] IDE on CHRP LongTrail
In-Reply-To: <Pine.GSO.4.21.0212241005370.1821-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0212241046170.1821-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Dec 2002, Geert Uytterhoeven wrote:
> On 24 Dec 2002, Benjamin Herrenschmidt wrote:
> > Regarding 2.4.21-pre2, did you check the linuxppc_2_4 tree ?
>
> Yes, I checked it during the weekend. Crash in IDE access operations.
> I wrote down the addresses and the corresponding routine names. If you want
> them, I can mail them (when I get back to the piece of paper).

Thanks to my wife, here's the list:

NIP C00A5908 ide_inb
CR  C00A70F8 ide_config_drive_speed
BT  C00A6F54 ide_config_drive_speed
    C00A3314 config_for_pio
    C00A356C sl82c105_ide_dma_off

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
