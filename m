Subject: Re: [PATCH] IDE on CHRP LongTrail
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.21.0212241046170.1821-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0212241046170.1821-100000@vervain.sonytel.be>
Content-Type: text/plain
Date: 24 Dec 2002 11:00:48 +0100
Message-Id: <1040724049.559.2.camel@zion>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-12-24 at 10:52, Geert Uytterhoeven wrote:
> On Tue, 24 Dec 2002, Geert Uytterhoeven wrote:
> > On 24 Dec 2002, Benjamin Herrenschmidt wrote:
> > > Regarding 2.4.21-pre2, did you check the linuxppc_2_4 tree ?
> >
> > Yes, I checked it during the weekend. Crash in IDE access operations.
> > I wrote down the addresses and the corresponding routine names. If you want
> > them, I can mail them (when I get back to the piece of paper).
>
> Thanks to my wife, here's the list:
>
> NIP C00A5908 ide_inb
> CR  C00A70F8 ide_config_drive_speed
> BT  C00A6F54 ide_config_drive_speed
>     C00A3314 config_for_pio
>     C00A356C sl82c105_ide_dma_off

Ok, I'll look at this when I'm back (I have no pci-ide HW at hand, and
ide-pmac works as it uses different MMIO access ops now).

Regarding briq and winbond, same answer, I need to check it out when I'm
back from vacation, I'm not yet sure about what OF does here, but I
surely want to switch it to fully native mode as well, especially since
the kernel will soon (I think 2.5 is already that way) ignore the BARs
completely when using legacy mode.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
