Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 140F2DDFDD
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:19:21 +1000 (EST)
Date: Mon, 21 Jul 2008 12:18:29 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Networkl problems with lastest kernel....
Message-ID: <20080721121829.28faffab@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just did a git pull of Linus' kernel. It seems to be mainly network
changes... and I get the following oops. Anybody else seeing this?

I really don't have time to look at the problem right now, maybe
tonight.

Cheers,
   Sean

------------[ cut here ]------------
Kernel BUG at c01ba650 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
Warp
Modules linked in:
NIP: c01ba650 LR: c015e240 CTR: c0011f84
REGS: cf821d60 TRAP: 0700   Not tainted  (2.6.26-pika)
MSR: 00029000 <EE,ME>  CR: 44000082  XER: 0000005f
TASK = cf81f900[1] 'swapper' THREAD: cf820000
GPR00: 00000000 cf821e10 cf81f900 c02fd5a8 80000000 c0010684 00000000
ffffffff GPR08: c02fd5a8 00000001 00000000 00000001 24000028 00000000
00000004 c02a0000 GPR16: 00400684 00800000 c02e0000 c0270000 c02e0000
c02e0000 c03206c0 00000001 GPR24: c02e0000 cf984000 cf984438 cf984380
00029000 00000000 cf9843d0 cf984000 NIP [c01ba650]
__netif_schedule+0x28/0x84 LR [c015e240] emac_open+0x3d8/0x470
Call Trace:
[cf821e10] [cf984000] 0xcf984000 (unreliable)
[cf821e30] [c015e240] emac_open+0x3d8/0x470
[cf821e60] [c01bc2b4] dev_open+0xa8/0x118
[cf821e80] [c01bc1b4] dev_change_flags+0x168/0x1c0
[cf821ea0] [c02d3e48] ip_auto_config+0x19c/0xecc
[cf821f60] [c02ba83c] kernel_init+0x84/0x274
[cf821ff0] [c000c518] kernel_thread+0x48/0x64
Instruction dump:
4e800020 4bfffe48 7c0802a6 3d60c030 9421ffe0 396bd5a8 90010024 bfa10014 
7c681b78 7c6b5a78 200b0000 7d605914 <0f0b0000> 39200002 38030024
7d600028 ---[ end trace be4338b61948e802 ]---
