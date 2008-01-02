Return-Path: <kernelppc@gmail.com>
From: "mojtaba" <kernelppc@gmail.com>
To: <Linuxppc-embedded@ozlabs.org>
Subject: File system problem
Date: Wed, 2 Jan 2008 19:50:13 +0100
Message-ID: <003501c84d70$500e27c0$f02a7740$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,

I am trying to boot a root file system build by buildroot. But I got this
error" init has generated signal 11 but has no handler for it".

My kernel version is 2.6.24-rc3
My target system is PPC 405 (XILINX VIRTEX II pro) I am using the 26-12-2007
snapshot of buildroot.

This is what I get on terminal:

loaded at:     00400000 004CE1A0                                
board data at: 004CC120 004CC19C                                
relocated to:  0040405C 004040D8                                
zimage at:     00404E94 004CB08A                                
avail ram:     004CF000 10000000                                

Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2 init=/bin/sh

Uncompressing Linux...done.                           
Now booting the kernel                      
Linux version 2.6.24-rc3 (mojtaba@ubuntu2) (gcc version 4.2.2) #1 Wed Jan 2
14:3

7:58 CET 2008             
Xilinx ML300 Reference System (Virtex-II Pro)

Zone PFN ranges:                
  DMA             0 ->    65536                               
  Normal      65536 ->    65536                               
  HighMem     655                
Movable zone start PFN for each node                                    
early_node_map[1] active PFN ranges                                   
    0:        0 ->    65536                           
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024

Kernel command line: console=ttyS0,9600 root=/dev/xsa2 init=/bin/sh

Xilinx INTC #0 at 0x41200000 mapped to 0xEF5FE000

PID hash table entries: 1024 (order: 10, 4096 bytes)

Console: colour dummy device 80x25                                  
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)

Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)

Memory: 258048k available (1288k kernel code, 436k data, 76k init, 0k
highmem)

Mount-cache hash table entries: 512                                   
net_namespace: 64 bytes                       
NET: Registered protocol family 16                                  
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy

Call Trace:           
[cfc1fe20] [c0008148] show_stack+0x58/0x188 (unreliable)

[cfc1fe68] [c0038908] set_fail+0x50/0x68

[cfc1fe80] [c0038f7c] sysctl_check_table+0x65c/0x6ac

[cfc1fee8] [c0038f8c] sysctl_check_table+0x66c/0x6ac

[cfc1ff50] [c0026c58] register_sysctl_table+0x64/0xb4

[cfc1ff68] [c019ed4c] register_ppc_htab_sysctl+0x18/0x2c
[cfc1ff70] [c019b228] kernel_init+0x104/0x290 [cfc1fff0] [c0004af8]
kernel_thread+0x44/0x60 io scheduler noop registered io scheduler
anticipatory registered io scheduler deadline registered io scheduler cfq
registered (default) Generic RTC Driver v1.07 Macintosh non-volatile memory
driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 2) is a 16550A console [ttyS0]
enabled xsysace xsysace.0: Xilinx SystemACE revision 1.0.12 xsysace
xsysace.0: capacity: 1981728 sectors
 xsa: xsa1 xsa2 xsa3
Xilinx SystemACE device driver, major=254
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 76k init
Warning: unable to open an initial console.
init has generated signal 11 but has no handler for it Kernel panic - not
syncing: Attempted to kill init!
Rebooting in 180 seconds..


Regards,
Mojtaba
