Message-ID: <20040430040048.85521.qmail@web40411.mail.yahoo.com>
Date: Thu, 29 Apr 2004 21:00:48 -0700 (PDT)
From: Raghu <raghu_dk@yahoo.com>
Subject: Using 2GB RAM kernel ppc-2.4.20
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello All,

My board is - PowerPC 750FX, System Controller- Marvel
64360, Internal reg Map at- 0xFE000000,SDRAM 2GB.

Refering mail:
"http://lists.linuxppc.org/linuxppc-embedded/200307/msg00018.html"

CONFIG settings I have are:
CONFIG_HIGHMEM=y
CONFIG_HIGHMEM_START_BOOL=y
CONFIG_HIGHMEM_START=fc000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_KERNEL_START=90000000

And io_block_mapping is
io_block_mapping( 0xFE000000, 0xFE000000, 0x10000000,
_PAGE_IO );

I changed the PKMAP_BASE to 0xFC000000, but still see
the "init" not working on doing a NFS rootfs mount.

Regards,
Raghu.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
