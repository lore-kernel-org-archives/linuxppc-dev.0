Date: Fri, 2 Jun 2000 09:50:30 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re:mesh in 2.4.0-test1
In-Reply-To: <200006010459.XAA15887@lists.linuxppc.org>
Message-ID: <Pine.OSF.4.02.10006020942310.32075-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Geert
> Is there anyone who is succesfully using SCSI devices connected to MESH SCSI
> with 2.4.0-test1 (or late 2.3.99-preX, e.g. pre9)?
I do, everything is detected fine, I use
Linux version 2.4.0-test1-ac4 (root@ma1311) (gcc version 2.95.2 19991024
(release/franzo))

The ac1 version I tried before worked aswell. dmesg looks like:

mesh: target 0 synchronous at 10.0 MB/s
  Vendor: QUANTUM   Model: FIREBALL_TM3200S  Rev: 300X
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
mesh: target 1 synchronous at 10.0 MB/s
  Vendor: MICROP    Model: 4345NS            Rev: x43h
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi1, channel 0, id 1, lun 0
mesh: target 3 synchronous at 10.0 MB/s
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 3, lun 0
scsi : detected 1 SCSI cdrom 2 SCSI disks total.

Mounting a crdrom doesen't work for me either,
mount -t hfs /dev/cdrom /mnt/cdrom yields:

mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       or too many mounted file systems

Cheers
Henning


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
