Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 0ABAEDDF11
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 14:41:17 +1000 (EST)
Message-ID: <407023539.21267@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 01 Apr 2008 12:18:59 +0800
Subject: Unable to handle kernel paging request for instruction fetch???
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,all,

I run the iperf tool to test the ethernet throughput for my MPC8360E board, after
about 20 minutes, the exception is happened. Could you tell me why? 


Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x4e800020
Oops: Kernel access of bad area, sig: 11 [#1]
MPC836x MDS
Modules linked in: encoder mpc_sync k_spi(P)
NIP: 4e800020 LR: c01a08d4 CTR: 00000000
REGS: ef6e3b10 TRAP: 0400   Tainted: P        (2.6.22)
MSR: 20009032 <EE,ME,IR,DR>  CR: 22848284  XER: 00000000
TASK = c0232810[56] 'iperf' THREAD: ef6e2000
GPR00: 4e800020 ef6e3bc0 c0232810 ef6e1100 00000000 00000000 00000020 00000000 
GPR08: 00000000 c0024570 0c9dcf08 00000000 42848288 1002668c 0fffe000 007fff00 
GPR16: c026c9bc ef6e3e30 c0232810 00000001 00000000 00000000 00000000 00002000 
GPR24: ef6e1160 00000000 00000014 cff213c8 cff213a0 00000020 ef6e1100 00000000 
Call Trace:
[ef6e3bc0] [c0247a00]  (unreliable)
[ef6e3c00] [c01a3af4] 
[ef6e3c20] [c019e8a0] 
[ef6e3c30] [c019efe0] 
[ef6e3c60] [c01a6ad0] 
[ef6e3c80] [c01966a0] 
[ef6e3ca0] [c0196d38] 
[ef6e3d00] [c016a2e8] 
[ef6e3d20] [c0165a14] 
[ef6e3e20] [c0166f44] 
[ef6e3f00] [c01677ec] 
[ef6e3f40] [c000f3e8] 
--- Exception: c01Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..
