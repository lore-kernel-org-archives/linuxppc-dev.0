Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020808132013.14581.qmail@sina.com>
From: ssx761221 <ssx761221@sina.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: what 's Kernel stack overflow?
MIME-Version: 1.0
Date: Thu, 08 Aug 2002 21:20:13 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


on our custom MPC823e board, running kernel is linux-2.4.4-2002-03-21.tar.bz2,
which is downloaded at denx's ftp.  we have ported qt-embedded-free-3.0.5.
"hello" demo works well at first, but  it died after running about one hour.
Not only that demo but also the whole system .
  messages like this:

Oops: kernel access of bad area, sig: 11
NIP: C0032C00 XER: 80002149 LR: C0031C78 SP: C1AD8720 REGS: c1ad8670 TRAP: 0300 MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000026, DSISR: 0000000B
TASK = c1ad8000[94] 'hello' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: C00025DC C1AD8720 C1AD8000 00000001 30018000 00000016 0000000A 0F727AA8
GPR08: 1000669D 00000001 C0031C5C 0000001E 35033153 1001ED80 00000000 100C8450
GPR16: 100B0010 00000000 00000000 00000000 00009032 01AD8740 00000000 C0002860
GPR24: C0002580 00000001 1000669D 00000016 30018000 00000016 0F734920 00000016
Call backtrace:
00000000 C00025DC 00000148 0F847D60 0F67A4E4 0F67A3F0 0F67A7E0
0F847C58 0F67B13C 0F847DC0 0F656364 0F65F6E0 100049B8 10005ECC
0FBE7E9C 0FBE7DAC 0FAF1A2C 0FC05064 0FBA4250 0FBA4048 0FB209D4
0FB1EE1C 0FBA5A5C 0FB1EA34 10003C84 0F626DBC 00000000
Kernel stack overflow in process c1ad8000, r1=c1ad8450
NIP: C0004744 XER: 80002149 LR: C0018320 SP: C1AD8450 REGS: c1ad83a0 TRAP: 0500 MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1ad8000[94] 'hello' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: C001831C C1AD8450 C1AD8000 00009032 0000000F 00000001 C0170000 C0170000
GPR08: 00000000 00000000 C0170000 00000000 FFFFFFFF 1001ED80 00000000 100C8450
GPR16: 100B0010 00000000 00000000 00000000 00001032 01AD84C0 00000000 C0002858
GPR24: C00038FC 00000000 00030001 0000000B C0160000 00000000 C0170000 0000005B
Call backtrace:
C001831C C0014270 C0014120 C0013F38 C0002888 C0002A08 C000A398
C000A260 C0002860 00000000 C00025DC 00000148 0F847D60 0F67A4E4
0F67A3F0 0F67A7E0 0F847C58 0F67B13C 0F847DC0 0F656364 0F65F6E0
100049B8 10005ECC 0FBE7E9C 0FBE7DAC 0FAF1A2C 0FC05064 0FBA4250
0FBA4048 0FB209D4 0FB1EE1C 0FBA5A5C 0FB1EA34
Kernel panic: kernel stack overflow
In interrupt handler - not syncing
Rebooting in 180 seconds..

 what's the meaning of "kernel stack overflow"
 memory leak?

thanks adance!


______________________________________

===================================================================
新浪免费电子邮箱 (http://mail.sina.com.cn)
新浪分类信息：二手市场走一走，该出手时就出手！ (http://classad.sina.com.cn/2shou/)
和心爱的人养个宝宝，体验浪漫的虚拟历程! (http://simbaby.sina.com.cn)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
