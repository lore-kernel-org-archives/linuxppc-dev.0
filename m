From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc-2.5 (mvista rsync) -- drivers/ide/ppc/pmac.c:1843: error: request for member `queue_head' in something not a structure or union
Date: Sun, 10 Aug 2003 08:51:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308100851.04174.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  CC      drivers/ide/ppc/pmac.o
drivers/ide/ppc/pmac.c: In function `pmac_ide_build_sglist':
drivers/ide/ppc/pmac.c:1198: warning: passing arg 1 of `blk_rq_map_sg' from
incompatible pointer type
drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_test_irq':
drivers/ide/ppc/pmac.c:1673: warning: comparison is always false due to
limited range of data type
drivers/ide/ppc/pmac.c: In function `idepmac_wake_device':
drivers/ide/ppc/pmac.c:1843: error: request for member `queue_head' in
something not a structure or union
drivers/ide/ppc/pmac.c: In function `idepmac_wake_drive':
drivers/ide/ppc/pmac.c:1927: error: request for member `queue_head' in
something not a structure or union

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
