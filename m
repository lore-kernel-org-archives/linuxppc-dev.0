Date: Thu, 2 Jan 2003 15:40:46 +0000
From: Jess Balint <dollzerr@iwaynet.net>
To: LEM Swap List <lem-swap@mail.maclaunch.com>,
	Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: iBook CD-ROM Locks Hard
Message-Id: <20030102154046.08b97356.dollzerr@iwaynet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all. I have been experiening hard-locks when trying to access or burn a cd on my iBook. Has this happened before? Does anybody know what might be wrong? Any ideas would be appreciated. Thanks.

jess

Here is some relevant kernel info:

Linux johnnyR 2.4.20-pre4  ppc PowerBook4,1

Kernel command line: root=/dev/hda10 ro hdb=ide-scsi
ide_setup: hdb=ide-scsi
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
pmac_ide: enabling IDE bus ID 2
hda: IBM-DJSA-210, ATA DISK drive
hdb: SONY CD-RW CRX700E, ATAPI CD/DVD-ROM drive
ide0 at 0xec88b000-0xec88b007,0xec88b160 on irq 19
hda: Enabling Ultra DMA 2
ide_pmac: Set UDMA timing for mode 2, reg: 0x1090038c
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=19485/16/63, UDMA(33)
hdb: Enabling MultiWord DMA 2
ide_pmac: MDMA, cycleTime: 120, accessTime: 75, recTime: 45
ide_pmac: Set MDMA timing for mode 2, reg: 0x0001978c
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX700E    Rev: 1.3s
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
kmod: failed to exec /sbin/modprobe -s -k i2c-keywest, errno = 2


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
