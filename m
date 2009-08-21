Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 13AB2B7B95
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 01:23:16 +1000 (EST)
MIME-Version: 1.0
Date: Fri, 21 Aug 2009 11:23:13 -0400
Message-ID: <9e4733910908210823g1743ec7ei8bc80536afc7864f@mail.gmail.com>
Subject: mpc5200, reboots will idle
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've been getting unexplained reboots. This one printed a dump. Does
it make sense to anyone?
The system was just sitting idle at a command prompt.

root@phyCORE:~ Bad trap at PC: c00098f0, SR: 1000, vector=100
Oops: Exception in kernel mode, sig: 5 [#1]
dspeak01
Modules linked in:
NIP: c00098f0 LR: c00098f0 CTR: c000f0bc
git REGS: c040fee0 TRAP: 0100   Not tainted  (2.6.31-rc1-efika)
(actually rc6, commit 894ef820b10d77)
MSR: 00001000 <ME>  CR: 24000028  XER: 20000000
TASK = c03dd3e8[0] 'swapper' THREAD: c040e000
<6>GPR00: 00000000 c040ff90 c03dd3e8 00800000 0090c000 00e00000
cba3e1bd 00049032
<6>GPR08: 00000001 c040e000 24000022 00000002 63694880 10068248
03fbc000 04079000
<6>GPR16: ff7fffbf ffaf7fbf fffeffff f8ffff3f 00003002 03f580b6
00000001 00000000
<6>GPR24: 00000000 03fba97c c0418000 c0410000 c0410000 c0417f2c
00000008 c040e03c
NIP [c00098f0] cpu_idle+0x94/0xd4
LR [c00098f0] cpu_idle+0x94/0xd4
Call Trace:
[c040ff90] [c000992c] cpu_idle+0xd0/0xd4 (unreliable)
[c040ffb0] [c0003e54] rest_init+0x5c/0x88
[c040ffc0] [c03b17c0] start_kernel+0x2a0/0x2b4
[c040fff0] [00003438] 0x3438
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX 7c0000a6 XXXXXXXX XXXXXXXX XXXXXXXX 70090004
XXXXXXXX XXXXXXXX XXXXXXXX 4e800421 XXXXXXXX XXXXXXXX XXXXXXXX 7c00f828
---[ end trace dafbcb51fa4ab255 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Call Trace:
[c040fcf0] [c00088cc] show_stack+0x4c/0x14c (unreliable)
[c040fd30] [c02bda4c] panic+0x8c/0x170
[c040fd80] [c002ab74] do_exit+0x60/0x594
[c040fdc0] [c0011848] kernel_bad_stack+0x0/0x4c
[c040fde0] [c00119e4] _exception+0x58/0x150
[c040fed0] [c0014050] ret_from_except_full+0x0/0x4c
--- Exception: 100 at cpu_idle+0x94/0xd4
    LR = cpu_idle+0x94/0xd4
[c040ff90] [c000992c] cpu_idle+0xd0/0xd4 (unreliable)
[c040ffb0] [c0003e54] rest_init+0x5c/0x88
[c040ffc0] [c03b17c0] start_kernel+0x2a0/0x2b4
[c040fff0] [00003438] 0x3438
Rebooting in 180 seconds..


-- 
Jon Smirl
jonsmirl@gmail.com
