Message-ID: <3935BEE9.63593F78@wanadoo.fr>
Date: Thu, 01 Jun 2000 03:39:54 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh in 2.4.0-test1
References: <Pine.LNX.4.05.10005312242300.2148-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> Is there anyone who is succesfully using SCSI devices connected to MESH SCSI
> with 2.4.0-test1 (or late 2.3.99-preX, e.g. pre9)?

Yes. I have only the one SCSI bus, though. From dmesg:

scsi0 : MESH
scsi : 1 host.
mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-8008    Rev: 8.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
mesh: target 4 synchronous at 5.0 MB/s
  Vendor: QUANTUM   Model: XP34550S          Rev: LXY4
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 4, lun 0
  Vendor: IOMEGA    Model: ZIP 100           Rev: E.08
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
scsi : detected 1 SCSI cdrom 2 SCSI disks total.
Uniform CD-ROM driver Revision: 3.08
SCSI device sda: hdwr sector= 512 bytes. Sectors= 8890760 [4341 MB] [4.3
GB]
 /dev/scsi/host0/bus0/target4/lun0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 196608 [96 MB] [0.1
GB]
sdb: Write Protect is off
 /dev/scsi/host0/bus0/target5/lun0: p1 p2 p3 p4

Kernel is current rsync from bitkeeper (2.4.0-test1, no ac):

root[5]#cat /proc/version
Linux version 2.4.0-test1 (root@chezmoi) (gcc version 2.95.3 19991030
(prerelease/franzo)) #61 Mon May 29 09:36:00 CEST 2000

The only problem I have with these devices is that I can't mount a HFS
CD, but whose fault this is is unknown, probably hfs or mount.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
