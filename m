Subject: rpx8260_defconfig problems
From: Jeff Angielski <jeff@theptrgroup.com>
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1091647026.4233.95.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 04 Aug 2004 15:17:06 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Doing a bk pull on the latest linuxppc-2.4 says that as of July 2004,
support for the Embedded Planet EP8260 was working.  However, using the
default rpx8260_defconfig will not work on my board.

I get no output on my serial console.  When I look at the log_buf using
the BDI, the last message I see is "Warning: real time clock seems
stuck".

If I trace through the instructions using the BDI, I see the kernel in
the time related functions - timer_interrupt(), do_timer(),
update_process_times(), etc.  Not sure what that means yet but it's more
to chew on.

Incidentally, I went back and tried booting Linux with the PlanetCore
bootloader that came with the board.  It had the same problem so I am
hesitant to blame the problem on my version of u-boot.

So my questions are:

1) Does anybody else have the EP8260 working with their linux?

2) If so, which kernel are you using?  linuxppc-2.4?  Denx
linuxppc_2_4_devel?  kernel.org?

Thanks,
Jeff Angielski


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
