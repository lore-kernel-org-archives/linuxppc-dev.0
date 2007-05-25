Return-Path: <bounces@nabble.com>
Message-ID: <4633901.89021180076707118.JavaMail.nabble@isper.nabble.com>
From: angelalinyao@163.com
To: Linuxppc-embedded@ozlabs.org
Subject: console problem while initializing form ramdisk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2007 00:05:07 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,all
    I am trying to run linux2.6 on Xilinx ML403.I have builded and loaded zImage.initrd.elf successfully into the board and when the kernel was booting to the point initializing form ramdisk,I got the problem as follow.

loaded at:     00400000 0063213C                                
board data at: 00630124 0063013C                                
relocated to:  004050E8 00405100                                
zimage at:     004058B9 004C645D                                
initrd at:     004C7000 0062FE44                                
avail ram:     00633000 04000000                                

Linux/PPC load: console=ttyS0,9600 root=/dev/ram rw                                                   
Uncompressing Linux...done.                           
Now booting the kernel                      
Linux version 2.6.17-rc4-smp (linyao@linux-177) (gcc version 3.3.1 (MontaVista 3                                                                                
.3.1-3.0.10.0300532 2003-12-24)) #4 Fri May 25 11:29:41 CST 2007                                                                
Xilinx ML403 Reference System (Virtex-4 FX)                                           
Built 1 zonelists                 
Kernel command line: console=ttyS0,9600 root=/dev/ram rw                                                        
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000                                                 
PID hash table entries: 512 (order: 9, 2048 bytes)                                                  
Console: colour dummy device 80x25                                  
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)                                                             
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)                                                            
Memory: 61420k available (1240k kernel code, 716k data, 84k init, 0k highmem)                                                                             
Security Framework v1.0.0 initialized                                     
Mount-cache hash table entries: 512                                   
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd                                                                               
Freeing initrd memory: 1443k freed                                  
VFS: Disk quotas dquot_6.5.1                            
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 1) is a 16450
RAMDISK driver initialized: 1 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 84k init
Warning: unable to open an initial console.

      I configured bootloader like this:
[*]Default bootloader kernel arguments
(console=ttyS0,9600 root=dev/ram rw)Initial kernel command string

      I don't know where the problem comes from and how to solve it.
      Any help from you is appreciated.Thank you!
                                                                                                                         linyao
