Message-ID: <20040318072428.47575.qmail@web10601.mail.yahoo.com>
Date: Wed, 17 Mar 2004 23:24:28 -0800 (PST)
From: sudhakar rajashekhara <rsudhakar_blr@yahoo.com>
Subject: RAM Free Space Decreasing
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

We have ported U-boot and Linux-2.4.22 onto a custom
powerpc 8280 board. We were successful in booting
Linux from Hard Disk also(Hard Disk is connected to a
serial ATA card which sits on PCI. We ported the
Serial ATA driver to U-boot from libata source. U-Boot
identifes the Hard Disk and we are able to read and
write to the hard disk from U-Boot). Once the linux
comes up, the Hard Disk is being identifed as a SCSI
device. We have created a swap partition in sda3, and
our filesystem resides in sda4. We have 256MB ram. The
problem what we are facing is, when we try to untar a
huge file (EX: linux-2.4.22.tar, size 158MB), the
board hangs after some time. We observed the available
ram space from other window, when untar was happening,
using "free" command. We found that the "used" area is
continuosly increasing and the available free ram
space is decreasing. At one point of time, when the
free ram space exhausts, the board is hanging. On a
x86 system, the "used" space of ram keeps varying, but
on our PPC board, it's continuosly increasing. We
tried enabling the swap (on /dev/sda3), but even then
the result is same. What is the reason for this? Are
we missing some configuration?

thanks in advance,
regards,
Sudhakar.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
