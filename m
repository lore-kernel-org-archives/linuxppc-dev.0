From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 (mvista rsync) -- drivers/ide/ppc/pmac.c:1843: error: request for member `queue_head' in something not a structure or union
Date: Sun, 10 Aug 2003 08:57:53 -0700
References: <200308100851.04174.miles.lane@comcast.net>
In-Reply-To: <200308100851.04174.miles.lane@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308100857.53299.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry, I should have included this in the original message.

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11x
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
GNU ld version 2.14 20030612

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_SL82C105=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
