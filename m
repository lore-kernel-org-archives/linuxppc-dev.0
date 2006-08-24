Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B0E3767D79
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 04:39:40 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1GGK7B-0001N5-00
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 20:39:41 +0200
Date: Thu, 24 Aug 2006 20:39:41 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [2.6.18-rc2] Oops in load_elf_binary...
Message-ID: <Pine.LNX.4.60.0608242032030.4558@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

my Kurobox crashes randomly at startup with

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k init
Oops: Exception in kernel mode, sig: 4 [#1]
NIP: 00000388 LR: C008D464 CTR: C003D5A0
REGS: c044fc30 TRAP: 0700   Not tainted  (2.6.18-rc2-kuroboxHG)
MSR: 00081002 <ME>  CR: 24048448  XER: 20000000
TASK = c0449b40[1] 'init' THREAD: c044e000
GPR00: 0000092F C044FCE0 C0449B40 00000000 00000930 00000000 100196CC 10000000
GPR08: 00000930 00009032 00001002 0044FCE0 C000FD9C 1003B600 10019E6C 100196D0
GPR16: C05B38E0 C044FEC0 10000000 00000001 00000007 C05A77C0 00000001 00000000
GPR24: C06A8D00 C0250000 00000000 100193A0 C059C200 00000000 C05B39C0 C06AA980
NIP [00000388] 0x388
LR [C008D464] padzero+0x50/0x9c
Call Trace:
[C044FCE0] [00101877] 0x101877 (unreliable)
[C044FDA0] [00000000] 0x0
[C044FDB0] [C008DD2C] load_elf_binary+0x7c0/0x12d8
[C044FE50] [C0069AC8] search_binary_handler+0x84/0x260
[C044FE70] [C0069DE0] do_execve+0x13c/0x1ec
[C044FE90] [C000BEBC] sys_execve+0x58/0x94
[C044FEB0] [C0004220] ret_from_syscall+0x0/0x38
[C044FF70] [C0070974] sys_dup+0x24/0x3c
[C044FF80] [C00038EC] init+0x1bc/0x2e4
[C044FFF0] [C0006554] kernel_thread+0x44/0x60
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..

What can it be? IDE?

Thanks
Guennadi
---
Guennadi Liakhovetski
