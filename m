From: John_McRoberts@Mitel.COM
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256ADA.00556FC9.00@kanmta01.software.mitel.com>
Date: Wed, 3 Oct 2001 16:34:54 +0100
Subject: reading hard disk partition
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I can't seem to read the hard disk partitions. The hardware is custom hardware
based on a PPC860 and a hardware IDE interface implemented in an FPGA. As can be
seen from the output the hard disk is recognised.

Any ideas??


output from linux kernel

ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
probing for hda: present=0, media=32, probetype=ATA
hda: Ritek Corporation, ATA DISK drive
hda: Ritek Corporation, ATA DISK drive
hda: 250368 sectors (128 MB) w/2KiB Cache, CHS=978/8/32
ide-floppy driver 0.97
Partition check:
 hda: hda1
hd: unable to get major 3 for hard disk
<============================ error


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
