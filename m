Message-ID: <903E17B6FF22A24C96B4E28C2C0214D7CCC028@sr-bng-exc01.int.tsbu.net>
From: "Rahman,  Masoodur" <Masoodur.Rahman@fci.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: PDC20269 on PPC hangs
Date: Wed, 11 Jun 2003 19:35:38 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi ,
   I am trying to make the Ramix PMC243 module on the linux-2.4.20-pre2 from
the montavista site(IBM 750FX + MV64360) . The kernel seems to hang on the
partition check . The IRQ for the PMC is not shared with any other device.

Attached is the log for the 2 PMC sites during the bootup sequence...

PMC1
=====
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller on PCI bus 00 dev 70
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: ROM enabled at 0x000dc000
PDC20269: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20269: FORCING BURST BIT 0x30 -> 0x31 ACTIVE
    ide2: BM-DMA at 0xffffd0-0xffffd7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xffffd8-0xffffdf, BIOS settings: hdg:pio, hdh:pio
hde: disabling irq 90 defensively
hde: IC25N010ATDA04-0, ATA DISK drive
hdf: disabling irq 90 defensively
hdf: disabling irq 90 defensively
ide2 at 0xfffff8-0xffffff,0xfffff6 on irq 90
blk: queue 901afa28, I/O limit 4095Mb (mask 0xffffffff)
hde: 19640880 sectors (10056 MB) w/347KiB Cache, CHS=19485/16/63, UDMA(33)
Partition check:
 hde:

<hang>

PMC2
=====
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller on PCI bus 01 dev 68
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: ROM enabled at 0x000dc000
PDC20269: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20269: FORCING BURST BIT 0x30 -> 0x31 ACTIVE
    ide2: BM-DMA at 0x1ffffd0-0x1ffffd7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1ffffd8-0x1ffffdf, BIOS settings: hdg:pio, hdh:pio
hde: disabling irq 77 defensively
hde: IC25N010ATDA04-0, ATA DISK drive
hdf: disabling irq 77 defensively
hdf: disabling irq 77 defensively
ide2 at 0x1fffff8-0x1ffffff,0x1fffff6 on irq 77
blk: queue 901afa28, I/O limit 4095Mb (mask 0xffffffff)
hde: 19640880 sectors (10056 MB) w/347KiB Cache, CHS=19485/16/63, UDMA(33)
Partition check:
 hde:hde: timeout waiting for DMA
PDC202XX: Primary channel reset.
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
 [PTBL] [1222/255/63] hde1 hde2 <hde: timeout waiting for DMA
PDC202XX: Primary channel reset.
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
 hde5 >
RAMDISK driver initialized: 16 RAM disks of 131072K size 1024 blocksize

and proceeds to the linux prompt.

Was there any patch available for the same ?? Was it fixed in the
linux-2.4.20 from kernel.org ?? I can migrate my patch to the linux-2.4.20
from kernel.org if that fixes my problem.....

Thanks a lot

regards
rahman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
