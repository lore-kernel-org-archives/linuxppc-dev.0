From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.6.0-test2-bk5 (linus' tree) -- drivers/ide/ppc/pmac.c:1265: error: `ide_dma_intr' undeclared (first use in  this function)
Date: Tue, 5 Aug 2003 23:29:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308052329.40548.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When these are not set:
	CONFIG_BLK_DEV_IDEDMA_PCI
	CONFIG_IDEDMA_PCI_AUTO
	CONFIG_BLK_DEV_ADMA
the pmac ide driver won't build.

Perhaps another build constraint is needed?

  CC      drivers/ide/pci/generic.o
drivers/ide/pci/generic.c: In function `init_dma_generic':
drivers/ide/pci/generic.c:77: warning: implicit declaration of function
`ide_setup_dma'
  LD      drivers/ide/pci/built-in.o
  CC      drivers/ide/ppc/pmac.o
drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_read':
drivers/ide/ppc/pmac.c:1265: error: `ide_dma_intr' undeclared (first use in
this function)
drivers/ide/ppc/pmac.c:1265: error: (Each undeclared identifier is reported
only once
drivers/ide/ppc/pmac.c:1265: error: for each function it appears in.)
drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_write':
drivers/ide/ppc/pmac.c:1318: error: `ide_dma_intr' undeclared (first use in
this function)
drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_test_irq':
drivers/ide/ppc/pmac.c:1426: warning: comparison is always false due to
limited range of data type
drivers/ide/ppc/pmac.c: In function `pmac_ide_setup_dma':
drivers/ide/ppc/pmac.c:1499: error: `__ide_dma_off' undeclared (first use in
this function)
drivers/ide/ppc/pmac.c:1500: error: `__ide_dma_off_quietly' undeclared (first
use in this function)
drivers/ide/ppc/pmac.c:1501: error: `__ide_dma_on' undeclared (first use in
this function)
drivers/ide/ppc/pmac.c:1511: error: `__ide_dma_good_drive' undeclared (first
use in this function)
drivers/ide/ppc/pmac.c:1512: error: `__ide_dma_bad_drive' undeclared (first
use in this function)
drivers/ide/ppc/pmac.c:1513: error: `__ide_dma_verbose' undeclared (first use
in this function)
drivers/ide/ppc/pmac.c:1514: error: `__ide_dma_timeout' undeclared (first use
in this function)
drivers/ide/ppc/pmac.c:1515: error: `__ide_dma_retune' undeclared (first use
in this function)
drivers/ide/ppc/pmac.c:1517: error: `__ide_dma_queued_on' undeclared (first
use in this function)
drivers/ide/ppc/pmac.c:1518: error: `__ide_dma_queued_off' undeclared (first
use in this function)
make[3]: *** [drivers/ide/ppc/pmac.o] Error 1


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
