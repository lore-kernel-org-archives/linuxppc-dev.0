Message-Id: <200403311110.FAA01298@lists.linuxppc.org>
Date: Wed, 31 Mar 2004 19:11:12 +0800
From: "jeffy" <leo_guo@jisung.cn>
To: "linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Wolfgang Denk" <wd@denx.de>
Subject: Boot problems on MPC8250!!!
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all:
 I am porting U-BOOT and PPCLinux to my MPC8250 board, now when UBOOT
boots up and it can runs serveral steps, after the entry "serial_init()"
in board_init_f(), it hangs! I add a "serial_puts("***")" at
the end serial_init(), it can print out, and in UBOOT, the next
entry after "serial_init" should be "console_init_f", so I and a
"serial_puts("aaaa")" at the begin of "console_init_f", it don't print
out! (the soft watch dog is disabled), why about this?

	Thanks a lot!
	Best Regards!

jeffy
leo_guo@jisung.cn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
