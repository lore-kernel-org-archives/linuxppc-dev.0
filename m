Message-ID: <397CDA75.3790A3DB@home.com>
Date: Mon, 24 Jul 2000 19:08:21 -0500
From: Jordan <ledzep37@home.com>
MIME-Version: 1.0
To: Linuxppc Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Errors while compiling 2.4.0test5 from BitKeeper
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been compiling my own kernels for a while now, lately though the
2.2 series gives me machine check errors and panics every time I start
up no matter which version I compile, so I decided to start trying the
2.4 series.  For about the past two weeks now I have been trying to
figure out how to get the kernel to finish compiling and not gives the
following errors:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/parport/parport.a  drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/cdrom.a
drivers/sound/sounddrivers.o drivers/pci/pci.a
drivers/macintosh/macintosh.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `pmac_set_rtc_time':
arch/ppc/kernel/kernel.o(.text+0x8ff8): undefined reference to
`pmu_request'
arch/ppc/kernel/kernel.o(.text+0x8ff8): relocation truncated to fit:
R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text+0x9008): undefined reference to
`pmu_poll'
arch/ppc/kernel/kernel.o(.text+0x9008): relocation truncated to fit:
R_PPC_REL24 pmu_poll
make: *** [vmlinux] Error 1

I would like to try this kernel to see if I can get it to boot on my
PowerMac G3 Beige Mini-Tower; however, until I can get this thing
figured out it looks like I am stuck.  Thanks for any help.

Jordan Breeding

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
