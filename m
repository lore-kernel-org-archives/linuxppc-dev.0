Message-ID: <3B7A8E4B.ECDDF577@us.ibm.com>
Date: Wed, 15 Aug 2001 14:59:23 +0000
From: Scott Carroll <scottcar@us.ibm.com>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Power3 problem?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While building for Power3 (p640), ChangeSet@1.263, 2001-08-15:


-- make[1]: Leaving directory `/usr/src/latest_0815/net'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/net/tokenring/tr.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/macintosh/macintosh.o drivers/video/video.o
drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/latest_0815/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `proc_dol2crvec':
arch/ppc/kernel/kernel.o(.text+0x634c): undefined reference to
`_set_L2CR'
arch/ppc/kernel/kernel.o(.text+0x634c): relocation truncated to fit:
R_PPC_REL24 _set_L2CR
arch/ppc/kernel/kernel.o(.text+0x6378): undefined reference to
`_get_L2CR'
arch/ppc/kernel/kernel.o(.text+0x6378): relocation truncated to fit:
R_PPC_REL24 _get_L2CR
arch/ppc/kernel/kernel.o: In function `pmac_setup_arch':
arch/ppc/kernel/kernel.o(.text.init+0x2cec): undefined reference to
`_set_L2CR'
arch/ppc/kernel/kernel.o(.text.init+0x2cec): relocation truncated to
fit: R_PPC_REL24 _set_L2CR
arch/ppc/kernel/kernel.o(.text.init+0x2cf4): undefined reference to
`_set_L2CR'
arch/ppc/kernel/kernel.o(.text.init+0x2cf4): relocation truncated to
fit: R_PPC_REL24 _set_L2CR
arch/ppc/kernel/kernel.o: In function `core99_init_l2':
arch/ppc/kernel/kernel.o(.text.pmac+0x3e4): undefined reference to
`_get_L2CR'
arch/ppc/kernel/kernel.o(.text.pmac+0x3e4): relocation truncated to fit:
R_PPC_REL24 _get_L2CR
arch/ppc/kernel/kernel.o(.text.pmac+0x404): undefined reference to
`_get_L2CR'
arch/ppc/kernel/kernel.o(.text.pmac+0x404): relocation truncated to fit:
R_PPC_REL24 _get_L2CR
arch/ppc/kernel/kernel.o(.text.pmac+0x424): undefined reference to
`_set_L2CR'
arch/ppc/kernel/kernel.o(.text.pmac+0x424): relocation truncated to fit:
R_PPC_REL24 _set_L2CR
arch/ppc/kernel/kernel.o(.text.pmac+0x42c): undefined reference to
`_set_L2CR'
arch/ppc/kernel/kernel.o(.text.pmac+0x42c): relocation truncated to fit:
R_PPC_REL24 _set_L2CR
make: *** [vmlinux] Error 1
Scott Carroll                                  IBM RS/6000
Division
11400 Burnet Road, M.S. 9541       Notes:       scottcar@us.ibm.com
Austin, TX  78758-3493 U.S.A       phone:       +1 (512) 838-9642

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
