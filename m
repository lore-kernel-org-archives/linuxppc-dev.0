Message-ID: <395B4B6D.4919228B@pop.agri.ch>
Date: Thu, 29 Jun 2000 15:13:17 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: kernel panic: wallstreet cdrom remove 2.4.0-test3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I get a kernel panic when I remove my cdrom from my wallstreet.

 wallstreet kernel: media bay 0 is empty
 wallstreet kernel: Unregistering mb 0 ide, index:1
 wallstreet kernel: NIP: C00AA6DC XER: 00000000 LR: C00E7700 REGS:
c05c3ac0 TRAP: 0300
 wallstreet kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
 wallstreet kernel: TASK = c05c2000[2] 'media-bay' Last syscall: -1
 wallstreet kernel: last math c1d98000 last altivec 00000000
 wallstreet kernel: GPR00: 00000000 C05C3B70 C05C2000 C02B21E4 FFFFFFF4
00000000 C05BDD7C C05BD800
 wallstreet kernel: GPR08: 00000008 C0210000 000005BD 00006000 42828024
1001E8BC 00000000 00000000
 wallstreet kernel: GPR16: 00000000 00000000 C02AB164 C02AB174 000053DE
C05C3B98 C02BCD8D 00000001
 wallstreet kernel: GPR24: 00000002 C02BCAE4 00000000 00000002 C0290000
00000200 C02B21E4 00000000
 wallstreet kernel: Call backtrace:
 wallstreet kernel: C05BD800 C00E7700 C027E500 C027E5A4 C0009A2C
 wallstreet kernel: Kernel panic: kernel access of bad area pc c00aa6dc
lr c00e7700 address 4 tsk media-bay/2

Am I right that this happened in the function blk_cleanup_queue
(C00AA6DC) from drivers/block/ll_rw_blk.c?

Known problem?

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
