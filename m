Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020510031854.87945.qmail@web15005.mail.bjs.yahoo.com>
Date: Fri, 10 May 2002 11:18:54 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: Why system panic after sometimes?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,
This question has bothered me,I use linux-2.4.4 (
downloaded from denx.de and porting to our borad
MPC850+4Mflash+32Mram+USB).We run a server application
in borad,but after sometimes such as about a day or
even several hours ,system will panic. I check our
program, i think there are no memory leak(or it will
panic in same time) and other fatal error.
Here is my dump information:

# Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: 00001FFC XER: E0007B7F LR: 0000098C SP: C011AE90
REGS: c011ade0 TRAP: 1000
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0118fe0[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000002 C011AE90 C0118FE0 C011AEA0 0035E000
C18FDDE8 C0118FE0 00000017
GPR08: C0124094 000E711D C18FC000 C014B3E0 30026438
100195BC 94FF7FD7 B97FDD3E
GPR16: DBFFE6E5 028002E8 FA200000 FFFFFFF6 00001032
0011AE90 C000BEDC 00009032
GPR24: 00000000 00000001 C18FC000 0020000D C03E2190
00002000 C03E2190 C011AF50
Call backtrace:
C0003800 00009032 C0003E44 C0003E5C C0128750 C00021E4
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
Rebooting in 180 seconds.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
