Message-ID: <000701c39911$53d15f70$4844900a@hydingnb1>
From: "hyding" <nari_dhy@nari-china.com>
To: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
Subject: mount root on the ml300 board
Date: Thu, 23 Oct 2003 10:56:59 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
    I am debugging MontaVista linux pro3.0(kernel 2.4.28) on the ml300
board. I use IBM MicroDrive 1GB card to configure the FPGA and act as
root fs. But the boot stops and displays the following:
...
block: 128 slots per queue, batch=32
Partition check:
 xsysacea: xsysacea1 xsysacea2 xsysacea3
System ACE at 0xCF000000 mapped to 0xC900F000, irq=9, 1052352KB
Kernel panic: I have no root and I want to scream
 <0>Rebooting in 180 seconds..
    There are 3 partitions in the CF card. The 1st is the fat12. The 2st
is swap and the 3rd is the root. Kernel command line: console=ttyS0,9600
root=/dev/sysace3 rw
    Did someone have the problem? Any hints will be appreciable.

Thanks!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
