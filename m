Message-ID: <3A037737.2B131815@denise.shiny.it>
Date: Fri, 03 Nov 2000 21:40:55 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.18p19
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I've just tried 2.2.18p19 tree from linuxcare. At the end of the make
process, after vmlinux has been created, it complains:


ld -T ../vmlinux.lds -Ttext 0x00800000 -o zvmlinux.tmp head.o misc.o
../coffboot/zlib.o vreset.o kbd.o of1275.o
vreset.o: In function `vga_init':
vreset.o(.text+0x3c2): undefined reference to `loops_per_jiffy'
vreset.o(.text+0x3c6): undefined reference to `loops_per_jiffy'

Same thing with the official 2.2.18p19.

I first tried USB-HIDBP and it freezes at boot. Less a second after the
mouse is turned on, it lights off and all freezes. 2.2.16p hadn't this
problem. USB-HID works fine.
My IDE CDROM is now /dev/hda instead hde. The ZIP is hdb instead of hdf.

I'm now trying to d/l the bk tree. rsync connection refused :-(

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
