Message-ID: <3D252776.60ACBA64@procsys.com>
Date: Fri, 05 Jul 2002 10:28:31 +0530
From: Jis Joy <jisjoy@procsys.com>
MIME-Version: 1.0
To: Ppc Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting Linux on Custom PowerPC 405GP board
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Friends,

I am new to Linux, I need help from you friends.

We got a custom PowerPC 405GP board, we want to boot Linux on that.

Board limitations are:
1. There is no network interface, only serial port. The kernel image has

to be  downloaded through the serial port. (network interface will be
added
to this card in future.)
2. The monitor code is also custom one, its no a Walnut ROM monitor.

I found out that the boot loader files are in
/src/linux/arch/ppc/boot/tree directory (Am I  correct ??).
What are the changes I have to make to boot linux.

Will it start booting, if I download the
/src/linux/arch/ppc/boot/image/vmlinux to the 0x00000000 location and
jump to that location ?? (the image is compiled for 405GP processor).

Thanks in advance,
Jis.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
