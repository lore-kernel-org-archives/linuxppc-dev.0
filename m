Date: Sun, 28 May 2000 16:35:13 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: Ethan Benson <erbenson@alaska.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_dmaproc - YaBoot
In-Reply-To: <20000528061224.I29071@plato.local.lan>
Message-ID: <Pine.OSF.4.02.10005281623430.24781-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 28 May 2000, Ethan Benson wrote:
> yaboot will not work on oldworld macs, you need to use quik instead.
Ok
>
> > Well I do encounter strange Problems ...
>
> seems typical of bootx lately...
>
> > So should I go through the hassel of installing yaboot?
>
> no because it would be a waste of time since it won't work ;-)  you
> should go to the hassle of installing quik instead. (hint use debian
> quik it actually works)

Well beeing lazy I would only do that if it does promise some progress in
getting the card to work. I'll see what I can find out about quik, but
maybe I have to give it a try to find out ... :-(

Something else seems to be fishy aswell maybe the driver (???) or
whatever. I went ahead and tried a new 2.4.0test1-ac1 kernel and all of
the sudden the driver doesn't even see the drive any more ... :
AEC6260R: IDE controller on PCI bus 00 dev 68
AEC6260R: chipset revision 1
AEC6260R: not 100% native mode: will probe irqs later
AEC6260R: ROM enabled at 0x80810000
AEC6260: reg49h=0x00 ATA-66 Cable Port0
    ide0: BM-DMA at 0x0800-0x0807, BIOS settings: hda:pio, hdb:pio
AEC6260: reg49h=0x00 ATA-66 Cable Port1
    ide1: BM-DMA at 0x0808-0x080f, BIOS settings: hdc:pio, hdd:pio
hda: ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ, ATA DISK drive
ide0 at 0x840-0x847,0x000 on irq 23
hda: 187353000 sectors (95925 MB) w/11565KiB Cache, CHS=23130/90/90
hda: INVALID GEOMETRY: 90 PHYSICAL HEADS?

and then doesn't even enable the drive. I emailed that to Andre Hedrick to
see whether he knows whats going on.

Henning

--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
