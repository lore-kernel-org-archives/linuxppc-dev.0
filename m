Date: Fri, 14 Apr 2000 19:13:05 -0400 (EDT)
From: Scott Knight <scott@re-104-1.read.indiana.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel 2.3 make error
Message-ID: <Pine.LNX.4.10.10004141910200.6328-100000@fletch.read.indiana.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Ive tried over the past three days grabbing the latest kernel from
pauls tree. And everytime i get the same error near the end. I think it
has to do with the controlfb.c file or something having to do that I need
the control frame buffer, if anyone knows why I ight be getting this error
thatd be great. Below is the error.

	Scott

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/parport/parport.a  drivers/ide/ide.a
drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/sound/sounddrivers.o drivers/pci/pci.a drivers/macintosh/macintosh.a
drivers/video/video.o \
        net/network.a \
        /usr/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/video/video.o: In function `init_control':
drivers/video/video.o(.text.init+0x1354): undefined reference to `mac_map_monitor_sense'
drivers/video/video.o(.text.init+0x1354): relocation truncated to fit:
R_PPC_REL24 mac_map_monitor_sense
make: *** [vmlinux] Error 1


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
