Return-Path: <Behre.Frederik@litef.de>
Received: from proxy03.litef.de (mail.litef.de [193.101.168.104])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FD3767B19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 23:19:12 +1000 (EST)
Received: from frmx1.litef.de (localhost [127.0.0.1])
	by proxy03.litef.de (8.12.6/8.12.6/litef) with ESMTP id k4UCkL7v029189
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 May 2006 14:46:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8270 on Microsys PM827 Kernel 2.6 Oops: kernel access of bad area,
	sig: 11 [#1]
Date: Tue, 30 May 2006 14:46:21 +0200
Message-ID: <CC692F5386B0AA47A62B7484A7CA2B6D02B52CB0@frmx1.litef.de>
From: "Behre, Frederik - LT" <Behre.Frederik@litef.de>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello=20

I compile my kernel with=20
pm82x_deconfig and PCI disabled.

Did I forgot something ??

After error Oops: kernel access of bad area, sig: 11 [#1] the Board
restarts.

Thanks for Helping

Freddy


U-Boot 1.1.4 (May 15 2006 - 09:13:13)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 2.5x, VCO Div 4, 60x Bus Freq  20-60 , Core Freq
50-120
 - dfbrg 0, corecnf 0x11, busdf 3, cpmdf 1, plldf 0, pllmf 3, pcidf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk  100000000
 - cpu_clk  250000000, cpm_clk  200000000, bus_clk  100000000

CPU:   MPC8260 (HiP7 Rev 13, Mask 0.1 1K49M) at 250 MHz
Board: PM828
I2C:   ready
DRAM:  (60x:9COL) 128 MB
FLASH: 32 MB
In:    serial
Out:   serial
Err:   serial
DOC:   No DiskOnChip found
Net:   FCC1 ETHERNET, FCC2 ETHERNET
BEDBUG:ready
Hit any key to stop autoboot:  0
Using FCC1 ETHERNET device
TFTP from server 192.168.0.1; our IP address is 192.168.0.2
Filename 'uImage-2.6'.
Load address: 0x400000
Loading:
#################################################################
=20
#################################################################
         #######################################################
done
Bytes transferred =3D 945041 (e6b91 hex)
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.14
   Created:      2006-05-30   7:59:00 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    944977 Bytes =3D 922.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.14 (root@c3415) (gcc version 4.0.0 (DENX ELDK 4.0
4.0.0)) #1 Tue May 30 09:58:59 CEST 2006=20
Microsys PM82x PowerPC port=20
Built 1 zonelists Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.0.1:/lop/eldk400/ppc_6xx/ console=3DttyCPM1
ip=3D192.168.0.2:192.168.0.1:192.168.0.1:255.255.255.0:ppc_82xx::off
panic=3D1
PID hash table entries: 1024 (order: 10, 16384 bytes)=20
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)=20
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 127744k available (1556k kernel code, 384k data, 100k init, 0k
highmem)
Mount-cache hash table entries: 512
softlockup thread 0 started up.
NET: Registered protocol family 16
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a80 (irq =3D 4) is a CPM UART
ttyCPM1 at MMIO 0xf0011a90 (irq =3D 5) is a CPM UART
ttyCPM2 at MMIO 0xf0011a00 (irq =3D 40) is a CPM UART
ttyCPM3 at MMIO 0xf0011a20 (irq =3D 41) is a CPM UART
ttyCPM4 at MMIO 0xf0011a40 (irq =3D 42) is a CPM UART
ttyCPM5 at MMIO 0xf0011a60 (irq =3D 43) is a CPM UART=20
io scheduler noop registered=20
io scheduler anticipatory registered=20
io scheduler deadline registered=20
io scheduler cfq registered=20
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=20
NFTL driver: nftlcore.c $Revision: 1.97 $, nftlmount.c $Revision: 1.40 $
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0107A14 LR: C0106660 SP: C036FE30 REGS: c036fd80 TRAP: 0300    Not
tainted
MSR: 00003032 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 20000000
TASK =3D c0349ae0[1] 'swapper' THREAD: c036e000 Last syscall: 120
GPR00: C036FE38 C036FE30 C0349AE0 C7CD5EE0 C036FE68 00002AA8 C9002AA8
00AA00AA
GPR08: 00AA00AA C036FE40 00009032 00001032 00AA00AA FFFDFFB7 07FFC000
00000001
GPR16: 00800000 07FFF7BC C0180000 00000000 07FF9484 00000000 07FAE1C0
00000001
GPR24: C036FE58 00000000 C7CD5EE0 C01F0000 C7CD5EE0 C01C4BF4 C036FF18
C036FE68
Call trace: [0000000d]  [c0106104]  [c010637c]  [c01011ec]  [c01e1ed4]
[c00039e8]  [c0006b84] Kernel panic - not syncing: Attempted to kill
init!
 <0>Rebooting in 1 seconds..=20
