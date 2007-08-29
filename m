Return-Path: <bounces@nabble.com>
Message-ID: <10801768.2815191188385972143.JavaMail.nabble@isper.nabble.com>
From: angelalinyao@163.com
To: Linuxppc-embedded@ozlabs.org
Subject: linux2.6.17.4 with temac patch running on ML403 hung while
	initializing from ramdisk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Aug 2007 04:12:52 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, all
    I have run linux-xilinx-26.git based on kernel 2.6.17.4 on ML403 successfully.
    Then I used a temac patch  from mvista (PAULUS)
    The system hung while initializing from ramdisk after patched.
    I use plb-temac v3.00a and hard_temac v3.00b, with EDK 9.1
    The message printed is as follow. Any help would be appreciated.
--------------------------------------------------------------------------------------
loaded at:     00400000 0069013C                                
board data at: 0068E124 0068E13C                                
relocated to:  004050E8 00405100                                
zimage at:     004058B9 00527794                                
initrd at:     00528000 0068DE1A                                
avail ram:     00691000 04000000                                

Linux/PPC load: console=ttyS0,9600 root=/dev/ram rw                                                   
Uncompressing Linux...done.                           
Now booting the kernel                      
Linux version 2.6.17-rc4-smp (linyao@linux-177) (gcc version 3.3.1 (MontaVista 3                                                                                
.3.1-3.0.10.0300532 2003-12-24)) #17 Wed Aug 29 16:36:51 CS                                                          
Xilinx ML403 Reference System (Virtex-4 FX)                                           
Built 1 zonelists                 
Kernel command line: console=ttyS0,9600 root=/dev/ram rw                                                        
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000                                                 
PID hash table entries: 512 (order: 9, 2048 bytes)                                                  
Console: colour dummy device 80x25                                  
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)                                                             
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)                                                            
Memory: 60604k available (1428k kernel code, 1352k data, 84k init, 0k highmem)                                                                              
Security Framework v1.0.0 initialized                                     
Capability LSM initial                     
Mount-cache hash table entries: 512                                   
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd                                                                               
Freeing initrd memory: 1431k freed                                  
seclvl: seclvl_init: seclvl: Failure registering with the kernel.
seclvl: seclvl_init: seclvl: Failure registering with primary security module.
seclvl: Error during initialization: rc = [-22]
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.101 (c) Dave Jones
SyncLink PC Card driver $Revision: 4.34 $
SyncLink PC Card driver $Revision: 4.34 $, tty major#253
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 2) is a 16450
RAMDISK driver initialized: 1 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
oprofile: using timer interrupt.
RAMDISK: Compressed image found at block 0
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 84k init
-----------------------------------------------------------------------------------
System hung here.
                                                                                                                             linyao
   
