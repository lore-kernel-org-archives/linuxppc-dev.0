Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0CC6CDDDF6
	for <linuxppc-dev@ozlabs.org>; Sun,  3 May 2009 12:41:30 +1000 (EST)
Date: Sat, 2 May 2009 22:41:26 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: unexpected non-allocatable section
Message-ID: <20090502224126.641c63bf@lappy.seanm.ca>
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

Latest pull from Linus' git.

Cheers,
   Sean

WARNING: vmlinux.o (.text): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

WARNING: vmlinux.o (.head.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.init.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.ref.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.cpuinit.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.sched.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.meminit.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.exit.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.devexit.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.devinit.text): unexpected non-allocatable section.
WARNING: vmlinux.o (.rodata): unexpected non-allocatable section.
WARNING: vmlinux.o (__param): unexpected non-allocatable section.
WARNING: vmlinux.o (__ksymtab): unexpected non-allocatable section.
WARNING: vmlinux.o (__ksymtab_strings): unexpected non-allocatable section.
WARNING: vmlinux.o (.rodata.str1.4): unexpected non-allocatable section.
WARNING: vmlinux.o (__bug_table): unexpected non-allocatable section.
WARNING: vmlinux.o (__ksymtab_gpl): unexpected non-allocatable section.
WARNING: vmlinux.o (.init.ramfs): unexpected non-allocatable section.
WARNING: vmlinux.o (__ex_table): unexpected non-allocatable section.
WARNING: vmlinux.o (.kprobes.text): unexpected non-allocatable section.
WARNING: vmlinux.o (__ftr_alt_97): unexpected non-allocatable section.
WARNING: vmlinux.o (__ftr_fixup): unexpected non-allocatable section.
WARNING: vmlinux.o (.rodata.cst4): unexpected non-allocatable section.
WARNING: vmlinux.o (.fixup): unexpected non-allocatable section.
WARNING: vmlinux.o (.data): unexpected non-allocatable section.
WARNING: vmlinux.o (.init.setup): unexpected non-allocatable section.
WARNING: vmlinux.o (.init.data): unexpected non-allocatable section.
WARNING: vmlinux.o (.data.read_mostly): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcallrootfs.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall3.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.data.page_aligned): unexpected non-allocatable section.
WARNING: vmlinux.o (.data.init_task): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall6.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall4.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.cpuinit.data): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall2.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.con_initcall.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall7.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.machine.desc): unexpected non-allocatable section.
WARNING: vmlinux.o (.data.cacheline_aligned): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcallearly.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall1.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall5.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.ref.data): unexpected non-allocatable section.
WARNING: vmlinux.o (.meminit.data): unexpected non-allocatable section.
WARNING: vmlinux.o (.exitcall.exit): unexpected non-allocatable section.
WARNING: vmlinux.o (.init.rodata): unexpected non-allocatable section.
WARNING: vmlinux.o (.devinit.data): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall0.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.initcall7s.init): unexpected non-allocatable section.
WARNING: vmlinux.o (.sdata): unexpected non-allocatable section.
