Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C86ACB3.C7445E95@prodys.net>
Date: Thu, 07 Mar 2002 00:56:35 +0100
From: Andres Chamorro Morillas <achamorro@prodys.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC860 onchip WatchDog
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I trying to use the MPC860 onchip WatchDog.I compile ppcboot-1.1.4
with include/config_MBX.h ( I have a MBX860 board) I compile the
linux-2.4.4-2002-02-14 kernel by denx. I activate the WatchDog support
for
MPC860.Well, I make tftpboot then I tray to boot the
kernel but...
Loading .text @ 0x00180000 (23052 bytes)
Loading .rodata @ 0x00185a10 (2320 bytes)
Loading .data @ 0x00187000 (808bytes)
Loading __ex_table @ 0x00187328 (24 bytes)
## Starting application at 0x00180000...
loaded at:  00210000 0021B59C
relocated to:  00180000 0018B59C
board data at: 043A0288 043A02BC
relocated to:  00200100 00200134
zimage at:  00218000 002A95D8
avail ram:  002AA000 04400000
Linux/PPC load:root=/dev/nfs rw
Uncompressing Linux...done.
Now booting the kernel

And reset.
Thats mean that WD works fine but I can't boot.
What can I do???
Modify the kernel code to service the watchdog????
Which part of kernel I have to modify???
Thanks a lot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
