Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a00b383890d4806@[136.152.65.18]>
Date: Tue, 8 Jun 1999 20:28:34 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Brian C Burke <bcburke@socrates.berkeley.edu>
Subject: TurboMax driver bug
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I downloaded the vmlinux-blueg3v2 kernel from linuxppc.org and it supports
the turbomax card and attached maxtor drives on my beige G3 rev1. However
the cdrom drive at hdc shows up as a twin of the motherboard quantum drive
at hda and is not accessible. The can be seen in the startup printout that
follows.


AEC6210: IDE controller on PCI bus 00 dev 70
AEC6210: not 100% native mode: will probe irqs later
AEC6210: ROM enabled at 0x81800001
    ide2: BM-DMA at 0xfe000400-0xfe000407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xfe000408-0xfe00040f, BIOS settings: hdg:DMA, hdh:pio
hda: QUANTUM FIREBALL ST4300A, ATA DISK drive
hdc: QUANTUM FIREBALL ST4300A, ATA DISK drive
hde: Maxtor 91728D8, ATA DISK drive
hdg: Maxtor 91728D8, ATA DISK drive
ide0 at 0xd4831000-0xd4831007,0xd4831160 on irq 13
ide1 at 0xd4835000-0xd4835007,0xd4835160 on irq 13 (shared with ide0)
ide2 at 0xfe000440-0xfe000447,0xfe000432 on irq 24
ide3 at 0xfe000420-0xfe000427,0xfe000412 on irq 24 (shared with ide2)
hda: QUANTUM FIREBALL ST4300A, 4110MB w/81kB Cache, CHS=14848/9/63, (U)DMA
hdc: QUANTUM FIREBALL ST4300A, 4110MB w/81kB Cache, CHS=14848/9/63, (U)DMA
hde: Maxtor 91728D8, 16479MB w/512kB Cache, CHS=33483/16/63, UDMA
hdg: Maxtor 91728D8, 16479MB w/512kB Cache, CHS=33483/16/63, UDMA


The 2.2.1 kernel which does not detect the TuboMax card detects the cdrom
at hdc correctly.

hda: QUANTUM FIREBALL ST4300A, ATA DISK drive
hdc: MATSHITA CR-585, ATAPI CDROM drive
ide0 at 0xd4831000-0xd4831007,0xd4831160 on irq 13
ide1 at 0xd4835000-0xd4835007,0xd4835160 on irq 14
hda: QUANTUM FIREBALL ST4300A, 4110MB w/81kB Cache, CHS=14848/9/63, (U)DMA
hdc: ATAPI 1X CD-ROM drive, 4224kB Cache
Uniform CDROM driver Revision: 2.54


If this list is not he correct place to report this bug please tell me where.

Thanks,
Brian


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
