Message-ID: <3F8B4516.9060405@frys.com>
Date: Mon, 13 Oct 2003 19:36:38 -0500
From: Jitendra Vegiraju <jvegiraju@frys.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 and compactflash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am trying to add IDE driver support for a custom MPC8260 board that uses
Toshiba reference design for compactFlash interface to 8260.
Anybody used this type of design before?

The key points of interest in this design are,
    -CF is directly connected to 8260 in TRUE IDE mode.
    -The data bits are connected msb(host)-msb(card) and lsb(host)-lsb(card)
    -uses two chip selects for IDE registers(one for normal and one for
alternate regs)
    -The IDE register address ranges are 16 bit wide
    -Interrupt line is connected to PC9.
I am using linux2.4.22 standard kernel.
The problem is, I am not getting any interrupts from the compact flash
device with
this kernel. I do see one interrupt during initial device probing.
The driver still works but very slow(it relies on time out for recovery).
I have checked SIPNR_H register to make sure that there is no pending
interrupt.
I would appreciate any help on this problem.

NOTE:The denx kernel linuxppc_2_4_devel-2.4.20-2002_12_04 is working fine
after making the necessary changes for above mentioned design differences.
I have noticed a lot of changes in 2.4.21 for the IDE code compared to
denx 2.4.20 kernel.
Since we have some PCI code written for the latest kernel we would like
stay with
latest kernel.

Thanks,
Jitendra Vegiraju


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
