Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <sbc5507b.064@siemens.com.br>
Date: Thu, 11 Oct 2001 07:55:12 -0300
From: "PAULO SELEME CORREA PAULO" <paulo.correa@siemens.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: hard hat kernel problems when booting with a rpx classic board
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got the follwing problem when trying to boot a rpx classic(ppc860) board with the Hard Hat 2.0,
Oops: kernel access of bad area, sig: 11. Does anyone know what is happenning?
 I am showing the Terminal messages below.
Any help will be wellcome!

 Thank you very much

Hit any key to stop autoboot:  0
ARP broadcast 1
invalid RARP header
ARP broadcast 2
TFTP from server xxx.xxx.xxx.xxx; our IP address is xxx.xxx.xxx.xxx
Filename 'vmlinux'.
Load address: 0x100000
Loading: #################################################################
         #########################################
done
Bytes transferred = 538527 (8379f hex)
## Booting image at 00100000 ...
   Image Name:   Linux2.4.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    538463 Bytes = 525 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.2_hhl20 (root@localhost.localdomain) (gcc version 2.95.3 20010
315 (release/MontaVista)) #6 Tue Oct 9 15:25:21 BRST 2001
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=xxx.xxx.xxx.xxx: ip=xxx.xxx.xxx.xxx:
129.214.72.227:::::off
Decrementer Frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 14608k available (956k kernel code, 436k data, 68k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9626kB/3208kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:10:ec:00:26:40
eth1: FEC ENET Version 0.2, FEC irq 3, addr 00:10:ec:80:26:40
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
Oops: kernel access of bad area, sig: 11
NIP: C00B1620 XER: 80008E7F LR: C00B3484 SP: C01F1C70 REGS: c01f1bc0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 901F0094, DSISR: 0000000A
TASK = c01f0000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 007E29C2 C01F1C70 C01F0000 C0FF7120 FFFFFFFF 81D64349 00000000 00000002
GPR08: 00000200 C0140000 901F0018 C0140000 000927C0 FBFFFDFF 00FFCB00 007FFF51
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 000000A6 0000012B C01301F0
GPR24: 0000012C C01F5ED4 C01F5E00 C01F5E00 81D64349 00000000 C0FF7120 FFFFFFFF
Call backtrace:
001F1D20 C00B3484 C00A93FC C00157DC C00028D0 C0010824 C013B164
C013B3A8 C013BB20 C0131804 C01318A4 C00023F8 C0004F00
Kernel panic: Aiee, killing interrupt handler

In interrupt handler - not syncing
Rebooting in 180 seconds..

Paulo Seleme Correa / ICN EN DEA
Telefone: +55 (41) 341-6311; Fax: +55 (41) 341-5594
paulo.correa@siemens.com.br (GroupWise: OP7648)
Siemens Ltda.
Rua Pedro Gusso, 2635 - CIC
81310-900 Curitiba - PR - Brasil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
