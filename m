Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F4B390D.1060101@imc-berlin.de>
Date: Tue, 26 Aug 2003 12:40:13 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA Modem/Serial Cards and MPC8xx?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

is someone using a PCMCIA Modem or Serial Port card with an MPC8xx system?

I build a kernel for a TQM860L based board enabeling CONFIG_SERIAL=y
as the PCMCIA HowTo states. (I also have CONFIG_SERIAL_CONSOLE=y). But
while booting (or insmod serial.o) I get :

CPM UART driver version 0.04
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SMC2 at 0x0380, BRG2
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
Oops: kernel access of bad area, sig: 11
NIP: C009FA6C XER: 00000000 LR: C00A4174 SP: C01D7E80 REGS: c01d7dd0
TRAP: 0300    Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 800003F9, DSISR: 00000469
TASK = c01d6000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C01D7E80 C01D6000 C01D7E88 00000001 00000000 C01CC3D8
000003F8
GPR08: 00000000 800003F9 00000000 00000000 00000001 100B0020 C00A37C8
C00A301C
GPR16: C00A1B68 C00A2834 C00A3138 C009FC10 C009FB84 C00A2CAC C00A1C38
C00A1BB0
GPR24: C00A28BC C00A1AE8 C00A1AD0 C0151FD8 C0151FD8 C017C130 C017C1F4
C01D7E88
Call backtrace:
C000FE44 C0161A00 C015B588 C015B5D0 C000227C C0004BA0
Kernel panic: Attempted to kill init!

Backtrace is:
0xc000fe44 -- 0xc000fd78 + 0x00cc   release_console_sem
0xc0161a00 -- 0xc0161630 + 0x03d0   rs_init
0xc015b588 -- 0xc015b558 + 0x0030   do_initcalls
0xc015b5d0 -- 0xc015b5a8 + 0x0028   do_basic_setup
0xc000227c -- 0xc0002268 + 0x0014   init
0xc0004ba0 -- 0xc0004b74 + 0x002c   kernel_thread

Any ideas?

Thanks a million!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
