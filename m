From: t.shantha.laxmi@exgate.tek.com
Message-ID: <21F9768AF088D211BF1C0008C71E5786EEFF62@ap-bang-m02.india.tek.com>
To: erammsu@kieraypc01.p.y.ki.era.ericsson.se, thomas.eisenzopf@siemens.at
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: crash loadin bash after booting linux on a MPC860ADS
Date: Tue, 16 May 2000 05:49:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I was facing similar problem when I tried to load the Linux kernel 2.2.13
into 860ADS- Rev B board. I have put the patches that you have mentioned in
your mails. I am using the bootrom and kernel from the site:
http://www.s4l.de/powerpc.html. I have also put the ADS patches suggested
there. The kernel is crasing with the following messages:

:> mbootz fe00f400
Booting kernel at 0xfe01f400
loaded at:     FE01F400 FE02A5CC
relocated to:  00100000 0010B1CC
board data at: 007F0000 007F001C
relocated to:  00200100 0020011C
zimage at:     FE025400 FE086B01
avail ram:     00201000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (root@mickey.india.tek.com) (gcc version 2.95.2
19991024 (r
elease)) #26 Tue May 16 17:40:06 IST 2000
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 43.93 BogoMIPS
Memory: 15188k available (716k kernel code, 440k data, 40k init)
[c0000000,c1000
000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Initializing RT netlink socket
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
ttyS02 at 0x03e8 (irq = 4) is a 16450
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 00:00:11:01:c4:96
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
IP-Config: Guessing netmask 255.255.255.0
Root-NFS: Mounting /project/downloads/linux/export on server 192.158.104.71
as r
oot
Root-NFS:     rsize = 4096, wsize = 4096, timeo = 7, retrans = 3
Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
Looking up port of RPC 100003/2 on 192.158.104.71
Root-NFS: Portmapper on server returned 2049 as nfsd port
Looking up port of RPC 100005/1 on 192.158.104.71
Root-NFS: mountd port is 649
NFS:      nfs_mount(c09e6847:/project/downloads/linux/export)
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 40k init
page fault in interrupt handler, addr=c0002578
NIP: C005EE64 XER: 0000B86D LR: C005EE44 REGS: c00c99c0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00c7c90[0] 'swapper' mm->pgd c00c6000 Last syscall: 112
last math 00000000
GPR00: C0069248 C00C9A70 C00C7C90 C01EB360 00008000 C00D073C C01D7032
C09E6854
GPR08: C00CAEC0 4C00012B C00CAE8C C00E7BDC 240FF044 00000000 FE000000
FE000000
GPR16: FE000000 FE000000 FE000000 FE000000 00001032 000C9A90 00000000
C0002564
GPR24: C00043F0 C00F2FF8 0000FFFE C00E0000 00000800 C00E7BDC C00D073C
C0002570
NIP: C005EE64 XER: 0000B86D LR: C005EE44 REGS: c00c99c0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00c7c90[0] 'swapper' mm->pgd c00c6000 Last syscall: 112
last math 00000000
GPR00: C0069248 C00C9A70 C00C7C90 C01EB360 00008000 C00D073C C01D7032
C09E6854
GPR08: C00CAEC0 4C00012B C00CAE8C C00E7BDC 240FF044 00000000 FE000000
FE000000
GPR16: FE000000 FE000000 FE000000 FE000000 00001032 000C9A90 00000000
C0002564
GPR24: C00043F0 C00F2FF8 0000FFFE C00E0000 00000800 C00E7BDC C00D073C
C0002570
Call backtrace:
C0014ED0 C00025CC C00178F4 C00044DC C0004508 C00022D8 C00D0000
C00D773C C000221C
Kernel panic: kernel access of bad area pc c005ee64 lr c005ee44 address
C0002578
 tsk swapper/0
In swapper task - not syncing
Rebooting in 180 seconds..

Any help on this would be greatly appreciated.

Thanks in advance,
- Shantha

-> -----Original Message-----
-> From: Marcus Sundberg
-> [mailto:erammsu@kieraypc01.p.y.ki.era.ericsson.se]
-> Sent: Tuesday, April 04, 2000 10:20 PM
-> To: Eisenzopf Thomas
-> Cc: 'linuxppc-embedded@lists.linuxppc.org'
-> Subject: Re: crash loadin bash after booting linux on a MPC860ADS
->
->
->
-> Eisenzopf Thomas <thomas.eisenzopf@siemens.at> writes:
->
-> > Hello,
-> >
-> > thanks again for the suggestions from some members of this
-> mailing list. I
-> > managed to reconfigure my kernel and now I can boot linux
-> until the NFS root
-> > filesystem is mounted.
-> >
-> > But after this the kernel tries to load the shell /bin/sh
-> from NFS, at this
-> > point the system crashes. My kernel includes the patches from
-> > www.s4l.de/powerpc.html.
-> >
-> > Please, can anyone help? I took the ramdisk.image.gz
-> filesystem from
-> > www.s4l.de/powerpc.html. This should be working for
-> PowerPC(?). On the other
-> > hand I tried to get my own filesystem (crosscompile bash,
-> ...), but it
-> > didn´t work. Perhaps someone could support me with a
-> tarball of a filesystem
-> > working on a MPC860ADS board with NFS root filesystem? How
-> can I make a
-> > filesystem on my own (on an Intel PC)?
-> >
-> >
-> > 8xxROM 0.3.0
-> >
-> > compiletime options:
-> > board: ADS DRAM_50MHZ
-> > disk: DISK_ROM
-> >
-> > cpu: XPC860xxZPnnA3 at 48 MHz: 4Kbyte icache 4Kbyte dcache
-> >
-> > <warning: cpu core has silicon bugs, check the errata>
->
-> Well, guess you didn't do this...
-> Either put your CPU on a hard surface, apply a sledgehammer to it,
-> and get a new(er) one. ;)
-> Or apply the following diff and see if things get better:
->
-> diff -u -r1.2 -r1.3
-> --- head.S	2000/01/11 18:13:31	1.2
-> +++ head.S	2000/01/11 18:27:59	1.3
-> @@ -883,11 +886,26 @@
->   * only perform the attribute functions.
->   */
->  InstructionTLBMiss:
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	stw	r3, 8(r0)
-> +	li	r3, M_TW_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
->  	mtspr	M_TW, r20	/* Save a couple of working registers */
->  	mfcr	r20
->  	stw	r20, 0(r0)
->  	stw	r21, 4(r0)
->  	mfspr	r20, SRR0	/* Get effective address of fault */
-> +	li	r3, MD_EPN_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#else /* NO_MPC8xxBUG_CPU6 */
-> +	mtspr	M_TW, r20	/* Save a couple of working registers */
-> +	mfcr	r20
-> +	stw	r20, 0(r0)
-> +	stw	r21, 4(r0)
-> +	mfspr	r20, SRR0	/* Get effective address of fault */
-> +#endif /* NO_MPC8xxBUG_CPU6 */
->  	mtspr	MD_EPN, r20	/* Have to use MD_EPN for walk,
-> MI_EPN can't */
->  	mfspr	r20, M_TWB	/* Get level 1 table entry address */
->  	lwz	r21, 0(r20)	/* Get the level 1 entry */
-> @@ -899,8 +917,19 @@
->  	 */
->  	tophys(r21,r21,0)
->  	ori	r21,r21,1		/* Set valid bit */
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	li	r3, MI_TWC_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +	mtspr	MI_TWC, r21	/* Set page attributes */
-> +	li	r3, MD_TWC_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +	mtspr	MD_TWC, r21	/* Load pte table base address */
-> +#else
->  	mtspr	MI_TWC, r21	/* Set page attributes */
->  	mtspr	MD_TWC, r21	/* Load pte table base address */
-> +#endif /* NO_MPC8xxBUG_CPU6 */
->  	mfspr	r21, MD_TWC	/* ....and get the pte address */
->  	lwz	r21, 0(r21)	/* Get the pte */
->
-> @@ -920,18 +949,29 @@
->  	 */
->  	ori	r20, r21, 0x00f0
->
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	li	r3, MI_RPN_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#endif
->  	mtspr	MI_RPN, r20	/* Update TLB entry */
->
->  	mfspr	r20, M_TW	/* Restore registers */
->  	lwz	r21, 0(r0)
->  	mtcr	r21
->  	lwz	r21, 4(r0)
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	lwz	r3, 8(r0)
-> +#endif
->  	rfi
->
->  2:	mfspr	r20, M_TW	/* Restore registers */
->  	lwz	r21, 0(r0)
->  	mtcr	r21
->  	lwz	r21, 4(r0)
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	lwz	r3, 8(r0)
-> +#endif
->  	b	InstructionAccess
->  #endif /* CONFIG_8xx */
->
-> @@ -1009,6 +1049,12 @@
->  	b	00b			/* Try lookup again */
->  #endif /* NO_RELOAD_HTAB */
->  #else /* CONFIG_8xx */
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	stw	r3, 8(r0)
-> +	li	r3, M_TW_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#endif
->  	mtspr	M_TW, r20	/* Save a couple of working registers */
->  	mfcr	r20
->  	stw	r20, 0(r0)
-> @@ -1022,6 +1068,11 @@
->  	 */
->  	tophys(r21, r21, 0)
->  	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	li	r3, MD_TWC_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#endif
->  	mtspr	MD_TWC, r21	/* Load pte table base address */
->  	mfspr	r21, MD_TWC	/* ....and get the pte address */
->  	lwz	r21, 0(r21)	/* Get the pte */
-> @@ -1042,18 +1093,29 @@
->  	 */
->  	ori	r20, r21, 0x00f0
->
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	li	r3, MD_RPN_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#endif
->  	mtspr	MD_RPN, r20	/* Update TLB entry */
->
->  	mfspr	r20, M_TW	/* Restore registers */
->  	lwz	r21, 0(r0)
->  	mtcr	r21
->  	lwz	r21, 4(r0)
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	lwz	r3, 8(r0)
-> +#endif
->  	rfi
->
->  2:	mfspr	r20, M_TW	/* Restore registers */
->  	lwz	r21, 0(r0)
->  	mtcr	r21
->  	lwz	r21, 4(r0)
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	lwz	r3, 8(r0)
-> +#endif
->  	b	DataAccess
->  #endif /* CONFIG_8xx */
->
-> @@ -1086,6 +1148,12 @@
->   */
->  	. = 0x1400
->  DataTLBError:
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	stw	r3, 8(r0)
-> +	li	r3, M_TW_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#endif
->  	mtspr	M_TW, r20	/* Save a couple of working registers */
->  	mfcr	r20
->  	stw	r20, 0(r0)
-> @@ -1106,6 +1174,11 @@
->  	 */
->  	tophys(r21, r21, 0)
->  	ori	r21, r21, 1		/* Set valid bit in
-> physical L2 page */
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	li	r3, MD_TWC_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#endif
->  	mtspr	MD_TWC, r21		/* Load pte table base
-> address */
->  	mfspr	r21, MD_TWC		/* ....and get the pte
-> address */
->  	lwz	r21, 0(r21)		/* Get the pte */
-> @@ -1133,18 +1206,29 @@
->  	 */
->  	ori	r20, r21, 0x00f0
->
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	li	r3, MD_RPN_ADDR
-> +	stw	r3, 12(r0)
-> +	lwz	r3, 12(r0)
-> +#endif
->  	mtspr	MD_RPN, r20	/* Update TLB entry */
->
->  	mfspr	r20, M_TW	/* Restore registers */
->  	lwz	r21, 0(r0)
->  	mtcr	r21
->  	lwz	r21, 4(r0)
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	lwz	r3, 8(r0)
-> +#endif
->  	rfi
->  2:
->  	mfspr	r20, M_TW	/* Restore registers */
->  	lwz	r21, 0(r0)
->  	mtcr	r21
->  	lwz	r21, 4(r0)
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	lwz	r3, 8(r0)
-> +#endif
->  	b	DataAccess
->  #endif /* CONFIG_8xx */
->
-> @@ -2214,7 +2307,19 @@
->          lwz     r9,MM-TSS(r4)           /* Get virtual
-> address of mm */
->          lwz     r9,PGD(r9)              /* get new->mm->pgd */
->          addis   r9,r9,-KERNELBASE@h     /* convert to phys addr */
-> +#ifndef NO_MPC8xxBUG_CPU6
-> +	lis	r6, cmd_line@h
-> +	ori	r6, r6, cmd_line@l
-> +	li	r7, M_TWB_ADDR
-> +	stw	r7, 12(r6)
-> +	lwz	r7, 12(r6)
-> +	mtspr   M_TWB, r9               /* Update MMU base address */
-> +	li	r7, M_CASID_ADDR
-> +	stw	r7, 12(r6)
-> +	lwz	r7, 12(r6)
-> +#else
->          mtspr   M_TWB, r9               /* Update MMU base
-> address */
-> +#endif /* NO_MPC8xxBUG_CPU6 */
->          mtspr   M_CASID, r5             /* Update context */
->          tlbia
->  #endif
->
->
-> //Marcus
-> --
-> Signature under construction, please come back later.
->
-> ** Sent via the linuxppc-embedded mail list. See
-> http://lists.linuxppc.org/
->

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
