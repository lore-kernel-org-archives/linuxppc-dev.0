From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: printk before CPM reset
Date: Mon, 10 Jul 2000 16:39:06 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJAEOLCAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


After decompressing kernel, the first line displayed through the console is ttyS initialization comment.

ttyS00 at 0x0380 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC

in function serial_console_setup in arch/ppc/8xx_io/uart.c.

As above, I use SMC2 for ttyS0. I changed everything and got bash prompt.

Anyway, I heard the first line displayed is the version of the kernel.

I saw the string ,log_buf, stored in memory, and the string begins with 'Linux version 2.2.13 ...'

Is it because CPM is reset just before serial_console_setup? But I changed also bootloader and I can see the comment 'Now booting the kernel' before the kernel booting.

Why can't I get the comment?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
