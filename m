Message-ID: <4024DD8F.7030609@g-house.de>
Date: Sat, 07 Feb 2004 13:43:59 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: compiling error with 2.4.24-ben1
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

me again with another issue here. said in another thread that
2.4.24-ben1 is compiling fine 8producing only odd warnings), i still
*have* to enable

CONFIG_ADB_CUDA
CONFIG_ADB_PMU
CONFIG_NVRAM

disabling one of these or even CONFIG_NVRAM=m
will produce an error:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o
init/version.o init/do_mounts.o \
~        --start-group \
~        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o
ipc/ipc.o arch/ppc/xmon/x.o \
~         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/scsi/scsidrv.o drivers/pci/driver.o
drivers/macintosh/macintosh.o drivers/video/video.o
drivers/media/media.o drivers/isdn/vmlinux-obj.o crypto/crypto.o \
~        net/network.o \
~        /data/MP3/scratch/kernel/linux-2.4-benh-RSYNC/lib/lib.a \
~        --end-group \
~        -o vmlinux
arch/ppc/platforms/platform.o(.text.init+0x64bc): In function
`lookup_partitions':
: undefined reference to `nvram_read_byte'
make: *** [vmlinux] Error 1
evil@sheep:/data/MP3/scratch/kernel/linux-2.4-benh-RSYNC$

i have a PReP here and i think i do not really need these options:
http://nerdbynature.de/bits/sheep/2.4.24-benh/ver_linux
http://nerdbynature.de/bits/sheep/2.4.24-benh/nvram_read_byte/config

Thank you for your time,
Christian.

- --
BOFH excuse #444:

overflow error in /dev/null

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
