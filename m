Message-ID: <38ffabf0395f2339@antholoma.wanadoo.fr> (added by antholoma.wanadoo.fr)
Date: Fri, 21 Apr 2000 03:08:51 +0000
Subject: Re : does'nt work BWG3v2's ide
From: "Florent BOUDET" <flobo@iname.com>
To: Kaoru Fukui <k_fukui@highway.ne.jp>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have experienced the same ide probing problem with 2.3.99-preX, too. (BW
G3 rev2)
Since I couldn't find any issues, I switched back to the stable tree.
Has anyone good ide probes with CMD646 ?

If anyone knows a solution, I am interested, too.

Florent

>From : Kaoru Fukui <k_fukui@highway.ne.jp>

> Hi!
>
> I am trying kernel-2.3.99-pre6 from paul's tree.
>
> Since a couple month ago,
>   I don't have success the kernel on the CMD646 ide HD.
> My machine is BWG3v2 which have CMD646.
> it's ide driver is fail.
> the scsi is no problem as well.
>
> I think that nomal ide is ok.
> I doesn't use DEVFS_FS.
>
> Any fix.
>
>
> Kaoru
>
> CMD646: IDE controller on PCI bus 01 dev 08
> CMD646: chipset revision 0x07, UltraDMA Capable
> CMD646: 100% native mode on irq 26
>     ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:pio, hdd:pio
> pmac_ide: enabling IDE bus ID 0
> hda: , ATA DISK drive
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> hde: MATSHITA CR-589, ATAPI CDROM drive
> ide0 at 0x1440-0x1447,0x000 on irq 26
> ide2 at 0xcf1a9000-0xcf1a9007,0xcf1a9160 on irq 13
> hda: 0 sectors (0 MB), CHS=0/0/0, DMA
> hda: INVALID GEOMETRY: 0 PHYSICAL HEADS?
> hde: ATAPI 32X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.07
> (scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 1/4/0
> (scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
> (scsi0) Downloading sequencer code... 392 instructions downloaded
> scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.0/3.2.4
>        <Adaptec AHA-294X Ultra2 SCSI host adapter>
> scsi1 : MESH
> scsi : 2 hosts.
> (scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 15.
>   Vendor: IBM       Model: DDRS-39130D       Rev: DC2A
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
> scsi : detected 1 SCSI disk total.
> SCSI device sda: hdwr sector= 512 bytes. Sectors= 17850000 [8715 MB] [8.7 GB]
> Partition check:
>  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9
> Macintosh ADB mouse driver installed.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
