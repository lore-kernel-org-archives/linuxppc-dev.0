Date: Sun, 28 May 2000 19:10:27 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_dmaproc - YaBoot
In-Reply-To: <200005281535.RAA03544@piglet.grunz.lu>
Message-ID: <Pine.OSF.4.02.10005281908190.24993-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 28 May 2000, Michel Lanners wrote:
> Hi there,
>
> On  28 May, this message from Henning Loeser echoed through cyberspace:
> > Something else seems to be fishy aswell maybe the driver (???) or
> > whatever. I went ahead and tried a new 2.4.0test1-ac1 kernel and all of
> > the sudden the driver doesn't even see the drive any more ... :
> > AEC6260R: IDE controller on PCI bus 00 dev 68
> > AEC6260R: chipset revision 1
> > AEC6260R: not 100% native mode: will probe irqs later
> > AEC6260R: ROM enabled at 0x80810000
> > AEC6260: reg49h=0x00 ATA-66 Cable Port0
> >     ide0: BM-DMA at 0x0800-0x0807, BIOS settings: hda:pio, hdb:pio
> > AEC6260: reg49h=0x00 ATA-66 Cable Port1
> >     ide1: BM-DMA at 0x0808-0x080f, BIOS settings: hdc:pio, hdd:pio
> > hda: ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ, ATA DISK drive
> > ide0 at 0x840-0x847,0x000 on irq 23
>           ^^^^^^^^^^^
> You're not using my PCI patches. I'm amazed it finds anything at all on
> your card; but anyway, get my latest 2.3.99 patches (2.3.99-pre9, that
> is), and apply them. From the above, it seems only part of the
> communication of the card with the driver works ok, whereas the rest
> reads schrott.

Well this is with a 2.4.0test1 kernel, I wasn't shure whether your patches
would install on that. I'll try to apply your 2.3.99-pre9 patches onto
that source. But that has to wait untill tomorrow ;-)

Henning
--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
